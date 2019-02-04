@isTest
private class AccountsTriggerTest {
	@TestSetup
    static void setup(){
        List<Account> accountList=new List<Account>();
        Account pAccount1=new Account(Name='Parent Account');
        Account pAccount2=new Account(Name='Parent Account');
        insert pAccount1;
        insert pAccount2;      
        for(Integer i=0;i<10;i++){
            accountList.add(new Account(Name='Account',ParentId=pAccount1.Id));
            accountList.add(new Account(Name='Account',ParentId=pAccount2.Id));
        }
        insert accountList;
    }
    
    @isTest
    static void testAccountsTrigger(){
        List<Account> pAccountList=[SELECT Id,Name,Child_Count__c FROM Account WHERE Name='Parent Account'];
        
        //On insert testing
        system.assertEquals(10,pAccountList.get(0).Child_Count__c);
       
        //On update testing
        List<Account> accountList=[SELECT Id,Name,Child_Count__c FROM Account WHERE parentId=:pAccountList.get(0).Id];
       
        //Updates parentId from pAccount1 to pAccount2 
        for(Account a:accountList){
            a.ParentId=pAccountList.get(1).Id;      
        }
        Test.startTest();
        List<Database.SaveResult> results=Database.update(accountList,false);
        Test.stopTest();
       	accountList=[SELECT Id,Name,Child_Count__c FROM Account WHERE parentId=:pAccountList.get(0).Id];
        system.assertEquals(0,accountList.size());
        accountList=[SELECT Id,Name,Child_Count__c FROM Account WHERE parentId=:pAccountList.get(1).Id];
        system.assertEquals(20,accountList.size());
        
        //On Delete trigger
        accountList=[SELECT Id,Name,Child_Count__c FROM Account LIMIT 10];
        delete accountList;
        System.assertEquals(10,pAccountList.get(1).Child_Count__c);
    }
}