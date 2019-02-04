package com.metacube.connection;

import java.util.List;

import com.sforce.soap.enterprise.EnterpriseConnection;
import com.sforce.soap.enterprise.sobject.Contact;
import com.sforce.ws.ConnectionException;

public class MainClass {
	public static void main(String[] args){
		try {
			EnterpriseConnection connection =SalesforceConnection.login();
			GetContacts getContacts=new GetContacts();
			InsertStudents  insertStudent=new InsertStudents();
			insertStudent.insertStudent(connection);
		
			List<Contact> contactList=getContacts.getContacts(connection);
			for(Contact contact:contactList){
				System.out.println("Name  : "+ contact.getName());
			}
		} catch (ConnectionException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
}
