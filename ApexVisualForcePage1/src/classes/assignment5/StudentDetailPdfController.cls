public class StudentDetailPdfController {
    private String studentId;
	
    public StudentDetailPdfController(ApexPages.StandardController setCon){
        studentId=ApexPages.currentPage().getParameters().get('id');
    }
    
    
    public PageReference saveAttachment(){
       	 PageReference pdf=Page.StudentDetailPage;
         pdf.getParameters().put('id',studentId);
         List<Attachment> attachments=[SELECT Id,ParentId FROM Attachment WHERE ParentId=:studentId];
        
        if(attachments.size()>0){
            delete attachments;
        }
        
        Attachment attachment=new Attachment();
        
        Blob body;
        
        try{
            body=pdf.getContentAsPDF();
        }
        catch(VisualforceException e){
            body=Blob.valueOf('Error');
        }
        	attachment.Body=body;
        	attachment.Name='StudentDetail.pdf';
            attachment.ParentId=studentId;
            insert attachment;
        
        return new PageReference('/'+studentId);
    }
}