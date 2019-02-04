public class Opportunities Extends fflib_SObjectDomain {
	public Opportunities(List<Opportunity> sObjectList){
        super(sObjectList);
    }
    
    public class Constructor implements fflib_SObjectDomain.IConstructable {
        public fflib_SObjectDomain construct(List<SObject> sObjectList) {
            return new Opportunities(sObjectList);
        }
    } 
    
    public override void onAfterUPdate(Map<Id,SObject> existingRecords){
        List<Opportunity> oppList=new List<Opportunity>();
        Opportunity oppOld;
        for(Opportunity opp: (List<Opportunity>) Records){
    			oppOld=(Opportunity) existingRecords.get(opp.Id);
            if(oppOld.Custom_Status__c != opp.Custom_Status__c){
               oppList.add(opp);
            }
        }
        EmailService1 emailService=new EmailService1();
        emailService.sendMailUsingTemplate(oppList);
    }
}