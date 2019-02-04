package com.metacube.connection;

import com.sforce.async.SObject;
import com.sforce.soap.enterprise.EnterpriseConnection;
import com.sforce.soap.enterprise.SaveResult;
import com.sforce.soap.enterprise.sobject.Student__c;
import com.sforce.ws.ConnectionException;

public class InsertStudents {
;
	public void insertStudent(EnterpriseConnection connection) throws ConnectionException{
		
		Student__c student;
		Student__c[] studentArray=new Student__c[5];
		for(int i=0;i<5;i++){
			student=new Student__c();
			student.setName("Student"+i);
			student.setLast_Name__c("Student"+i);
			student.setSex__c("Female");
			student.setClass__c("a010o00001obipdAAA");
			studentArray[i]=student;
		}
		
		try {
			SaveResult[] saveResults=connection.create(studentArray);
			for(int i=0;i<saveResults.length;i++){
				if(saveResults[i].isSuccess()){
					System.out.println("Inserted");
				}
				else{
					System.out.println("Error"+saveResults[i].getErrors()[0].getMessage());

				}
			}
		} catch (ConnectionException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
