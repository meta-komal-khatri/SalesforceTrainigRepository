public with sharing class SelectedStudentsDeleteController {
    public List<Student__c> studentList;

    public List<Student__c> getSelectedStudents(){
        List<Id> studentIds=ApexPages.currentPage().getParameters().get('ids').split(',');
        studentList=[select Name,Sex__c,DOB__c,Class__r.Name,Class__c FROM Student__c WHERE Id IN : studentIds];
        return studentList;
    }
}