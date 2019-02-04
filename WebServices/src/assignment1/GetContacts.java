package com.metacube.connection;

import java.util.LinkedList;
import java.util.List;

import com.sforce.async.SObject;
import com.sforce.soap.enterprise.EnterpriseConnection;
import com.sforce.soap.enterprise.QueryResult;
import com.sforce.soap.enterprise.sobject.Contact;
import com.sforce.ws.ConnectionException;

public class GetContacts {
	
	
	
	public GetContacts() {
		
	}
	
	@SuppressWarnings("unchecked")
	public List<Contact> getContacts(EnterpriseConnection connection) throws ConnectionException{
		
		QueryResult queryResults = connection.query("SELECT Id, Name FROM Contact");
		List<Contact> contactList=new LinkedList<Contact>();
		for(int i=0;i<queryResults.getSize();i++){
			contactList.add((Contact) queryResults.getRecords()[i]);
		}
		return contactList;
	}
}
