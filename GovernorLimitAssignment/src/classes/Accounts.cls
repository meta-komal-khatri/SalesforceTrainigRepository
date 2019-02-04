public class Accounts Extends fflib_SObjectDomain {
    private AccountsSelector accountSelector;
	
    public Accounts(List<Account> sObjectList){
       
        super(sObjectList);
        accountSelector=new AccountsSelector();
    }

     public class Constructor implements fflib_SObjectDomain.IConstructable {
         public fflib_SObjectDomain construct(List<SObject> sObjectList) {
             return new Accounts(sObjectList);
         }
     } 
    
    public override void onApplyDefaults(){
        for(Account account:(List<Account>) Records){
            account.description='Domain classes rock!';
        }
    }
    
    public override void  onBeforeInsert(){
        for(Account account:(List<Account>) Records){
            account.description='Domain classes rock!';
        }

    }
    
    public override void onBeforeUpdate(Map<Id,SObject> existingRecords){
        for(Account account:(List<Account>) Records){
            if(account.Description!=null)
            	account.AnnualRevenue='Domain classes rock!'.getLevenshteinDistance(account.Description);
        }
    }
    
    public override void onAfterInsert(){
        fflib_SObjectUnitOfWork uow=new fflib_SObjectUnitOfWork(new List<SObjectType>{Account.SObjectType});
        Set<Id> parentIdSet=new Set<Id>();
        for(Account a:(List<Account>) Records){
            parentIdSet.add(a.ParentId);
        }
        
        Map<Id,Account> parentAccMap=new Map<Id,Account>(accountSelector.selectById(parentIdSet));
        updateChildCount(parentAccMap,uow);
        uow.commitWork();
    }
    
    public override void onAfterUpdate(Map<Id,SObject> existingRecords){
        fflib_SObjectUnitOfWork uow=new fflib_SObjectUnitOfWork(new List<SObjectType>{Account.SObjectType});
        Set<Id> parentIdSet=new Set<Id>();
 		Account aOld;
        for(Account a:(List<Account>) Records){
            aOld=(Account) existingRecords.get(a.Id);
            if(aOld.ParentId !=null && a.ParentId!=null && aOld.ParentId != a.ParentId){
                parentIdSet.add(a.ParentId);
                parentIdSet.add(aOld.ParentId);
            } 
            if(aOld.ParentId==null && a.ParentId!=null && aOld.ParentId != a.ParentId){
                parentIdSet.add(a.ParentId);
            }
        }
        Map<Id,Account> parentAccMap=new Map<Id,Account>(accountSelector.selectById(parentIdSet));
        updateChildCount(parentAccMap,uow);
        uow.commitWork();
    }
    
    public override void onAfterDelete(){
        fflib_SObjectUnitOfWork uow=new fflib_SObjectUnitOfWork(new List<SObjectType>{Account.SObjectType});
        Set<Id> parentIdSet=new Set<Id>();
        for(Account a:(List<Account>) Records){
            parentIdSet.add(a.ParentId);
        }
        Map<Id,Account> parentAccMap=new Map<Id,Account>(accountSelector.selectById(parentIdSet));
        updateChildCount(parentAccMap,uow);
        uow.commitWork();
    }
    
    public void updateChildCount(Map<Id,Account> accountMap,fflib_SObjectUnitOfWork uow){
        AggregateResult[] countOfChilds=accountSelector.getChildCountOfAccount(accountMap.keySet());
        Account account;
        for(AggregateResult ar:countOfChilds){
            account=accountMap.get((Id) ar.get('ParentId'));
            account.child_count__c=(Integer) ar.get('expr0');
            uow.registerDirty(account);
        }
    }
}