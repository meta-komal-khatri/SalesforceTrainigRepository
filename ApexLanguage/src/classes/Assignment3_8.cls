public class Assignment3_8 {
    public static void updateOpportunities(List<Opportunity> opportunities){
        List<Opportunity> oppAfterChanges=new List<Opportunity>();
        List<Id> oppContactIds=new List<Id>();
        
        for(Opportunity opp:opportunities){
            oppContactIds.add(opp.Bill_To_Contact__c);
        }
        
        Map<Id,Contact> contactMap=new Map<Id,Contact>([SELECT Id,AccountId From Contact WHERE Id IN :oppContactIds]);
       
        for(Opportunity opp:opportunities){
            if(opp.Bill_To_Contact__c!=null && opp.Account__c==null){  
                opp.Account__c=contactMap.get(opp.Bill_To_Contact__c).AccountId;
            }
        }
        
        
    }
}