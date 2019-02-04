public class Loans Extends fflib_SObjectDomain {
    public Loans(List<Loan__c> sObjectList){
        super(sObjectList);
    }
    
    public class Constructor implements fflib_SObjectDomain.IConstructable {
        public fflib_SObjectDomain construct(List<SObject> sObjectList) {
            return new Loans(sObjectList);
        }
    } 
  
    public override void onAfterUpdate(Map<Id,SObject> existingRecords){
        Loan__c loanOld;
        String subject;
        List<String> addresses=new List<String>();
        String body;
        List<EmailPOJO> emailpojoList=new List<EmailPOJO>();
        for(Loan__c loan : (List<Loan__c>) Records){
            loanOld=(Loan__c) existingRecords.get(loan.Id);
            if(loanOld.Status__c != loan.Status__c){
               subject='Loan  has been '+loan.Status__c+'ed .';
               body='Hi '+loan.Applicant_Name__c+',\n\n Your loan has been '+loan.Status__c+'ed . \n\n Regards\n';
               addresses.add(loan.Applicant_Email__c);
               emailPojoList.add(new EmailPOJO(addresses,body,subject));
            }
        }
        
        EmailService1 emailService=new EmailService1();
        emailService.sendMail(emailPojoList);
    }
}