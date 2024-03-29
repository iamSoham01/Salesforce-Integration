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
        
        Map<String, Object> mapAttributes = new Map<String, Object>();
        mapAttributes.put('endDateTime', endDateTime);
        mapAttributes.put('startDateTime', startDateTime);
        mapAttributes.put('timeZone', timeZone);
        mapAttributes.put('meetingSubject', meetingSubject);
        mapAttributes.put('meetingDescription', meetingDescription);
        mapAttributes.put('attendeesEmailList', 'testuser1@gmail.com');
        
        // Starting the test execution.
        Test.startTest();
        
        System.runAs(admin) {
            
            // Setting up a mock for the HTTP callout to ServiceNow.
            Test.setMock(HttpCalloutMock.class, new GoogleUtilMock());
            
            //Test Scenario 1: Providing payload
            String meetingURL = GoogleUtil.createCalenderMeeting(mapAttributes);
            Assert.areEqual('https://www.google.com/calendar/event?eid=M3NycHYxZjhibmU2ZW1nbzh2NWc0cXJlYzQgc29oYW1kYXR0YTAxQG0', meetingURL);
            
        }
        
        // Stopping the test execution.
        Test.stopTest();
        
    }

    /*
    *********************************************************
    @Method Name    : testGmail
    @author         : Soham Datta  
    @description    : Test sendEmail() method
    @param          :
    *********************************************************
    */
    
    @isTest
    static void testGmail() {
        
        User admin = [Select Id From User Where UserName = 'googleuser@calenderevnt.com' Limit 1];
        
        String senderEmail = 'testsender@gmail.com';
        String receiverEmail = 'testreceiver@gmail.com';
        String emailSubject = 'Test Subject';
        String emailBody = 'Test Email Body';
        
        Map<String, Object> mapAttributes = new Map<String, Object>();
        mapAttributes.put('senderEmail', senderEmail);
        mapAttributes.put('receiverEmail', receiverEmail);
        mapAttributes.put('emailSubject', emailSubject);
        mapAttributes.put('emailBody', emailBody);

        // Starting the test execution.
        Test.startTest();
        
        System.runAs(admin) {
            
            // Setting up a mock for the HTTP callout to ServiceNow.
            Test.setMock(HttpCalloutMock.class, new GoogleUtilMock());
            
            //Test Scenario 1: Providing payload
            Map<String, String> actualResponseMap = GoogleUtil.sendEmail(mapAttributes);
            Assert.areEqual(2, actualResponseMap.size());
            
        }
        
        // Stopping the test execution.
        Test.stopTest();
        
    }
    
    /*
    *********************************************************
    @Method Name    : testUploadFiles
    @author         : Soham Datta  
    @description    : Test uploadFiles() method
    @param          :
    *********************************************************
    */
    
    @isTest
    static void testUploadFiles() {
        
        User admin = [Select Id From User Where UserName = 'googleuser@calenderevnt.com' Limit 1];
        
        String fileName = 'logo.png';
        String fileContent = 'XYSAMKKDNJNNBAHBHBBWVDHBHBHWBHJBDHBHDBBHWBHBHBHB';
        String fileType = 'image/png';
        
        Map<String, Object> mapAttributes = new Map<String, Object>();
        mapAttributes.put('fileName', fileName);
        mapAttributes.put('fileContent', fileContent);
        mapAttributes.put('fileType', fileType);

        // Starting the test execution.
        Test.startTest();
        
        System.runAs(admin) {
            
            // Setting up a mock for the HTTP callout to ServiceNow.
            Test.setMock(HttpCalloutMock.class, new GoogleUtilMock());
            
            //Test Scenario 1: Providing payload
            String uploadedFileId = GoogleUtil.uploadFiles(mapAttributes);
            Assert.areEqual('1-aio3oRYmrvWfV-glLWfj_Kiw0Y_Sg_7', uploadedFileId);
            
        }
        
        // Stopping the test execution.
        Test.stopTest();
        
    }
    
    /*
    *********************************************************
    @Method Name    : testDeleteFiles
    @author         : Soham Datta  
    @description    : Test deleteFiles() method
    @param          :
    *********************************************************
    */
    
    @isTest
    static void testDeleteFiles() {
        
        User admin = [Select Id From User Where UserName = 'googleuser@calenderevnt.com' Limit 1];
        
        String uploadedFileId = '1-aio3oRYmrvWfV-glLWfj_Kiw0Y_Sg_7';
        
        // Starting the test execution.
        Test.startTest();
        
        System.runAs(admin) {
            
            // Setting up a mock for the HTTP callout to ServiceNow.
            Test.setMock(HttpCalloutMock.class, new GoogleUtilMock());
            
            //Test Scenario 1: Providing payload
            String responseMsg = GoogleUtil.deleteFiles(uploadedFileId);
            Assert.areEqual('Your file has been deleted successfully!', responseMsg);
            
        }
        
        // Stopping the test execution.
        Test.stopTest();
        
    }
    
    /*
    *********************************************************
    @Method Name    : testSearchYoutubeVideos
    @author         : Soham Datta  
    @description    : Test searchYoutubeVideos() method
    @param          :
    *********************************************************
    */
    
    @isTest
    static void testSearchYoutubeVideos() {
        
        User admin = [Select Id From User Where UserName = 'googleuser@calenderevnt.com' Limit 1];
        String searchQuery = 'Tum Kya Mile';
                
        // Starting the test execution.
        Test.startTest();
        
        System.runAs(admin) {
            
            // Setting up a mock for the HTTP callout to ServiceNow.
            Test.setMock(HttpCalloutMock.class, new GoogleUtilMock());
            
            //Test Scenario 1: Providing payload
            List<YoutubeSearchWrapper> searchWrapper = GoogleUtil.searchYoutubeVideos(searchQuery);
            Assert.areEqual(3, searchWrapper.size());
            
        }
        
        // Stopping the test execution.
        Test.stopTest();
        
    }

}