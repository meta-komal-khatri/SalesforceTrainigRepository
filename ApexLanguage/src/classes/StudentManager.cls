public class StudentManager {
    public static List<Student__c> getStudentsByClassId(String Id){
        List<Student__c> students=[SELECT Id , Name FROM Student__c WHERE Class__r.Id =:Id]  ;
        return students;
    }
    public static Map<Class__c,Set<Id>> getStudentsWithTheirClass(){
        Map<Class__c,Set<Id>> classStudentMap=new Map<Class__c,Set<Id>>();
        List<Class__c> classes=[SELECT Id ,(SELECT Id FROM Students__r) FROM Class__c];
        
        for(Class__c classObj:classes){
            Set<Id> studentSet=new Map<Id,Student__c>(clasSObj.Students__r).keyset();
            classStudentMap.put(classObj,studentSet);
        }
        return classStudentMap;
    }
}