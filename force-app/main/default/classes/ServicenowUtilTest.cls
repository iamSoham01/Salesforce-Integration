/*
*********************************************************
Test Class Name    : ServicenowUtilTest
Created Date       : Jan 30, 2024
@description       : Test class for the integration with ServiceNow.
@author            : Soham Datta

Modification Log:

Ver   Date         Author                               Modification
1.0   30-01-2024   Soham Datta                      	Initial Version
*********************************************************
*/
@isTest(SeeAllData=false)
private class ServicenowUtilTest {
    
    @TestSetup
    static void setupData(){

        Profile adminProfile = TestDataSetup.createProfile('System Administrator');
        User adminUser = TestDataSetup.createUser(adminProfile.Id, 'adminuser@servicenow.com');
        
    }
    
    /*
    *********************************************************
    @Method Name    : testCreateIncident
    @author         : Soham Datta  
    @description    : test method for getCallerDetails()
    @param          :
    *********************************************************
    */    
    @isTest
    static void testGetCallerDetails() {
        
        User admin = [Select Id From User Where UserName = 'adminuser@servicenow.com'];
        
        // Starting the test execution.
        Test.startTest();
        
        // Setting up a mock for the HTTP callout to ServiceNow.
        Test.setMock(HttpCalloutMock.class, new ServicenowCommunicationMock());
        
        System.runAs(admin) {
            
            // Performing the integration and getting actual output parameters.
            Map<String, String> mapCallerInfo = ServicenowUtil.getCallerDetails();
            
            // Asserting that the actual output matches the expected output.
            Assert.areEqual(1, mapCallerInfo.size());
            
        }
        
        // Stopping the test execution.
        Test.stopTest();
        
    }
    
    /*
    *********************************************************
    @Method Name    : testCreateIncident
    @author         : Soham Datta  
    @description    : test method createIncident().
    @param          :
    *********************************************************
    */    
    @isTest
    static void testCreateIncident() {
        
        User admin = [Select Id From User Where UserName = 'adminuser@servicenow.com'];
        
        // Starting the test execution.
        Test.startTest();
        
        // Setting up a mock for the HTTP callout to ServiceNow.
        Test.setMock(HttpCalloutMock.class, new ServicenowCommunicationMock());
        
        System.runAs(admin) {
            
            String callerId = '88aad6c5c73003005f1b78d48b9763a5';
            String description = 'Test Incident';
            
            // Performing the integration and getting actual output parameters.
            String incidentNumber = ServicenowUtil.createIncident(callerId, description);
            
            // Asserting that the actual output matches the expected output.
            Assert.areEqual('INC0010032', incidentNumber);
            
        }
        
        // Stopping the test execution.
        Test.stopTest();
        
    }
    
}