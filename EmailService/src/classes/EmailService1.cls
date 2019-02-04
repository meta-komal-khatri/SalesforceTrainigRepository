public class EmailService1{
    List<Messaging.SingleEmailMessage> mails;
    Messaging.SingleEmailMessage mail;
    
    public void sendMail(List<String> emailAddresses,String subject,String body){
        mails=new List<Messaging.SingleEmailMessage>();
        mail = new Messaging.SingleEmailMessage();
        mail.setToAddresses(emailAddresses);
        mail.setHtmlBody(body);
        mail.setSenderDisplayName(subject);
        mails.add(mail);
       sendMailExecution(mails);
    }
    
    public void sendMail(List<EmailPOJO> emailPojoList){
        System.debug('asdfgh');
        mails=new List<Messaging.SingleEmailMessage>();
        mail= new Messaging.SingleEmailMessage();
        for(EmailPOJO emailPojo  : emailPojoList){
            mail.setToAddresses(emailPojo.addresses);
            mail.setHtmlBody(emailPojo.body);
            mail.setSenderDisplayName(emailPojo.subject);
            mails.add(mail);
        }
        sendMailExecution(mails);
       
    }
    
    public void sendMailUsingTemplate(List<Opportunity> oppList){
        List<Messaging.SingleEmailMessage>  mails=new List<Messaging.SingleEmailMessage>();
        EmailTemplate et=[Select id from EmailTemplate where Name=:'EmailToOpportunityOwner']; 
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage(); 
        for(Opportunity opp :oppList){
           	mail.setTargetObjectId(opp.OwnerId); 
            mail.setSenderDisplayName('Salesforce Support'); 
            mail.setUseSignature(false); 
            mail.setBccSender(false); 
            mail.setWhatId(opp.Id);
            //mail.setToAddresses(new List<String>{opp.Owner.Email});
            mail.setSaveAsActivity(false); 
            mail.setTemplateId(et.id);  
            mails.add(mail);
        }
        
        sendMailExecution(mails);
    }
    public void sendMailExecution(List<Messaging.SingleEmailMessage> mails){
         try{
            Messaging.sendEmail(mails);
        }catch(Exception e){
            System.debug(e);
        }   
    }
    
}