public class ParseXML {
	public Contact con;
    
    public fflib_SObjectUnitOfWork uow;
    public ParseXML(){
        //contactList=new List<Contact>();
        uow=new fflib_SObjectUnitOfWork(new List<SObjectType>{Contact.SObjectType});
    }
    
    public void ParseXml(String XMLString){
        DOM.Document doc=new DOM.Document();
        try{
            doc.load(XMLString);
            DOM.XmlNode rootNode=doc.getRootElement();
            parseXML(rootNode);
            uow.registerNew(con);
            //pro.add(temppro);
            //insert pro;
           	uow.commitWork();
        }catch(exception e){
            system.debug(e.getMessage());
        }
    }
    
    public void parseXML(DOM.XmlNode node){
        if (node.getNodeType() == DOM.XMLNodeType.ELEMENT) {
        system.debug(node.getName());
            if(node.getName()=='contact'){
                if(con!=null)
                    uow.registerNew(con);
               con =new Contact();
               // temppro = new product2();
            }
            if(node.getName()=='fname')
                con.FirstName=node.getText().trim();
            if(node.getName()=='lname')
                Con.LastName=node.getText().trim();
            if(node.getName()=='gender')
                con.Gender__c=node.getText().trim();
        }
        for (Dom.XMLNode child: node.getChildElements()) {
            parseXML(child);
        }
    }
}