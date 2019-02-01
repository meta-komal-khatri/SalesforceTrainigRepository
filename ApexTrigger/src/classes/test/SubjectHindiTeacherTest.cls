@isTest
private class SubjectHindiTeacherTest {
    @isTest static void testSubjectHindiTecher(){
        List<Contact> contactList=[SELECt Id,LastName,Subjects__c FROM COntact];
        
        for(Contact contact:contactList){
            contact.Subjects__c='Science';
        }
       
        Test.startTest();
        List<Database.SaveResult> resultList=Database.update(contactList,false);
        Test.stopTest();
        
        Integer errorCount=0;
        for(Database.SaveResult sr:resultList){
            if(!sr.isSuccess()){
                errorCount++;
                System.assertEquals(1, sr.getErrors().size());
                System.assertEquals('Teacher Teaches Hindi',sr.getErrors()[0].getMessage());
            }
        }
        System.assertEquals(5,errorCount);
        
    }
    
    @testSetup static void  setup(){
        List<Contact> contactList=new List<Contact>();
        for(Integer i=0;i<5;i++){
            contactList.add(new Contact(LastName='Komal',Subjects__c='Science',Gender__c='Female'));
            contactList.add(new Contact(LastName='Komal',Subjects__c='English',Gender__c='Female'));
        }
        insert contactList;
        
        for(Integer i=0;i<5;i++){
            contactList.get(i).Subjects__c='Hindi';
        }
        update contactList;
    }
}