/*
*********************************************************
Apex Class Name    : FacebookUtil
Created Date       : Feb 29, 2024
@description       : Utility class for slack integration
@author            : Soham Datta

Modification Log:

Ver   Date         Author                               Modification
1.0   29-02-2024   Soham Datta                      	Initial Version
*********************************************************
*/

public with sharing class FacebookUtil {
    
    /*
    *********************************************************
    @Method Name    : postMessage
    @author         : Soham Datta  
    @description    : Method to get facebook admin id
    @param          : 
    @return         : String
    *********************************************************
	*/

    @TestVisible
    private static String getProfileInfo(){
        
        String adminId = '';
        String endPoint = 'callout:Facebook/v19.0/me?fields=id%2Cname';
        
        Http http = new Http();
        //Preparing request for integration
        HttpRequest httpReq = prepareRequest(endPoint, ConstantClass.METHOD_GET, '');
        HttpResponse response = new HttpResponse();
        System.debug('httpReq: '+httpReq);
        
        try{
            //Sending payload
            response = http.send(httpReq);
            System.debug('Body: '+response.getBody());
            if(response.getStatusCode() == 200){
                Map<String, Object> jsonMap = (Map<String, Object>)JSON.deserializeUntyped(response.getBody());
                adminId = (String)jsonMap.get('id');
            }else{
                throw new CustomException(response.getBody());
            }
        }catch(Exception e){
            throw new CustomException(e.getMessage());
        }
        return adminId;
    }
    
    /*
    *********************************************************
    @Method Name    : getPageInfo
    @author         : Soham Datta  
    @description    : Method to get facebook page id
    @param          : 
    @return         : Map<String, String>
    *********************************************************
	*/

    @AuraEnabled(cacheable=true)
    public static Map<String, String> getPageInfo(){
        
        // Create a Map<String, String> with key as page name and value as corresponding id and access token
        Map<String, String> mapPageInfo = new Map<String, String>();
        String adminId = getProfileInfo();
        String endPoint = 'callout:Facebook/v19.0/' + adminId + '/accounts';
        
        Http http = new Http();
        //Preparing request for integration
        HttpRequest httpReq = prepareRequest(endPoint, ConstantClass.METHOD_GET, '');
        HttpResponse response = new HttpResponse();
        
        try{
            //Sending payload
            response = http.send(httpReq);
           
            if(response.getStatusCode() == 200){
                Map<String, Object> jsonData = (Map<String, Object>)JSON.deserializeUntyped(response.getBody());
                
                // Access the 'data' array
                List<Object> dataArray = (List<Object>)jsonData.get('data');
                
                // Iterate over the elements in the 'data' array
                for (Object data : dataArray) {
                    Map<String, Object> dataMap = (Map<String, Object>)data;
                    String name = (String)dataMap.get('name');
                    String id = (String)dataMap.get('id');
                    String access_token = (String)dataMap.get('access_token');
                    String pageToken = id + ':' + access_token;
                    
                    mapPageInfo.put(name, pageToken);
                }
                
            }else{
                throw new CustomException(response.getBody());
            }
        }catch(Exception e){
            throw new CustomException(e.getMessage());
        }
        return mapPageInfo;
    }
    
    /*
    *********************************************************
    @Method Name    : postFeedMessage
    @author         : Soham Datta  
    @description    : Method to post message on facebook page
    @param          : 
    @return         : 
    *********************************************************
	*/

    @AuraEnabled(cacheable=true)
    public static String postFeedMessage(String pageId, String access_token, String message){
        
        String postId = '';
        String endPoint = 'callout:Facebook/v19.0/' + pageId + '/feed?access_token=' + access_token;
        String requestBody = '{"message": "' + message + '"}';
        
        Http http = new Http();
        //Preparing request for integration
        HttpRequest httpReq = prepareRequest(endPoint, ConstantClass.METHOD_POST, requestBody);
        HttpResponse response = new HttpResponse();
        
        try{
            //Sending payload
            response = http.send(httpReq);
           
            if(response.getStatusCode() == 200){
                Map<String, Object> jsonData = (Map<String, Object>)JSON.deserializeUntyped(response.getBody());
                postId = String.valueOf(jsonData.get('id'));
            }else{
                throw new CustomException(response.getBody());
            }
        }catch(Exception e){
            throw new CustomException(e.getMessage());
        }
        return postId;
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