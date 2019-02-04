trigger UpdateCloseDateForStageOppTrigger on Opportunity (before update) {
	
    for(Opportunity opp:trigger.New){
       
            if((trigger.oldMap.get(opp.Id).StageName!='Closed Won' && trigger.oldMap.get(opp.Id).StageName!='Closed Lost')
               && (opp.StageName=='Closed Won' || opp.StageName=='Closed Lost') && trigger.oldMap.get(opp.Id).StageName!=null){
                opp.CloseDate=Date.today();
                
            }
    }
}