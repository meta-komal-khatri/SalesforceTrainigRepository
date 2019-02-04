public class StudentHomeController {
	
    public List<Student__c> studentList;
    
    public Student__c studentObj{get;set;}
    public Boolean showDetails{get;set;}
    Transient StudentsSelector sSelector;
    
    public StudentHomecontroller(){
        showDetails=false;
    }
    public List<Student__c> getStudents(){
        sSelector=new StudentsSelector();
        return sSelector.selectAll(); 
    }
    
    public void studentDetails(){
        sSelector=new StudentsSelector(); 
        showDetails=true;
        studentObj=sSelector.selectById(new Set<Id>{ApexPages.currentPage().getParameters().get('id')}).get(0);
    }
}