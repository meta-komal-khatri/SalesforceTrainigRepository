@istest
private class ClassListControllerTest {
	
    @testSetup static void setup(){
        List<Class__c> classes=new List<Class__c>();
    
        for(Integer i=0;i<10;i++){
            classes.add(new Class__c(Name='Class'+i,MaxLimit__c=10));
        }
        
        insert classes;
    }
    
    @istest static void testEditClassMethod(){
        List<Class__c> classes=[SELECT Id,Name,MaxLimit__c,Number_Of_Students__c FROM Class__c];
       	ClassListController controller=testUtil();
        controller.editClass();
        
        System.assertEquals(classes.get(0).Id,controller.classObj.Id);
        
		        
        
    }
    
    @isTest static void testSaveClassMethod(){
        List<Class__c> classes=[SELECT Id,Name,MaxLimit__c,Number_Of_Students__c FROM Class__c];
       	ClassListController controller=testUtil();
        controller.editClass();
        
        System.assertEquals(classes.get(0).Id,controller.classObj.Id);
        controller.classObj.Name='Class 3';
        controller.saveClass();
        System.assertEquals('Class 3',controller.classObj.Name);
    }
    
    @isTest static void testDeleteClassMethod(){
        ClassListController controller=testUtil();
        controller.deleteClass();
        
        System.assertEquals(null,controller.classObj.Name);
    }
    
    private static ClassListController testUtil(){
         List<Class__c> classes=[SELECT Id,Name,MaxLimit__c,Number_Of_Students__c FROM Class__c];
        ApexPages.StandardSetController setCon=new ApexPages.StandardSetController(classes);
        ClassListController controller=new ClassListController(setCon);
        PageReference page=Page.ClassListPage;
        
        page.getParameters().put('id',classes.get(0).Id);
        Test.setCurrentPage(page);
        return controller;
    }
   
}