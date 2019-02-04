@isTest
private class StudentManagerTest {
	
    @TestSetup
    static void insertStudentsAndClasses(){
        List<Student__c> studentList=new List<Student__c>();
        List<Class__c> classList=new List<Class__c>();
        
        for(Integer i=1;i<=2;i++){
            Class__c clsObj=new Class__c(Name='class'+i,MaxLimit__c=10);
            classList.add(clsObj);
            
        }
        
        insert classList;
        
        for(Integer i=1;i<=4;i++){
            Student__c s=new Student__c(Last_Name__c=''+i,Name='Student'+i,Sex__c='Female',Class__c=classList.get(0).Id);
            studentList.add(s);
            Student__c s2=new Student__C(Last_Name__c=''+i,Name='Student2'+i,Sex__c='Female',Class__c=classList.get(1).Id);
            studentList.add(s2);
        }
        insert studentList;
    }
    
    @isTest
    static void testGetStudentsByClassId(){
       List<Class__c> classList=[SELECT Id FROM Class__c];
        
       List<Student__c> studentList=StudentManager.getStudentsByClassId(classList.get(0).Id);
        
       Integer i=0;
       for(Student__c student : studentList){
           i++;
           System.assertEquals('Student'+i,student.Name);
       }
        
      
      
    }
    @isTest
    static void testGetStudentsWithTheirClass(){
        Map<Class__c,Set<Id>> classStudentMap=studentManager.getStudentsWithTheirClass();
        
        for(Class__c clsObj : classStudentMap.keySet()){
            System.assertEquals(4,classStudentMap.get(clsObj).size());
        }
    }
}