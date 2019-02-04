public class OppAmountSumController {
	
    Transient OpportunitiesSelector oppSelector;
    Transient AccountsSelector accSelector;
    public AggregateResult[] result;
    
    public AggregateResult[] getSumOfAmountByAccountId(){
        oppSelector=new OpportunitiesSelector();
        accSelector=new AccountsSelector();
        Map<Id,Account> accountMap=new Map<Id,Account>(accSelector.selectAll());       
        return oppSelector.getSumOfAmountGroupBYAccount(accountMap.keySet());
    }
}