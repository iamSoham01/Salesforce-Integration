/*
************************************************************************
Class Name         : FacebookUtilTest
Created Date       : March 2, 2024
@description       : Test class for SlackUtil
@author            : Soham Datta

Modification Log   :
Ver   Date         Author                               Modification
1.0   02-03-2024   Soham Datta                         Initial Version
*************************************************************************
*/

@isTest(seeAllData=false)
private class FacebookUtilTest {
    
    /*
    *********************************************************
    @Method Name    : setupData
    @author         : Soham Datta  
    @description    : Test setup data
    @param          :
    *********************************************************
    */    
    
    @TestSetup
    static void setupData(){

        Profile adminProfile = TestDataSetup.createProfile('System Administrator');
        User adminUser = TestDataSetup.createUser(adminProfile.Id, 'adminmyownuser@facebookmeta.com');
        
    }
    
    /*
    *********************************************************
    @Method Name    : testPostFeedMessage
    @author         : Soham Datta  
    @description    : Test postFeedMessage() method
    @param          :
    *********************************************************
    */
    
    @isTest
    static void testPostFeedMessage() {
        
        User admin = [Select Id From User Where UserName = 'adminmyownuser@facebookmeta.com' Limit 1];
        
        // Starting the test execution.
        Test.startTest();
        
        System.runAs(admin) {
            
            // Setting up a mock for the HTTP callout to ServiceNow.
            Test.setMock(HttpCalloutMock.class, new FacebookUtilMock());
            
            //Test Scenario 1: Providing payload
            //Assert.areEqual('Your message has been posted successfully! Timestamp: 1709140932.696539', responseMsg);
            
        }
        
        // Stopping the test execution.
        Test.stopTest();
        
    }

}