public class SearchAccountController {
    public String selectedValue {get ; set ;}
    public Integer size{get ; set;}
    public String keyword {get ; set ;}
    public List<SelectOption> options;
    public Integer noOfRecords{get; set;}
    public boolean activation{get;set;} 
    public ApexPages.StandardSetController setCon{get;set;}
    
    public SearchAccountController(){
      			size=10;
        activation=false;    			
    }
 
    public List<SelectOption> getOptions(){
        options=new List<SelectOption>();       
        options.add(new SelectOption('--Select--','--Select--'));
        options.add(new SelectOption('BillingCity','BillingCity'));
        options.add(new SelectOption('BillingState','BillingState'));
        options.add(new SelectOption('BillingCountry','BillingCountry'));
        return options;
    }
    
    public void search(){
        setCon=new ApexPages.StandardSetController(Database.getQueryLocator(getQuery()));
        setCon.setPageSize(10);
        noOfRecords = setCon.getResultSize();
        activation =true;
    }
    
    public List<Account> getAccountRecords(){
        return (List<Account>) setCon.getRecords();
    }
    
    private String getQuery(){
        String query;
        query='SELECT Id,Name FROM Account';
        if(selectedValue!='--Select--'){
            query=query+' WHERE '+selectedValue+'=\''+keyword+'\'';
        }
        return query;
    }
}