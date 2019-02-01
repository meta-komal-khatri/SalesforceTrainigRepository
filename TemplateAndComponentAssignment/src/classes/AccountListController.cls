public class AccountListController {
    
    public List<Account> accountList{get;set;}
    public ApexPages.StandardSetController setCon{get;set;}
    Public Integer noOfRecords{get; set;}
    Transient AccountsSelector accounts;
    
    public AccountListController(){
        accounts=new AccountsSelector();
        accountList=accounts.selectAll();
    }
    
    public List<Account> getAccounts(){
        if(setCon==null){
            setCon=new ApexPages.StandardSetController(accountList);
        	setCon.setPageSize(10);
        	noOfRecords = setCon.getResultSize();
        }
        return setCon.getRecords();
    }

    public void sortByName(){
        setCon=null;  
        accounts=new AccountsSelector();
        accountList=accounts.selectAllByNameOrder(); 
    }
}