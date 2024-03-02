/*
************************************************************************
Class Name         : GoogleUtilTest
Created Date       : Feb 12, 2024
@description       : Test class for GoogleUtil
@author            : Soham Datta

Modification Log   :
Ver   Date         Author                               Modification
1.0   12-02-2024   Soham Datta                         Initial Version
*************************************************************************
*/

@isTest(seeAllData=false)
private class GoogleUtilTest {
    
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
        User adminUser = TestDataSetup.createUser(adminProfile.Id, 'googleuser@calenderevnt.com');
        
    }
    
    /*
    *********************************************************
    @Method Name    : testCreateCalenderMeeting
    @author         : Soham Datta  
    @description    : Test createCalenderMeeting() method
    @param          :
    *********************************************************
    */
    
    @isTest
    static void testCreateCalenderMeeting() {
        
        User admin = [Select Id From User Where UserName = 'googleuser@calenderevnt.com' Limit 1];
        
        String endDateTime = '2030-01-01T09:00:00';
        String startDateTime = '2030-01-01T10:00:00';
        String timeZone = 'Asia/Kolkata';
        String meetingSubject = 'Best Rest API Course for Salesforce Developers';
        String meetingDescription = 'Please learn carefully';
        
        String requestBody = '{'
                        +'"end": {'
                        +  '"dateTime": "' + endDateTime + '",'
                        +  '"timeZone": "' + timeZone + '"'
                        + '},'
                        + '"start": {'
                        + '"dateTime": "' + startDateTime + '",'
                        + '"timeZone": "' + timeZone + '"'
                        + '},'
                        + '"summary": "' + meetingSubject + '",'
                        + '"location": "Online",'
                        + '"sendUpdates": "all",'
                        + '"description": "' + meetingDescription + '",'
                        + '"attendees":' + '[' 
                        +	'{'
      					+		'"email": "testuser1@gmail.com"'
    					+	'},'
    					+	'{'
      					+		'"email": "testuser2@gmail.com"'
    					+	'}' 
                        + ']'
                      +'}';
        
        // Starting the test execution.
        Test.startTest();
        
        System.runAs(admin) {
            
            // Setting up a mock for the HTTP callout to ServiceNow.
            Test.setMock(HttpCalloutMock.class, new GoogleUtilMock());
            
            //Test Scenario 1: Providing payload
            String meetingURL = GoogleUtil.createCalenderMeeting('test@gmail.com', requestBody);
            Assert.areEqual('https://www.google.com/calendar/event?eid=M3NycHYxZjhibmU2ZW1nbzh2NWc0cXJlYzQgc29oYW1kYXR0YTAxQG0', meetingURL);
            
        }
        
        // Stopping the test execution.
        Test.stopTest();
        
    }

}