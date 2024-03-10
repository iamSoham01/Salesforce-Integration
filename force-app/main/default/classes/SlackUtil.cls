/*
*********************************************************
Apex Class Name    : SlackUtil
Created Date       : Feb 27, 2024
@description       : Utility class for slack integration
@author            : Soham Datta

Modification Log:

Ver   Date         Author                               Modification
1.0   27-02-2024   Soham Datta                      	Initial Version
*********************************************************
*/

public with sharing class SlackUtil {
    
    /*
    *********************************************************
    @Method Name    : postMessage
    @author         : Soham Datta  
    @description    : Method to post a Slack message
    @param          : message, channelId
    @return         : String
    *********************************************************
	*/

    @AuraEnabled (cacheable=true)
    public static String postMessage(String message, String channelId){
        
        String responseMsg = '';
        String endPoint = 'callout:Slack/chat.postMessage';
        String requestBody = '{"text":"' + message + '", "channel":"' + channelId + '"}';
        
        Http http = new Http();
        //Preparing request for integration
        HttpRequest httpReq = prepareRequest(endPoint, ConstantClass.METHOD_POST, requestBody);
        HttpResponse response = new HttpResponse();
        
        try{
            //Sending payload
            response = http.send(httpReq);
           
            if(response.getStatusCode() == 200){
                //Fetch message information
                MessageDetails msgInfo = (MessageDetails) JSON.deserialize(response.getBody(), MessageDetails.class);
                responseMsg = msgInfo.ts;
            }else{
                throw new CustomException(response.getBody());
            }
        }catch(Exception e){
            throw new CustomException(e.getMessage());
        }
        return responseMsg;
    }
    
    /*
    *********************************************************
    @Method Name    : deleteMessage
    @author         : Soham Datta  
    @description    : Method to post a Slack message
    @param          : timeStamp, channelId
    @return         : String
    *********************************************************
	*/

    @AuraEnabled (cacheable=true)
    public static String deleteMessage(String timeStamp, String channelId){
        
        String responseMsg = '';
        String endPoint = 'callout:Slack/chat.delete';
        String requestBody = '{"ts":"' + timeStamp + '", "channel":"' + channelId + '"}';
        
        Http http = new Http();
        //Preparing request for integration
        HttpRequest httpReq = prepareRequest(endPoint, ConstantClass.METHOD_POST, requestBody);
        HttpResponse response = new HttpResponse();
        
        try{
            //Sending payload
            response = http.send(httpReq);
           
            if(response.getStatusCode() == 200){
                //Fetch incident information
                MessageDetails msgInfo = (MessageDetails) JSON.deserialize(response.getBody(), MessageDetails.class);
                responseMsg = 'Your message has been deleted successfully!';
            }else{
                throw new CustomException(response.getBody());
            }
        }catch(Exception e){
            throw new CustomException(e.getMessage());
        }
        return responseMsg;
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