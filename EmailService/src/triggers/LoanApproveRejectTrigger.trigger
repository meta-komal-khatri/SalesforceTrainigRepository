trigger LoanApproveRejectTrigger on Loan__c (After Update) {
	fflib_SObjectDomain.triggerHandler(Loans.class);
}