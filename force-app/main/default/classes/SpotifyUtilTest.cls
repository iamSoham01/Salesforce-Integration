/*
************************************************************************
Class Name         : SpotifyUtilTest
Created Date       : Feb 29, 2024
@description       : Test class for SpotifyUtil
@author            : Soham Datta

Modification Log   :
Ver   Date         Author                               Modification
1.0   29-02-2024   Soham Datta                         Initial Version
*************************************************************************
*/

@isTest(seeAllData=false)
private class SpotifyUtilTest {
    
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
        User adminUser = TestDataSetup.createUser(adminProfile.Id, 'hellouseradmin@spotify.com');
        
    }
    
    /*
    *********************************************************
    @Method Name    : testGetSongInformations
    @author         : Soham Datta  
    @description    : Test getSongInformations() method
    @param          :
    *********************************************************
    */
    
    @isTest
    static void testGetSongInformations() {
        
        User admin = [Select Id From User Where UserName = 'hellouseradmin@spotify.com' Limit 1];
        
        // Starting the test execution.
        Test.startTest();
        
        System.runAs(admin) {
            
            // Setting up a mock for the HTTP callout to Spotify.
            Test.setMock(HttpCalloutMock.class, new SpotifyUtilMock());
            
            //Scenario 1: Providing payload
            Map<String, String> mapSongInfo = SpotifyUtil.getSongInformations();
            Assert.areEqual('I Was Never There', mapSongInfo.get('musicName'));
            
        }
        
        // Stopping the test execution.
        Test.stopTest();
        
    }
    
    /*
    *********************************************************
    @Method Name    : testSearchTracks
    @author         : Soham Datta  
    @description    : Test searchTracks() method
    @param          :
    *********************************************************
    */
    
    @isTest
    static void testSearchTracks() {
        
        User admin = [Select Id From User Where UserName = 'hellouseradmin@spotify.com' Limit 1];
        
        // Starting the test execution.
        Test.startTest();
        
        System.runAs(admin) {
            
            // Setting up a mock for the HTTP callout to Spotify.
            Test.setMock(HttpCalloutMock.class, new SpotifyUtilMock());
            
            //Scenario 1: Providing payload
            List<TrackWrapper> trackWrapper = SpotifyUtil.searchTracks('dhoom');
            Assert.areEqual(2, trackWrapper.size());
            
        }
        
        // Stopping the test execution.
        Test.stopTest();
        
    }
    
    /*
    *********************************************************
    @Method Name    : testStartPlayback
    @author         : Soham Datta  
    @description    : Test startPlayback() method
    @param          :
    *********************************************************
    */
    
    @isTest
    static void testStartPlayback() {
        
        User admin = [Select Id From User Where UserName = 'hellouseradmin@spotify.com' Limit 1];
        String trackURI = 'spotify:track:1j6aCQO3m8Vo9xaIqzoAPh';
        
        // Starting the test execution.
        Test.startTest();
        
        System.runAs(admin) {
            
            // Setting up a mock for the HTTP callout to Spotify.
            Test.setMock(HttpCalloutMock.class, new SpotifyUtilMock());
            
            //Scenario 1: Providing payload
            SpotifyUtil.startPlayback(trackURI);
            
        }
        
        // Stopping the test execution.
        Test.stopTest();
        
    }
    
    /*
    *********************************************************
    @Method Name    : testPausePlayback
    @author         : Soham Datta  
    @description    : Test pausePlayback() method
    @param          :
    *********************************************************
    */
    
    @isTest
    static void testPausePlayback() {
        
        User admin = [Select Id From User Where UserName = 'hellouseradmin@spotify.com' Limit 1];
        
        // Starting the test execution.
        Test.startTest();
        
        System.runAs(admin) {
            
            // Setting up a mock for the HTTP callout to Spotify.
            Test.setMock(HttpCalloutMock.class, new SpotifyUtilMock());
            
            //Scenario 1: Providing payload
            SpotifyUtil.pausePlayback();
            
        }
        
        // Stopping the test execution.
        Test.stopTest();
        
    }

}