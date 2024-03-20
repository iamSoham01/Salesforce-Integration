/*
************************************************************************
Class Name         : SlackUtilTest
Created Date       : Feb 28, 2024
@description       : Test class for SlackUtil
@author            : Soham Datta

Modification Log   :
Ver   Date         Author                               Modification
1.0   28-02-2024   Soham Datta                         Initial Version
*************************************************************************
*/

@isTest(seeAllData=false)
private class SlackUtilTest {
    
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
        User adminUser = TestDataSetup.createUser(adminProfile.Id, 'slackadminuser@slack.com');
        
    }
    
    /*
    *********************************************************
    @Method Name    : testGetAllChannels
    @author         : Soham Datta  
    @description    : Test getAllChannels() method
    @param          :
    *********************************************************
    */
    
    @isTest
    static void testGetAllChannels() {
        
        User admin = [Select Id From User Where UserName = 'slackadminuser@slack.com' Limit 1];
        
        // Starting the test execution.
        Test.startTest();
        
        System.runAs(admin) {
            
            // Setting up a mock for the HTTP callout to ServiceNow.
            Test.setMock(HttpCalloutMock.class, new SlackUtilMock());
            
            //Test Scenario 1: Providing payload
            Map<String, String> mapAllChannels = SlackUtil.getAllChannels();
            Assert.areEqual(1, mapAllChannels.size());
            
        }
        
        // Stopping the test execution.
        Test.stopTest();
        
    }
    
    /*
    *********************************************************
    @Method Name    : testPostMessage
    @author         : Soham Datta  
    @description    : Test postMessage() method
    @param          :
    *********************************************************
    */
    
    @isTest
    static void testPostMessage() {
        
        User admin = [Select Id From User Where UserName = 'slackadminuser@slack.com' Limit 1];
        
        String message = 'Hello World!';
        String channelId = 'C06MGMQERPA';
        
        // Starting the test execution.
        Test.startTest();
        
        System.runAs(admin) {
            
            // Setting up a mock for the HTTP callout to ServiceNow.
            Test.setMock(HttpCalloutMock.class, new SlackUtilMock());
            
            //Test Scenario 1: Providing payload
            String responseMsg = SlackUtil.postMessage(message, channelId);
            Assert.areEqual('1709140932.696539', responseMsg);
            
        }
        
        // Stopping the test execution.
        Test.stopTest();
        
    }
    
    /*
    *********************************************************
    @Method Name    : testDeleteMessage
    @author         : Soham Datta  
    @description    : Test deleteMessage() method
    @param          :
    *********************************************************
    */
    
    @isTest
    static void testDeleteMessage() {
        
        User admin = [Select Id From User Where UserName = 'slackadminuser@slack.com' Limit 1];
        
        String timeStamp = '1709140932.696539';
        String channelId = 'C06MGMQERPA';
        
        // Starting the test execution.
        Test.startTest();
        
        System.runAs(admin) {
            
            // Setting up a mock for the HTTP callout to ServiceNow.
            Test.setMock(HttpCalloutMock.class, new SlackUtilMock());
            
            //Test Scenario 1: Providing payload
            String responseMsg = SlackUtil.deleteMessage(timeStamp, channelId);
            Assert.areEqual('Your message has been deleted successfully!', responseMsg);
            
        }
        
        // Stopping the test execution.
        Test.stopTest();
        
    }

}