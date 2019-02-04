@isTest
private class InsertContactFromXMLTest {
    
    //Test Method for main class
    @isTest
    static void TestinBoundEmail()
    {
        // create a new email and envelope object
        Messaging.InboundEmail email = new Messaging.InboundEmail() ;
        Messaging.InboundEnvelope env = new Messaging.InboundEnvelope();
        
        // setup the data for the email
        email.subject = 'Create Contact';
        email.fromAddress = 'komal.khatri@metacube.com';
        email.plainTextBody = 'Attachement attached';
        
        // add an Binary attachment
        Messaging.InboundEmail.BinaryAttachment attachment = new Messaging.InboundEmail.BinaryAttachment();
        string xmlString='<Contacts><contact><fname>Komal</fname><lname>Khatri</lname><gender>Female</gender></contact><contact><fname>Komal</fname><lname>Khatri</lname><gender>Female</gender></contact><contact><fname>Komal</fname><lname>Khatri</lname><gender>Female</gender></contact></Contacts>';
        attachment.body = blob.valueOf(xmlString);
        attachment.fileName = 'textfileone.xml';
        attachment.mimeTypeSubType = 'text/plain';
        email.binaryAttachments = new Messaging.inboundEmail.BinaryAttachment[] { attachment };
            
        // add an Text atatchments
        Messaging.InboundEmail.TextAttachment attachmenttext = new Messaging.InboundEmail.TextAttachment();
        xmlString='<Contacts><contact><fname>Komal1</fname><lname>Khatri1</lname><gender>Female</gender></contact><contact><fname>Komal</fname><lname>Khatri</lname><gender>Female</gender></contact><contact><fname>Komal</fname><lname>Khatri</lname><gender>Female</gender></contact></Contacts>';
        attachmenttext.body = xmlString;
        attachmenttext.fileName = 'textfiletwo3.xml';
        attachmenttext.mimeTypeSubType = 'text/plain';
        email.textAttachments =   new Messaging.inboundEmail.TextAttachment[] { attachmenttext };
            
        // call the email service class and test it with the data in the testMethod
        InsertContactFromXML insertContact=new InsertContactFromXML ();
        insertContact.handleInboundEmail(email, env);
        
        List<Contact> contacts=[SELECT Id,Name FROM Contact];
        System.assertEquals(6, contacts.size());
    }
}