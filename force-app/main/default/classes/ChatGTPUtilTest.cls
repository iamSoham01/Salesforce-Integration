/*
************************************************************************
Class Name         : ChatGTPUtil
Created Date       : Feb 8, 2024
@description       : Test class for ChatGTPUtil
@author            : Soham Datta

Modification Log   :
Ver   Date         Author                               Modification
1.0   04-02-2024   Soham Datta                         Initial Version
*************************************************************************
*/

@isTest(seeAllData=false)
private class ChatGTPUtilTest {

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
        User adminUser = TestDataSetup.createUser(adminProfile.Id, 'chatgtpask@opeanairequest.com');
        
    }

    /*
    *********************************************************
    @Method Name    : testGetResponseMsg
    @author         : Soham Datta  
    @description    : Test getResponseMsg method
    @param          :
    *********************************************************
    */  

    @isTest
    static void testGetResponseMsg() {

        User admin = [Select Id From User Where UserName = 'chatgtpask@opeanairequest.com'];
        String responseMsg = '';

        // Starting the test execution.
        Test.startTest();
        
        System.runAs(admin) {
            
            // Setting up a mock for the HTTP callout to ServiceNow.
            Test.setMock(HttpCalloutMock.class, new ChatGTPMock());

            String expectedResponse = 'MS Dhoni, also known as Mahendra Singh Dhoni, is a former Indian international cricketer and captain of the Indian national cricket team.';
            
            //Providing prompt
            responseMsg = ChatGTPUtil.getResponseMsg('Who is MS Dhoni?');
            Assert.areEqual(expectedResponse, responseMsg);

        }

        // Stopping the test execution.
        Test.stopTest();

    }
    
}