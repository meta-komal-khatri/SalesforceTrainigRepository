global class SendMailToOpportunityOwner implements Database.Batchable<sObject>{
    
    global Database.QueryLocator start(Database.BatchableContext bc){
        
        return Database.getQueryLocator('SELECT Id,OwnerId FROM Opportunity WHERE LastModifiedDate=LAST_N_DAYS:30');
    }
    global void execute(Database.BatchableContext bc,List<Opportunity> opportunities){
       
        
        List<String> emailAddresses=new List<String>();
       
        List<Id> ownerIds=new List<Id>();
        for(Opportunity opp:opportunities){
            ownerIds.add(opp.OwnerId);
        }
        Map<Id,User> userMap=new Map<Id,User>([SELECT Id,Email FROM User WHERE Id IN :ownerIds]);
        
        for(Id id:userMap.keySet()){
            emailAddresses.add(userMap.get(id).Email);
        }
      	
        String subject ='Opportunities not modified';
        String body='Please update opportunities';
        
        EmailService emailService=new EmailService();
        emailService.sendMail(emailAddresses, subject, body);

        
        
       
    }
    global void finish(Database.BatchableContext bc){
        
    }
}