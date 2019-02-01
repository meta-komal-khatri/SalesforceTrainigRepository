@isTest
private class Assignment3_6Test {
	@isTest
    static void testGetAllSObjects(){
        
        List<Schema.SObjectType> sObjectList=Assignment3_6.getAllSObjects();
        
        System.assertEquals(474,sObjectList.size());
    }
}