public class BillToContactOppController {

    public String selected {get ; set ;} 
    public List<Contact> contacts{get;set;} 
    public Opportunity opp{get ; set ;}
  
    public BillToContactOppController(ApexPages.StandardSetController sCon){  
        opp=[SELECT Id,Account__c,Bill_To_Contact__c FROM Opportunity WHERE Id =: ApexPages.currentPage().getParameters().get('id')];
        contacts=[SELECT Id,Name,AccountId FROM Contact WHERE AccountId =:opp.Account__c];
        if(contacts.size()==0){
             ApexPages.addmessage(new ApexPages.message(ApexPages.Severity.WARNING,'There are no related contacts for opportunity .'));
        }
    }
    
    public PageReference save(){
        if(selected!=null){
            opp.Bill_To_Contact__c=selected;
            update opp;
            PageReference page=new PageReference('/'+opp.Id);
            return page;
        }else{
            ApexPages.addmessage(new ApexPages.message(ApexPages.Severity.WARNING,'Please select one contact'));
            return null;
        }   
    }
    
    public PageReference clear(){
        opp.Bill_To_Contact__c=null;
        update opp;
        PageReference page=new PageReference('/'+opp.Id);
        return page;
    }
    
    public PageReference getSelected(){  
        selected=ApexPages.currentPage().getParameters().get('v');
        System.debug(selected);
        return null;
    }
    
  
}