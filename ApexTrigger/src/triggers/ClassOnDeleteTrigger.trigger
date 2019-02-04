trigger ClassOnDeleteTrigger on Class__c (before delete) {
    
    
   	List<Class__c> classes=[SELECT Id,Name ,(SELECT Name FROM Students__r WHERE Sex__c='Female') FROM Class__c WHERE Id IN:Trigger.old];
    
    Map<Id,Integer> countOfFStudents=new Map<Id,Integer>();
    
    for(Class__c cls:classes){
        countOfFStudents.put(cls.Id,cls.Students__r.size());
    }
    
    for(Class__c cls:Trigger.old){
        if(countOfFStudents.get(cls.Id)>1){
            cls.addError('There are more than one female students in class');
        }
    }
   
   
}