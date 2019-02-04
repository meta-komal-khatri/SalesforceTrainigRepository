@isTest
private class SearchAccountControllerTest {

    @TestSetup 
    static void setup(){ 
        List<Account> accounts=new List<Account>();
        for(Integer i=0;i<15;i++){
            accounts.add(new Account(Name='Account',BillingCity='Jaipur',BillingState='Rajasthan',BillingCountry='India'));
            accounts.add(new Account(Name='Account',BillingCity='Bhopal',BillingState='MadhyaPradesh'));
            accounts.add(new Account(Name='Account',BillingCity='Surat',BillingState='Gujrat'));    
        }
        insert accounts;
    }
    
    //Test class for billing city positive case
    @isTest 
    static void testSearchAccountForBillingCityPositive(){  
        SearchAccountController saController=new SearchAccountController(); 
        List<SelectOption> options=saController.getOptions();
        testUtil(true,options.get(1).getValue(),'Jaipur');
    }

 	//Test class for billing city negative case    
    @isTest 
    static void testSearchAccountForBillingCityNegative(){  
        SearchAccountController saController=new SearchAccountController(); 
        List<SelectOption> options=saController.getOptions();
        testUtil(false,options.get(1).getValue(),'Mumbai');
    }
    
    //Test class for billing state positive case
    @isTest 
    static void testSearchAccountForBillingStatePositive(){  
        SearchAccountController saController=new SearchAccountController(); 
        List<SelectOption> options=saController.getOptions();
        testUtil(true,options.get(2).getValue(),'MadhyaPradesh');
    }
    
    //Test class for billing state negative case
    @isTest 
    static void testSearchAccountForBillingStateNegative(){  
        SearchAccountController saController=new SearchAccountController(); 
        List<SelectOption> options=saController.getOptions();
        testUtil(false,options.get(2).getValue(),'Mumbai');
    }
    
    //Test class for billing country positive case
    @isTest 
    static void testSearchAccountForBillingCountryPositive(){  
        SearchAccountController saController=new SearchAccountController(); 
        List<SelectOption> options=saController.getOptions();
        testUtil(true,options.get(3).getValue(),'India');
    }
    
    //Test class for billing country negative case
    @isTest 
    static void testSearchAccountForBillingCountryNegative(){  
        SearchAccountController saController=new SearchAccountController(); 
        List<SelectOption> options=saController.getOptions();
        testUtil(false,options.get(3).getValue(),'Mumbai');
    }
    
    private static void testUtil(Boolean testUtilPositive,String selectedValue,String keyword){
        SearchAccountController saController=new SearchAccountController();
        saController.selectedValue=selectedValue;
        saController.keyword=keyword;
        saController.search();
        List<Account> accounts=saController.getAccountRecords();
        if(testUtilPositive==true){
            System.assertEquals(10, accounts.size());
            saController.setCon.next();
            accounts=saController.getAccountRecords();
            System.assertEquals(5,accounts.size());
        }else{
            System.assertEquals(0, accounts.size());
        }
    }
}