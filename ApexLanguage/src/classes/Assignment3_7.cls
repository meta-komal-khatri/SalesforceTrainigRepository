public class Assignment3_7 {
    public static void updateFieldContactIds(Id contactId){
        Account account =[SELECT Id,Name,ContactIDs__c ,(SELECT Id FROM Contacts) FROM Account WHERE Id IN (SELECT AccountId FROM Contact WHERE Id = :contactId)];
        String contactIds='';
        
        if(account!=null && account.ContactIDs__c==null){
            for(Contact ct:account.Contacts){
                if(contactIds==''){
                    contactIds=contactIds+ct.Id;
                }
                else{
                    contactIds=contactIds+','+ct.Id;
                }
                
            }
            account.ContactIDs__c=contactIds;
        }
        
        else if(account!=null && account.ContactIDs__c!=null){
           String[] Ids=account.ContactIDs__c.split(',');
            Integer count=0;
            for(String id:Ids){
                if(id==contactId){  
                  count++;  
                }
            }
            if(count==0){
                account.ContactIDs__c=account.ContactIDs__c+','+contactId;
            }
        }
        else{
            System.debug('No Such Account Exists .');
        }
        update account;
        
    }
}