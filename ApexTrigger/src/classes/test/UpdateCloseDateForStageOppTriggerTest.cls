@istest
private class UpdateCloseDateForStageOppTriggerTest {
    @testSetup static void setup(){
        List<Opportunity> opportunities=new List<Opportunity>();
        
        for(Integer i=0;i<10;i++){
            opportunities.add(new Opportunity(Name='Opportunity',StageName='Negotiation/Review',CloseDate=Date.today().addDays(-7) ));
            opportunities.add(new Opportunity(Name='Opportunity',StageName='Closed Won',CloseDate=Date.today().addDays(-7) ));
        }
        
        insert opportunities;
    }
    
    @isTest static void testUpdateCloseDateTrigger(){
        List<Opportunity> opportunities=[SELECT Id,StageName,CloseDate FROM Opportunity];
        
        for(Opportunity opp:opportunities){
            opp.StageName='Closed Lost';
        }
        
        update opportunities;
      
        opportunities=[SELECT Id,StageName,CloseDate FROM Opportunity WHERE StageName='Closed Lost' AND CloseDate=:Date.today()];
        
        System.assertEquals(10, opportunities.size());
        
    }
}