@isTest
private class Assignment3_8Test {
    @isTest static void testUpdateOpportunityTrigger(){
        Account account=new Account(Name='Dummy');
        insert account;
        Contact contact=new Contact(LastName='dummy User',AccountId=account.Id);
        insert contact;
        
        Opportunity opp=new Opportunity(Name='dummy opp',Bill_To_Contact__c=contact.Id,StageName='Closed Won' ,CloseDate=Date.today().addDays(30));
        
        
        Test.startTest();
        
        Database.SaveResult result = Database.insert(opp);
        
        Test.stopTest();
        
        System.assert(result.isSuccess());
        System.assert(result.getErrors().size() == 0);
       
        
        
        
    }
}