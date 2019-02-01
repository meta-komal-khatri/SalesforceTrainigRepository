trigger UpdateMyCountInClassTrigger on Student__c (before insert,before update,before delete) {
	
    List<Id> idListNew=new List<Id>();
    List<Id> idListOld=new List<Id>();
    if(Trigger.isInsert || Trigger.isUpdate){
       	for(Student__c s:Trigger.New){
       		idListNew.add(s.Class__c);
    	} 
    }
    
    if(Trigger.isUpdate || Trigger.isDelete){
       for(Student__c s:Trigger.old){
            idListOld.add(s.Class__c);
    	} 
    }
    
    
    Map<Id,Class__C> classesNew=new Map<Id,Class__c>([SELECT Id,Number_Of_Students__c,MyCount__c FROM Class__c WHERE Id IN :idListNew]);
    Map<Id,Class__c> classesOld=new Map<Id,Class__c>([SELECT Id,Number_Of_Students__c,MyCount__c FROM Class__c WHERE Id IN :idListOld]);
    
    if(Trigger.isDelete){
        for(Student__c student:Trigger.old){
            if(classesOld.size()>0 && classesOld.containsKey(student.Class__c)){
                classesOld.get(Trigger.oldMap.get(student.Id).Class__c).MyCount__c= classesOld.get(Trigger.oldMap.get(student.Id).Class__c).Number_of_Students__c-1;
            }
        }
    }
    if(Trigger.isUpdate || Trigger.isInsert){
        
    
    for(Student__c student:Trigger.New){
        if(classesNew.size() > 0 && classesNew.containsKey(student.Class__c)){
            if(classesNew.get(student.Class__c).MyCount__c==null)
       			classesNew.get(student.Class__c).MyCount__c=0;
            if(Trigger.isInsert){
                classesNew.get(student.Class__c).MyCount__c+=1;
               //classesNew.get(student.Class__c).MyCount__c = classesNew.get(student.Class__c).Number_of_Students__c + 1;
           }
           if(Trigger.isUpdate){
               if(Trigger.oldMap.get(student.Id).Class__c != classesNew.get(student.Class__c).Id){
               	classesNew.get(student.Class__c).MyCount__c = classesNew.get(student.Class__c).MyCount__c+1;
                classesOld.get(Trigger.oldMap.get(student.Id).Class__c).MyCount__c= classesOld.get(Trigger.oldMap.get(student.Id).Class__c).MyCount__c-1;
               }
               else{
                   classesNew.get(student.Class__c).MyCount__c = classesNew.get(student.Class__c).Number_of_Students__c;
               }
               
           }
           
        }
    }
    }
   update classesNew.values();
   update classesOld.values();
    
    
}