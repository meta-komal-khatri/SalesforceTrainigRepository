@isTest
private class ClassOnDeleteTriggerTest {
    @TestSetup static void setup(){
        List<Class__c> classes=new List<Class__c>();
        List<Student__c> students=new List<student__c>();
        for(Integer i=0;i<3;i++){
            
            classes.add(new Class__c(Name='Class'+i+1));
        }
        insert classes;
        for(Integer i=0;i<5;i++){
            students.add(new Student__c(Last_Name__c='Student',Name='Student',Sex__c='Female',Class__c=classes.get(0).Id));
            students.add(new Student__c(Last_Name__c='Student',Name='Student',Sex__c='Male',Class__c=classes.get(1).Id));
            students.add(new Student__c(Last_Name__c='Student',Name='Student',Sex__c='Female',Class__c=classes.get(2).Id));
        }
        
        insert students;
        
    }
    
    @isTest static void classOnDeleteTest(){
        List<Class__c> classes=[SELECT Id ,Name FROM Class__c];
        test.startTest();
        List<Database.DeleteResult> resultList = Database.delete(classes,false);
        test.stopTest();
        Integer errorCount=0;
        for(Database.DeleteResult dr:resultList){
            if(!dr.isSuccess()){
                errorCount++;
                System.assertEquals('There are more than one female students in class',dr.getErrors()[0].getMessage());
            }
        }
        System.assertEquals(2,errorCount);
    }
}