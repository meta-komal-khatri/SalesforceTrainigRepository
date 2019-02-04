@isTest
private class ProductListControllerTest {
	/**Test saveIntoCartMethod functionality**/
    @isTest
    static void testSaveIntoCartMethod() {	
    	PageReference page=Page.ManageBillToContact;
        ProductListController controller=testUtil(page);
        //When cart is empty
    	page.getParameters().put('pid1',controller.getProductList().get(0).Id);
    	controller.saveIntoCart();
    	System.assertEquals(1,controller.getCarts().size());
        //When cart is not empty and same product is inserted ,existing cart product quantity should be increased
        page.getParameters().put('pid1',controller.productList.get(0).Id);
    	controller.saveIntoCart();
        System.assertEquals(1,controller.getCarts().size());  
    }
    
   	/** Test to check functionality of placeOrder method.**/
    @isTest
    static void testPlaceOrderMethod(){
        PageReference page=Page.ManageBillToContact;
        ProductListController controller=testUtil(page);
        page.getParameters().put('pid1',controller.getProductList().get(0).Id);
    	controller.saveIntoCart();
        System.assertEquals(1,controller.getCarts().size());
        controller.proceedToShippingPage();
        controller.placeOrder();
        //After placing the order ,cart should be empty.
        System.assertEquals(0,controller.getCarts().size());
        //There should be one product in purchaseOrder Object.
        List<Purchase_Order__c> purchaseOrders=[SELECT Id FROM Purchase_order__c];
        System.assertEquals(1,purchaseOrders.size());
    }
    
    /** Test to check functionality of deleteFromCart method.**/
    @isTest
    static void testDeleteFromCartTest(){
        PageReference page=Page.ManageBillToContact;
        ProductListController controller=testUtil(page);
        page.getParameters().put('pid1',controller.getProductList().get(0).Id);
    	controller.saveIntoCart();
        page.getParameters().put('pid1',controller.getProductList().get(1).Id);
    	controller.saveIntoCart();
        page.getParameters().put('pid2',controller.getProductList().get(0).Id);
        controller.deleteFromCart();
        //On delete of one product cart size will be one  
        System.assertEquals(1,controller.getcarts().size());
    }
    
    /** Test to check functionality of showCartList method.
		If there is no product in cart then showCartListPanel should be false**/
    @isTest
    static void testShowCartListMethod(){
        PageReference page=Page.ManageBillToContact;
        ProductListController controller=testUtil(page);
        page.getParameters().put('pid1',controller.getProductList().get(0).Id);
    	controller.saveIntoCart();
        controller.ShowCartList();
        System.assertEquals(true,controller.showCartListPanel);
        page.getParameters().put('pid2',controller.getProductList().get(0).Id);
        controller.deleteFromCart();
        controller.ShowCartList();
        System.assertEquals(false,controller.showCartListPanel);
    }
    
    @TestSetup
    static void setup(){
    	List<Product2> products=new List<Product2>();
    	for(Integer i=0;i<20;i++){
    		products.add(new Product2(Name='Product',Price__c=20,Quantity__c=10));
    	}
    	insert products;
        List<Contact> contacts=new List<Contact>();
        for(Integer i=0;i<10;i++){
            contacts.add(new Contact(LastName='Contact',Gender__c='Female'));
        }
        insert contacts;
    }
    
    /**Test util method to initialize user and controller**/
    static ProductListController testUtil(PageReference page){
    	ProductListController controller=new ProductListController();
	    System.assertEquals(20,controller.productList.size());  
	    List<SelectOption> options=controller.getUserList();
	   	Test.setCurrentPage(page);
	    controller.selectedUser=options.get(1).getValue();
        
	    return controller;
    }
    
    
}