public class JSONGeneratorController {
	
    public String jsonString{get;set;}
    
    public JSONGeneratorController(){
        jsonString=prepareData();
    }
    
    public String prepareData(){
        List<Account> accountList=[SELECT Id ,Name ,(SELECT Id,Name FROM Contacts) FROM Account LIMIT 5 ];
        
        return JSON.serialize(accountList);
    }
}