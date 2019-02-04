trigger StudentTrigger on Student__c (before insert,before update) {
    
    
    List<Id> ids=new List<Id>();
    
    for(Student__c s:Trigger.New){
        ids.add(s.Class__c);
    }
    Map<Id,Class__C> classes=new Map<Id,Class__c>([SELECT Id,Number_Of_Students__c,MaxLimit__c FROM Class__c WHERE Id IN :ids]);
    
        for(Student__c student:trigger.New ){
           Class__c cls=classes.get(student.class__c);   
           if(Trigger.isInsert){
                if(cls.Number_Of_Students__c>=cls.MaxLimit__c){  
                    student.addError('Can not add more students');
                }
         	}
            
            if(Trigger.isUpdate){
                if(Trigger.oldMap.get(student.Id).Class__c != cls.Id && cls.Number_Of_Students__c>=cls.MaxLimit__c){
                    student.addError('Can not add more students');
                }
            }
           
       
    	}
    
    
    
    
}