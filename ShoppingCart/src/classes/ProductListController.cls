public class ProductListController {
    public Cart__c cartObj{get;set;} 
    public Contact contact{get;set;}
    public List<Product2> productList;
    public String selectedUser{get;set;}
    public ApexPages.StandardSetController setCon{get;set;}
    public List<Cart__c> cartList;
    public List<SelectOption> cartUserList;
    public Boolean showCartListPanel{get;set;}
    public ProductListController(){
        productList=[SELECT Id,Name,Price__c,quantity__c  FROM Product2];
        setCon=new ApexPages.StandardSetController(productList);
        setCon.setPageSize(10);  
    }
    
    public List<Cart__c> getCarts(){
        cartList=[Select Id, Name,Product__c,Quantity__c,Unit_Price__c,Total_Price__c FROM Cart__c where cart_User__c=:selectedUser];
        return cartList;
    }
    
    public List<SelectOption> getUserList(){
        cartUserList=new List<SelectOption>();
        cartUSerList.add(new SelectOption('Select','Select'));
        List<Contact> contactList=[SELECT Id,Name FROM Contact];
        for(Contact c:contactList){
            cartUserList.add(new SelectOption(c.Id,c.Name));
        }
        return cartUserList;
    }
    
    public List<Product2> getProductList(){
        return (List<Product2>) setCon.getRecords();
    }
    
    public void saveIntoCart(){
        List<Cart__c> carts=[SELECT Id , Name , Cart_User__c,Product__c,Quantity__c FROM cart__c WHERE Product__c=:ApexPages.currentPage().getParameters().get('pid1') AND Cart_User__c=:selectedUser];
        Cart__c cart;
        if(carts.size()>0){
            cart=carts.get(0);
            cart.Quantity__c=cart.Quantity__c+1;
        }else{
            cart=new Cart__c();
            cart.Cart_User__c=selectedUser;
            cart.Product__c=apexPages.currentPage().getParameters().get('pid1');
            cart.Quantity__c=1;
        } 
        upsert cart; 
        showCartListPanel=true;
    }
    
    public PageReference proceedToShippingPage(){
        contact=[SELECT Id,Name,Shipping_Address__c,Email,MobilePhone,MailingCity,MailingCountry,AccountId FROM COntact WHERE Id=:selectedUser];
        PageReference page=new PageReference('/apex/ShippmentPage');
        page.setRedirect(false);
        return page;
    }
    
    public PageReference placeOrder(){
        Purchase_Order__c porder=new Purchase_Order__c();
        Double total=0;
        porder.UserId__C=contact.Id;
        for(Cart__c c:cartList){
            total+=c.total_price__C;
        }
        porder.total_Amount__C=total;
        porder.Shipping_Address__C=contact.Shipping_Address__c;
        porder.Mobile__C=contact.MobilePhone;
        insert porder;
        return insertOrderItem(porder.Id);                               
    }
    
    private PageReference insertOrderItem(Id orderId){
        List<PurchaseOrderLineItem__c> orderItemList=new List<PurchaseOrderLineItem__c>();
        List<Id> productId=new List<Id>();
        for(Cart__c cart:cartList){
            productId.add(cart.Product__c);
        }
        Map<Id,Product2> productMap=new Map<Id,Product2>([SELECT Id ,Name,Quantity__c FROM Product2 WHERE Id IN :productId]);
        for(Cart__C cart:cartList){
            PurchaseOrderLineItem__c purchaseOrderItem=new PurchaseOrderLineItem__c();
            purchaseOrderItem.OrderId__c=orderId;
            purchaseOrderItem.productId__c=cart.Product__c;
            purchaseOrderItem.Unit_Price__c=cart.Unit_Price__c;
            purchaseOrderItem.Quantity__c=cart.Quantity__c;
            productMap.get(cart.Product__c).Quantity__c=productMap.get(cart.Product__c).Quantity__c-cart.Quantity__c;
            orderItemList.add(purchaseOrderItem);
        }
        insert orderItemList;
        update productMap.values();
        delete cartList;
        PageReference page=new PageReference('/apex/ProductListPage');
        return page;
    }
    
    public PageReference getProductDetailPage(){
        PageReference page=new PageReference('/'+ApexPages.currentPage().getParameters().get('detailid'));
        return page;
    }
    
    public void deleteFromCart(){
        List<Cart__c> cart =[SELECT Id ,Name FROM Cart__c WHERE cart_User__c=:selectedUser AND Product__c=:ApexPages.currentPage().getParameters().get('pid2') ];        
        delete cart;
    }
    
    public void updateCarts(){
        update cartList;
    }
    
    public PageReference ShowCartList(){
        if(getCarts().size()>0){
            showCartListPanel=true;
        }else{
            showCartListPanel=false;
        }
        return null;
    }
}