@isTest
private class StudentClassMaxLimitTriggerTest {

    @testSetup static void setup(){
       	List<Class__c> classes=new List<Class__c>();
        List<Student__c> students=new List<student__c>();
        for(Integer i=0;i<3;i++){
            classes.add(new Class__c(Name='Class'+i+1,MaxLimit__c=5));
        }
        classes.get(0).MaxLimit__c=10;
        insert classes;
        for(Integer i=0;i<5;i++){
            students.add(new Student__c(Last_Name__c='Student',Name='Student',Sex__c='Female',Class__c=classes.get(0).Id));
            students.add(new Student__c(Last_Name__c='Student',Name='Student',Sex__c='Male',Class__c=classes.get(1).Id));
            students.add(new Student__c(Last_Name__c='Student',Name='Student',Sex__c='Female',Class__c=classes.get(2).Id));
        }
        insert students;
    }
    @isTest static void testStudentClassMaxLimitTrigger(){
        List<Class__c> classes=[SELECT Id ,Name FROM Class__c];
        List<Student__c> students=new List<student__c>();
       	Student__c student=[SELECT Id,Name ,Class__r.Id FROM Student__c WHERE Class__c=:classes.get(0).Id LIMIT 1];
        student.Class__c=classes.get(1).Id;
        for(Integer i=0;i<5;i++){ 
            students.add(new Student__c(Last_Name__c='Student',Name='Student',Sex__c='Female',Class__c=classes.get(0).Id));
            students.add(new Student__c(Last_Name__c='Student',Name='Student',Sex__c='Male',Class__c=classes.get(1).Id));
            students.add(new Student__c(Last_Name__c='Student',Name='Student',Sex__c='Female',Class__c=classes.get(2).Id));
        }
        test.startTest();
        Database.SaveResult result=Database.update (student,false);
        List<Database.SaveResult> resultList=database.insert(students,false);
        test.stopTest();
        System.assert(!result.isSuccess());
        Integer errorCount=0;
        for(Database.SaveResult sr:resultList){
            if(!sr.isSuccess()){
                errorCount++;
                System.assertEquals('Can not add more students',sr.getErrors()[0].getMessage());
            }
        }
        System.assertEquals(10,errorCount);
    }
}