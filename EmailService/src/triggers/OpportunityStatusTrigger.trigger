trigger OpportunityStatusTrigger on Opportunity (after update) {
	fflib_SObjectDomain.triggerHandler(Opportunities.class);
}