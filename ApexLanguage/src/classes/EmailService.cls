public class EmailService {
    public void sendMail(List<String> emailAddresses,String subject,String body){
        List<Messaging.SingleEmailMessage> mails=new List<Messaging.SingleEmailMessage>();
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setToAddresses(emailAddresses);
        mail.setHtmlBody(body);
        mail.setSenderDisplayName(subject);
        mails.add(mail);
        try{
            Messaging.sendEmail(mails);
        }
        catch(Exception e){
            System.debug(e);
        }
    }
}