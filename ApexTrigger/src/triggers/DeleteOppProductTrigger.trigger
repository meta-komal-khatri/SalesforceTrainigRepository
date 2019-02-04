trigger DeleteOppProductTrigger on Opportunity (after update) {
    List<Id> oppIdList=new List<Id>();
    for(Opportunity opp:Trigger.New){
        if(opp.Custom_Status__c=='Reset' && Trigger.oldMap.get(opp.Id).Custom_Status__c!='Reset'){
            oppIdList.add(opp.Id);
        }
    }
    
    List<OpportunityLineItem> opportunityProducts=[SELECT Id,Name FROM OpportunityLineItem WHERE OpportunityId IN : oppIdList];
    delete opportunityProducts;
}