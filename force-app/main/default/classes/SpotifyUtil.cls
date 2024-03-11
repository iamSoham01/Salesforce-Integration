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
    @Method Name    : checkCurrentPlaying
    @author         : Soham Datta  
    @description    : Method to get details of current playing song on spotify
    @param          : 
    @return         : Map<String, String>
    *********************************************************
	*/

    public static Map<String, String> checkCurrentPlaying(){
        
        Map<String, String> mapSongInfo = new Map<String, String>();
        String endPoint = 'callout:Spotify/player/currently-playing';
        
        Http http = new Http();
        //Preparing request for integration
        HttpRequest httpReq = prepareRequest(endPoint, ConstantClass.METHOD_GET, '');
        System.debug('httpReq: '+httpReq);
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
    @Method Name    : getSongInformations
    @author         : Soham Datta  
    @description    : This method help us to avoid cacheable=true annotation, so we get the right song when Spotify API is called
    @param          : 
    @return         : Map<String, String>
    *********************************************************
	*/
    
    @AuraEnabled
    public static Map<String, String> getSongInformations() {
        return checkCurrentPlaying();
    }
 
    /*
    *********************************************************
    @Method Name    : prepareRequest
    @author         : Soham Datta  
    @description    : Method to prepare request for integration callout
    @param          : endPoint, method, requestBody
    @return         : HttpRequest
    *********************************************************
	*/
    public static HttpRequest prepareRequest(String endPoint, String method, String requestBody){
        
        httpRequest httpReq = new httpRequest();
        httpReq.setMethod(method);
        httpReq.setEndpoint(endPoint);
        if(String.isNotBlank(requestBody)) {
            httpReq.setBody(requestBody);
        }
        return httpReq;
        
    }

}