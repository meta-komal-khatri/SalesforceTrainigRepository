@isTest
private class LoanApproveRejectTriggerTest {
    
    @isTest
    static void testTrigger(){
        Integer i;
        List<Loan__c> loans=[SELECT Id,Status__c,Applicant_Name__c,Applicant_Email__c FROM Loan__c];
        for(Loan__c l:loans){
            l.Status__c='Approve';
        }
        Test.startTest();
        List<Database.SaveResult> results=Database.update(loans,false);
        i=Limits.getEmailInvocations();
        Test.stopTest();
        System.assertEquals(10,results.size());   
    }
	@testSetup
    static void setup(){
        List<Loan__c> loans=new List<Loan__c>();
        Loan__c loan;
        CityManager__c manager=new CityManager__c(Name='Manager');
        insert manager;
        for(Integer i=0;i<10;i++){
            loan=new Loan__c();
            loan.Amount__c=40000;
            loan.CityManager__c=manager.Id;
            loan.Applicant_Name__c='Loan';
            loan.Applicant_Email__c='komal.khatri'+i+'@metacube.com';
            loan.Status__c='Reject';
            loans.add(loan);
        }
        insert loans;
    }
}