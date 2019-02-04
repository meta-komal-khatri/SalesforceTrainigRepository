global class InsertContactFromXML implements Messaging.InboundEmailHandler	 {
    
    global Messaging.InboundEmailResult handleInboundEmail(Messaging.inboundEmail email, Messaging.InboundEnvelope envelope){
        Messaging.InboundEmailResult result = new Messaging.InboundEmailResult();
        Messaging.InboundEmail.TextAttachment[] tAttachments = email.textAttachments;  
        Messaging.InboundEmail.BinaryAttachment[] bAttachments = email.BinaryAttachments;
        ParseXML parseXML;
        String csvbody='';     
        if(bAttachments !=null){
            for(Messaging.InboundEmail.BinaryAttachment btt : bAttachments){
                if(btt.filename.endsWith('.xml')){
                    csvbody=(btt.body.toString());     
                }
            }
        }
        parseXML=new ParseXML();
        parseXML.Parsexml(csvbody);
        if(tAttachments !=null){
            for(Messaging.InboundEmail.TextAttachment ttt : tAttachments){
                if(ttt.filename.endsWith('.xml')){ 
                    csvbody=(ttt.body); 
                }    
            }
        }
        parseXML=new ParseXML();
        parseXML.Parsexml(csvbody);
        result.success=true;
        return result;
    }
}