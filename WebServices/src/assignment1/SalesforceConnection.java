package com.metacube.connection;
import com.sforce.soap.enterprise.EnterpriseConnection;
import com.sforce.soap.enterprise.LoginResult;

import com.sforce.ws.ConnectionException;
import com.sforce.ws.ConnectorConfig;

public class SalesforceConnection {
	
	public static EnterpriseConnection login() throws ConnectionException {
        final String USERNAME = "komal.khatri@metacube.com";
        // This is only a sample. Hard coding passwords in source files is a bad practice.
        final String PASSWORD = "Komal@12xvFNO5Xs9rkcM9taDniwhee9"; 
        final String URL = "https://login.salesforce.com/services/Soap/c/44.0";
        final LoginResult loginResult = loginToSalesforce(USERNAME, PASSWORD, URL);
        return createMetadataConnection(loginResult);
    }

    private static EnterpriseConnection createMetadataConnection(
            final LoginResult loginResult) throws ConnectionException {
        final ConnectorConfig config = new ConnectorConfig();
        config.setServiceEndpoint(loginResult.getServerUrl());
        config.setSessionId(loginResult.getSessionId());
        return new EnterpriseConnection(config);
    }

    private static LoginResult loginToSalesforce(
            final String username,
            final String password,
            final String loginUrl) throws ConnectionException {
        final ConnectorConfig config = new ConnectorConfig();
        config.setAuthEndpoint(loginUrl);
        config.setServiceEndpoint(loginUrl);
        config.setManualLogin(true);
        return (new EnterpriseConnection(config)).login(username, password);
    }
}
