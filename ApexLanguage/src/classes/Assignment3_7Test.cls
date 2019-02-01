@isTest
private class Assignment3_7Test {

    @isTest static void testUpdateFieldContactIDs(){
        Account account=new Account(Name='Dummy Account');
        insert account;
        List<Id> ids=new List<Id>();
        for(Integer i=1;i<=4;i++){
            Contact contact=new Contact(FirstName='Contact',LastName=''+i,AccountId=account.Id);
            insert contact;
            ids.add(contact.Id);
        }
        
        Assignment3_7.updateFieldContactIds(ids.get(2));
        Account account1 =[SELECT Id,Name,ContactIDs__c FROM Account WHere Id=:account.Id];
        
        List<String> contactIds=account1.ContactIDs__c.split(',');
        System.assertEquals(4,contactIds.size());
        
        Contact contact1=new contact(FirstName='Dummy',LastName='Dummy',AccountId=account.Id);
        insert contact1;
        
        Assignment3_7.updateFieldContactIds(ids.get(2));
        System.assertEquals(4,contactIds.size());
        
        Assignment3_7.updateFieldContactIds(contact1.Id);
        Account account2 =[SELECT Id,Name,ContactIDs__c FROM Account WHere Id=:account.Id];
        contactIds=account2.ContactIDs__c.split(',');
        System.assertEquals(5,contactIds.size());
    }
}