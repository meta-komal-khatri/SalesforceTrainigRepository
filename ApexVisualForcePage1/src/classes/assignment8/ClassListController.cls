public class ClassListController {
	
    public Boolean activationFormIsVisible { get; private set; }
    
    public Class__c classObj {get ; set ;}
    
    public ClassListController(ApexPages.StandardSetController setCon){
        activationFormIsVisible=false;
    }
    
    public void editClass(){   
        activationFormIsVisible=true; 
        classObj=[SELECT Id ,Name , MaxLimit__c,Class_Teacher__c FROM Class__c WHERE Id =:ApexPages.currentPage().getParameters().get('id')];
    }
    
    public void deleteClass(){
        classObj=[SELECT Id ,Name , MaxLimit__c,Class_Teacher__c FROM Class__c WHERE Id =:ApexPages.currentPage().getParameters().get('id')];
        delete classObj;
        classObj=new Class__c();
    }
    
    public PageReference saveClass(){
        update classObj;
        activationFormIsVisible=false;
       	return null;
    }
}