/*
*********************************************************
Apex Class Name    : SpotifyUtil
Created Date       : Feb 29, 2024
@description       : Utility class for spotify integration
@author            : Soham Datta

Modification Log:

Ver   Date         Author                               Modification
1.0   29-02-2024   Soham Datta                      	Initial Version
*********************************************************
*/

public class SpotifyUtil {
    
    /*
    *********************************************************
    @Method Name    : getSongInformations
    @author         : Soham Datta  
    @description    : This method help us to avoid cacheable=true annotation, so we get the right song when Spotify API is called
    @param          : 
    @return         : Map<String, String>
    *********************************************************
	*/
    
    @AuraEnabled
    public static Map<String, String> getSongInformations() {
        return SpotifyEvents.checkCurrentPlaying();
    }

    /*
    *********************************************************
    @Method Name    : searchTracks
    @author         : Soham Datta  
    @description    : Method to search song name on spotify
    @param          : 
    @return         : List<TrackWrapper>
    *********************************************************
	*/
    
    @AuraEnabled
    public static List<TrackWrapper> searchTracks(String trackName) {
        return SpotifyEvents.searchTracks(trackName);
    }

    /*
    *********************************************************
    @Method Name    : startPlayback
    @author         : Soham Datta  
    @description    : Method to play or resume track on spotify
    @param          : 
    @return         : List<TrackWrapper>
    *********************************************************
	*/
    
    @AuraEnabled
    public static void startPlayback(String trackURI) {
        SpotifyEvents.startPlayback(trackURI);
    }

    /*
    *********************************************************
    @Method Name    : pausePlayback
    @author         : Soham Datta  
    @description    : Method to pause playback spotify
    @param          : 
    @return         : List<TrackWrapper>
    *********************************************************
	*/
    
    @AuraEnabled
    public static void pausePlayback() {
        SpotifyEvents.pausePlayback();
    }

}