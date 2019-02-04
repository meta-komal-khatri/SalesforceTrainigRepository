@isTest
private class UpdateMyCountTriggerTest {
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
    
    @isTest static void testUpdateMyCountTrigger(){
        List<CLass__c> classes=[SELECT Id,MyCount__c,Number_Of_Students__c FROM Class__c];
        for(Class__c cls:classes){
            System.assertEquals(5,cls.MyCount__c);
        }
        
        List<Student__c> students=[SELECT Id,Name,Class__c FROM Student__c WHERE class__c=:classes.get(1).Id];
        
        for(Student__c student:students){
            student.Class__c=classes.get(0).Id;
        }
        
        update students;
        classes=[SELECT Id,MyCount__c,Number_Of_Students__c FROM Class__c];
        System.assertEquals(10,classes.get(0).MyCount__c);
        System.assertEquals(0,classes.get(1).MyCount__c);
        
    }
}