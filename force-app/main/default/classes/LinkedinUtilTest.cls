/*
************************************************************************
Class Name         : LinkedinUtilTest
Created Date       : Feb 15, 2024
@description       : Test class for LinkedinUtil
@author            : Soham Datta

Modification Log   :
Ver   Date         Author                               Modification
1.0   15-02-2024   Soham Datta                         Initial Version
*************************************************************************
*/

@isTest(seeAllData=false)
private class LinkedinUtilTest {
    
    /*
    *********************************************************
    @Method Name    : testCreatePost
    @author         : Soham Datta  
    @description    : Test testCreatePost() method
    @param          :
    *********************************************************
    */
    
    @isTest
    static void testCreatePost() {
        
        String msg = 'Hello World!';
        String linkedinVersion = '202401';
        
        // Starting the test execution.
        Test.startTest();
        
        // Setting up a mock for the HTTP callout to Linkedin.
        Test.setMock(HttpCalloutMock.class, new LinkedinUtilMock());
        
        //Test Scenario 1: Passing message and linkedin version
        String responseMsg = LinkedinUtil.createPost(msg, linkedinVersion);
        Assert.areEqual(LinkedinUtil.SUCCESS_RESPONSE, responseMsg);
        
        // Stopping the test execution.
        Test.stopTest();
        
    }

}