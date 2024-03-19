/*
************************************************************************
Class Name         : YoutubeCallout
Created Date       : Mar 18, 2024
@description       : This class is used to perform callout to Youtube
@author            : Soham Datta

Modification Log   :
Ver   Date         Author                               Modification
1.0   18-03-2024   Soham Datta                         Initial Version
*************************************************************************
*/

public class YoutubeCallout {

    /*
    *********************************************************
    @Method Name    : searchVideos
    @author         : Soham Datta  
    @description    : Method to search videos on Youtube
    @param          : searchQuery
    @return         : 
    *********************************************************
    */

    public static List<YoutubeSearchWrapper> searchVideos(String searchQuery){

        List<YoutubeSearchWrapper> videoSearchWrapper = new List<YoutubeSearchWrapper>();

        String encodedString = EncodingUtil.urlEncode(String.escapeSingleQuotes(searchQuery), 'UTF-8');
                
        // Set up Youtube endpoint
        String endpoint = 'callout:Youtube/youtube/v3/search?part=snippet&type=video&maxResults=3&q=' + encodedString;
                
        // Create and send HTTP request
        Http http = new Http();
        HttpRequest httpReq   = CalloutUtility.prepareRequest(endPoint, ConstantClass.METHOD_GET, '');
        HttpResponse response = new HttpResponse();
        
        try{
            response = http.send(httpReq);

            // Parse response and extract ID
            if( response.getStatusCode() == 200){
                // Parse JSON
                Map<String, Object> responseMap = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());

                // Get items array
                for(Object item: (List<Object>) responseMap.get('items')) {
                    Map<String, Object> idMap = (Map<String, Object>) ((Map<String, Object>) item).get('id');
                    String videoId = (String) idMap.get('videoId');

                    Map<String, Object> snippetMap = (Map<String, Object>) ((Map<String, Object>) item).get('snippet');
                    String videoTitle = (String) snippetMap.get('title');
                    Map<String, Object> thumbnailsMap = (Map<String, Object>) snippetMap.get('thumbnails');
                    Map<String, Object> highResThumbnailMap = (Map<String, Object>) thumbnailsMap.get('high');
                    String videoThumbnail = (String) highResThumbnailMap.get('url');

                    YoutubeSearchWrapper videoWrapper = new YoutubeSearchWrapper();
                    videoWrapper.videoURL = videoId;
                    videoWrapper.videoTitle = videoTitle.unescapeHtml4();
                    videoWrapper.videoThumbnail = videoThumbnail;
                    videoSearchWrapper.add(videoWrapper);

                }

            }else{
                throw new CustomException(response.getBody());
            }
            
        }catch(Exception e){
            throw new CustomException(e.getMessage());
        }

        return videoSearchWrapper;
    }
    
}