global class Assignment3_5 implements Schedulable {
    global void execute(SchedulableContext sc){
        SendMailToOpportunityOwner sendMail=new SendMailToOpportunityOwner();
       	Database.executeBatch(sendMail);
    }
}