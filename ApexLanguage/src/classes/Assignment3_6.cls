public class Assignment3_6 {
    public static List<Schema.SObjectType> getAllsObjects(){
        
        Map<String, Schema.SObjectType> allSObjects = Schema.getGlobalDescribe();
        
        List<Schema.SObjectType> objects=new List<Schema.SObjectType>(allSObjects.values());
        
        return objects;  
 
    }
}