trigger SubjectHindiTeacherTrigger on Contact (before insert,before update) {
    if(Trigger.isInsert){
        for(Contact c:Trigger.new){
            if(c.Subjects__c!=null){
                List<String> subjects=new List<String>();
                Subjects.addAll(c.Subjects__c.split(';'));
                for(String s:subjects){
                    if(s=='Hindi'){
                        c.addError('Techer with hindi subject can not be inserted');
                    }
                }
            }
        }
    }
	
    if(Trigger.isUpdate){
        for(Contact c:Trigger.old){
            if(c.Subjects__c!=null){
                List<String> subjects=new List<String>();
                subjects.addAll(c.Subjects__c.split(';') );
                for(String s:subjects){
                    if(s=='Hindi'){
                        Contact ct=Trigger.newMap.get(c.Id);
                        ct.addError('Teacher can not be updated as he/she teaches hindi.');
                    }
                
                }
            }
        }
    }
}