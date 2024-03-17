/*
*********************************************************
Apex Class Name    : SpotifyEvents
Created Date       : Mar 15, 2024
@description       : Utility class for spotify integration callout
@author            : Soham Datta

Modification Log:

Ver   Date         Author                               Modification
1.0   15-03-2024   Soham Datta                      	Initial Version
*********************************************************
*/

public class SpotifyEvents {

    /*
    *********************************************************
    @Method Name    : checkCurrentPlaying
    @author         : Soham Datta  
    @description    : Method to get details of current playing song on spotify
    @param          : 
    @return         : Map<String, String>
    *********************************************************
	*/

    public static Map<String, String> checkCurrentPlaying(){
        
        Map<String, String> mapSongInfo = new Map<String, String>();
        String endPoint = 'callout:Spotify/me/player/currently-playing';
        
        Http http = new Http();
        //Preparing request for integration
        HttpRequest httpReq = CalloutUtility.prepareRequest(endPoint, ConstantClass.METHOD_GET, '');
        HttpResponse response = new HttpResponse();
        
        try{
            //Sending payload
            response = http.send(httpReq);
            
            if(response.getStatusCode() == 200){
                
                Map<String, Object> deserializedResult = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
                Map<String, Object> item = (Map<String, Object>) deserializedResult.get('item');
                
                List<Object> artistsList = ((List<Object>) item.get('artists'));
                Map<String, Object> album = (Map<String, Object>) item.get('album');
                List<Object> imagesList = (List<Object>) album.get('images');
                
                Map<String, Object> imageForCover = (Map<String, Object>) imagesList[0];
                Map<String, Object> artistObject = (Map<String, Object>) artistsList[0];
                
                mapSongInfo.put('musicName', (String) item.get('name'));
                mapSongInfo.put('albumPhoto', (String) imageForCover.get('url'));
                mapSongInfo.put('artistName', (String) artistObject.get('name'));
                
            }else{
                throw new CustomException(response.getBody());
            }
        }catch(Exception e){
            throw new CustomException(e.getMessage());
        }
        return mapSongInfo;
    }

    /*
    *********************************************************
    @Method Name    : getAvailableDevices
    @author         : Soham Datta  
    @description    : Method to get available devices for playing on spotify
    @param          : 
    @return         : String
    *********************************************************
	*/

    private static String getAvailableDevices(){
        
        String deviceId = '';
        String endPoint = 'callout:Spotify/me/player/devices';
        
        Http http = new Http();
        //Preparing request for integration
        HttpRequest httpReq = CalloutUtility.prepareRequest(endPoint, ConstantClass.METHOD_GET, '');
        HttpResponse response = new HttpResponse();
        
        try{
            //Sending payload
            response = http.send(httpReq);
            
            if(response.getStatusCode() == 200){
                
                Map<String, Object> parsedJson = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
                List<Object> devices = (List<Object>) parsedJson.get('devices');
                if (devices != null && !devices.isEmpty()) {
                    Map<String, Object> firstDevice = (Map<String, Object>) devices[0];
                    deviceId = (String) firstDevice.get('id');
                }
                
            }else{
                throw new CustomException(response.getBody());
            }
        }catch(Exception e){
            throw new CustomException(e.getMessage());
        }
        return deviceId;
    }

    /*
    *********************************************************
    @Method Name    : searchTracks
    @author         : Soham Datta  
    @description    : Method to search song name on spotify
    @param          : searchTerm
    @return         : List<TrackWrapper>
    *********************************************************
	*/

    public static List<TrackWrapper> searchTracks(String searchTerm){
        
        List<TrackWrapper> trackWrappers = new List<TrackWrapper>();

        String endPoint = 'callout:Spotify/search?type=track&limit=6&offset=6&q=' + String.escapeSingleQuotes(searchTerm.replace(' ', '+'));
        
        Http http = new Http();
        //Preparing request for integration
        HttpRequest httpReq = CalloutUtility.prepareRequest(endPoint, ConstantClass.METHOD_GET, '');
        HttpResponse response = new HttpResponse();
        
        try{
            //Sending payload
            response = http.send(httpReq);
            
            if(response.getStatusCode() == 200){
                
                Map<String, Object> parsedJson = (Map<String, Object>)JSON.deserializeUntyped(response.getBody());
                Map<String, Object> tracks = (Map<String, Object>)parsedJson.get('tracks');
                List<Object> items = (List<Object>)tracks.get('items');

                for(Object item : items) {
                    Map<String, Object> track = (Map<String, Object>)item;
                    String songName = (String)track.get('name');
                    String songUri = (String)track.get('uri');
                    List<Object> images = (List<Object>)((Map<String, Object>)track.get('album')).get('images');
                    String songThumbnail = (String)((Map<String, Object>)images[1]).get('url');

                    trackWrappers.add(new TrackWrapper(songName, songUri, songThumbnail));
                }
                
            }else{
                throw new CustomException(response.getBody());
            }
        }catch(Exception e){
            throw new CustomException(e.getMessage());
        }

        return trackWrappers;
    }

    /*
    *********************************************************
    @Method Name    : startPlayback
    @author         : Soham Datta  
    @description    : Method to start or resume playback on spotify
    @param          : searchTerm
    @return         : 
    *********************************************************
	*/

    public static void startPlayback(String trackURI){
        
        String deviceId = getAvailableDevices();
        
        if(String.isBlank(deviceId)) {
            throw new CustomException('Device is not available');
        }

        String endPoint = 'callout:Spotify/me/player/play?device_id=' + deviceId;
        String requestBody = '{'
                            + '"uris": ["' + String.escapeSingleQuotes(trackURI) +'"],'
                            + '"offset": {'
                            + '"position": 0'
                            + '},'
                            + '"position_ms": 0'
                            + '}';
        
        Http http = new Http();
        //Preparing request for integration
        HttpRequest httpReq = CalloutUtility.prepareRequest(endPoint, ConstantClass.METHOD_PUT, requestBody);
        HttpResponse response = new HttpResponse();
        
        try{
            //Sending payload
            response = http.send(httpReq);
            
            if(response.getStatusCode() == 204){
                
            }else{
                throw new CustomException(response.getBody());
            }
        }catch(Exception e){
            throw new CustomException(e.getMessage());
        }

    }

    /*
    *********************************************************
    @Method Name    : pausePlayback
    @author         : Soham Datta  
    @description    : Method to pause playback on spotify
    @param          : 
    @return         : 
    *********************************************************
	*/

    public static void pausePlayback(){
        
        String deviceId = getAvailableDevices();
        
        if(String.isBlank(deviceId)) {
            throw new CustomException('Device is not available');
        }

        String endPoint = 'callout:Spotify/me/player/pause?device_id=' + deviceId;
        String requestBody = '{'
                            + '"Content-Length": "0"'
                            + '}';
        
        Http http = new Http();
        //Preparing request for integration
        HttpRequest httpReq = CalloutUtility.prepareRequest(endPoint, ConstantClass.METHOD_PUT, requestBody);
        HttpResponse response = new HttpResponse();
        
        try{
            //Sending payload
            response = http.send(httpReq);
            
            if(response.getStatusCode() == 204){
                
            }else{
                throw new CustomException(response.getBody());
            }
        }catch(Exception e){
            throw new CustomException(e.getMessage());
        }

    }
    
}