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
    @description    : test method for integrating with ServiceNow.
    @param          :
    *********************************************************
    */    
    @isTest
    static void testIntegrateServiceNow() {
        
        User admin = [Select Id From User Where UserName = 'adminuser@servicenow.com'];
        String message = 'Test Incident';
        
        // Starting the test execution.
        Test.startTest();
        
        // Setting up a mock for the HTTP callout to ServiceNow.
        Test.setMock(HttpCalloutMock.class, new ServicenowCommunicationMock());
        
        System.runAs(admin) {
            
            // Performing the integration and getting actual output parameters.
            String incidentId = ServicenowUtil.createIncident(message);
            
            // Asserting that the actual output matches the expected output.
            Assert.areEqual('INC0010032', incidentId);
            
        }
        
        // Stopping the test execution.
        Test.stopTest();
        
    }
    
}