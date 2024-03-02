/*
************************************************************************
Class Name         : OpenCageUtilTest
Created Date       : Feb 6, 2024
@description       : Test class for OpenCageUtil
@author            : Soham Datta

Modification Log   :
Ver   Date         Author                               Modification
1.0   06-02-2024   Soham Datta                         Initial Version
*************************************************************************
*/

@isTest(seeAllData=false)
private class OpenCageUtilTest {

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
        User adminUser = TestDataSetup.createUser(adminProfile.Id, 'opencageuser@coordinate.com');
        
    }

    /*
    *********************************************************
    @Method Name    : testReverseGeoCoding
    @author         : Soham Datta  
    @description    : Test reverseGeoCoding method
    @param          :
    *********************************************************
    */    

    @isTest
    static void testReverseGeoCoding() {

        User admin = [Select Id From User Where UserName = 'opencageuser@coordinate.com'];
        String address = '';

        // Starting the test execution.
        Test.startTest();
        
        System.runAs(admin) {
            
            // Setting up a mock for the HTTP callout to ServiceNow.
            Test.setMock(HttpCalloutMock.class, new OpenCageMock());
            
            //Providing Latitude and Longitude
            address = OpenCageUtil.reverseGeoCoding('22.5726', '88.3639');
            Assert.areEqual('Chatterjee Lane, Bowbazar, Kolkata - 700073, West Bengal, India', address);         
        }

        // Stopping the test execution.
        Test.stopTest();

    }

    /*
    *********************************************************
    @Method Name    : testForwardGeoCoding
    @author         : Soham Datta  
    @description    : Test forwardGeoCoding method
    @param          :
    *********************************************************
    */    

    @isTest
    static void testForwardGeoCoding() {

        User admin = [Select Id From User Where UserName = 'opencageuser@coordinate.com' Limit 1];
        OpenCageWrapper.Geometry coordinate;

        // Starting the test execution.
        Test.startTest();
        
        System.runAs(admin) {
            
            // Setting up a mock for the HTTP callout to ServiceNow.
            Test.setMock(HttpCalloutMock.class, new OpenCageMock());
            
            //Providing Address
            coordinate = OpenCageUtil.forwardGeoCoding('Chatterjee Lane, Bowbazar, Kolkata - 700073, West Bengal, India');
            Assert.areEqual(22.5728603, coordinate.lat);
            Assert.areEqual(88.3640167, coordinate.lng);
            
        }

        // Stopping the test execution.
        Test.stopTest();

    }
}