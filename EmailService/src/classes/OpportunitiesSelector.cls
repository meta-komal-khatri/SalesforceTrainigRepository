public class OpportunitiesSelector extends fflib_SObjectSelector {
	public OpportunitiesSelector() {
        super(false);
    }
    public OpportunitiesSelector(Boolean includeFieldSetFields) {
        super(includeFieldSetFields);
    }
    
    public List<Schema.SObjectField> getSObjectFieldList() {
        return new List<Schema.SObjectField> {
            Opportunity.Id,
            Opportunity.Amount,
            Opportunity.AccountId};
    }
    
    public Schema.SObjectType getSObjectType() {
        return Account.sObjectType;
    }
    
    public AggregateResult[] getSumOfAmountGroupBYAccount(Set<Id> accountIds){
        AggregateResult[] sumOfAmount=[SELECT SUM(Amount),AccountId From Opportunity WHERE AccountId IN : accountIds Group By AccountId];
        return sumOfAmount;
    }
    
}