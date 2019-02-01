@isTest
private class BillToContactOppControllerTest {

    @TestSetup 
    static void setup(){
        List<Contact> contacts=new List<Contact>();
        Opportunity opp;
        Account account=new Account();
        account.Name='Account';
        Account account1=new Account();
        account1.Name='Account1';
        insert account;
        insert account1;    
        for(Integer i=0;i<10;i++){
            contacts.add(new Contact(LastName='Khatri'+i,Gender__c='Female',AccountId=account.ID));
        }
        insert contacts;
        opp=new Opportunity(Name='Opportunity',Account__c=account.Id,CloseDate=Date.today(),StageName='Closed Won');
        insert opp;
        opp=new Opportunity(Name='Opportunity',Account__c=account1.Id,CloseDate=Date.today(),StageName='Closed Won');
        insert opp;  
    }
    
    @isTest 
    static void testSaveMethod(){
        PageReference page=Page.ManageBillToContact;
       	BillToContactOppController controller=testUtil(page);
        page.getParameters().put('v',controller.contacts.get(1).Id);
        controller.getSelected();
        controller.save();
        List<Opportunity> oppList=[SELECT Id,Account__c,Bill_To_Contact__c FROM Opportunity Limit 1];
        System.assertEquals(oppList.get(0).Bill_To_Contact__c,controller.contacts.get(1).Id);          
    }
    
    @isTest 
    static void testClearMethod(){
        PageReference page=Page.ManageBillToContact;
       	BillToContactOppController controller=testUtil(page);
        controller.clear();
   		List<Opportunity> oppList=[SELECT Id,Account__c,Bill_To_Contact__c FROM Opportunity Limit 1]; 
        System.assertEquals(null,oppList.get(0).Bill_To_Contact__c);
    }
    
    @isTest 
    static void testSaveMethodWhenSelectedIsNull(){
        PageReference page=Page.ManageBillToContact;
       	BillToContactOppController controller=testUtil(page);
        controller.getSelected();
        controller.save(); 
        List<Opportunity> oppList=[SELECT Id,Account__c,Bill_To_Contact__c FROM Opportunity Limit 1]; 
        System.assertEquals('Please select one contact',ApexPages.getMessages().get(0).getSummary());
        System.assertEquals(null,oppList.get(0).Bill_To_Contact__c);
    }
    
    @isTest 
    static void testWhenContactListIsNull(){
        List<Opportunity> oppList=[SELECT Id,Account__c,Bill_To_Contact__c FROM Opportunity];
        ApexPages.StandardSetController setCon=new ApexPages.StandardSetController(oppList);
       	PageReference page=Page.ManageBillToContact;
       	page.getParameters().put('id',oppList.get(1).Id);
        Test.setCurrentPage(page);
        BillToContactOppCOntroller controller=new BillToContactOppController(setCon); 
        System.assertEquals(0,controller.contacts.size());
        System.assertEquals('There are no related contacts for opportunity .', ApexPages.getMessages().get(0).getSummary());
    }
    
    private static BillToContactOppCOntroller testUtil(PageReference page){
       	List<Opportunity> oppList=[SELECT Id,Account__c,Bill_To_Contact__c FROM Opportunity Limit 1];
        ApexPages.StandardSetController setCon=new ApexPages.StandardSetController(oppList);       
       	page.getParameters().put('id',oppList.get(0).Id);
        Test.setCurrentPage(page); 
        BillToContactOppCOntroller controller=new BillToContactOppController(setCon);
        System.assertEquals(10,controller.contacts.size());
        return controller;
    }
}