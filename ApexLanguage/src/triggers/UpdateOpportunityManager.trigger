trigger UpdateOpportunityManager on Opportunity (before insert,before update) {

    Assignment3_8.updateOpportunities(Trigger.New);
}