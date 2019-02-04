public class EmailPOJO {
	public List<String> addresses;
    public String body;
    public String subject;
    
    public EmailPOJO(List<String> addresses,String body,String subject) {
        this.addresses=addresses;
        this.body=body;
        this.subject=subject;
    }
}