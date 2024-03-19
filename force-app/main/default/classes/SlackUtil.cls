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

public class SlackUtil {

    /*
    *********************************************************
    @Method Name    : getCallerDetails
    @author         : Soham Datta  
    @description    : Method to get caller details from Servicenow
    @param          : 
    @return         : Map<String, String>
    *********************************************************
	*/

    @AuraEnabled(cacheable=true)
    public static Map<String, String> getAllChannels(){

        Map<String, String> mapAllChannels = new Map<String, String>();
        
        //Preparing endpoint
        String endPoint = 'callout:Slack/conversations.list';
        
        Http http = new Http();
        //Preparing request for integration
        HttpRequest httpReq = CalloutUtility.prepareRequest(endPoint, ConstantClass.METHOD_GET, '');
        HttpResponse response = new HttpResponse();
        
        try{
            //Sending payload
            response = http.send(httpReq);
            //Getting success response
            if(response.getStatusCode() == 200){
                String responseBody = response.getBody();
                //Parsing JSON
                Map<String, Object> parsedJson = (Map<String, Object>) JSON.deserializeUntyped(responseBody);
                
                List<Object> channels = (List<Object>) parsedJson.get('channels');
                for(Object channelObj : channels) {
                    Map<String, Object> channelData = (Map<String, Object>) channelObj;
                    Boolean isMember = (Boolean) channelData.get('is_member');
                    if(isMember != null && isMember) {
                        String name = (String) channelData.get('name');
                        String id = (String) channelData.get('id');
                        mapAllChannels.put(name, id);
                    }
                }
            }else{
                throw new CustomException(response.getBody());
            }
        }catch(Exception e){
            throw new CustomException(e.getMessage());
        }

        return mapAllChannels;
    }
    
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
        HttpRequest httpReq = CalloutUtility.prepareRequest(endPoint, ConstantClass.METHOD_POST, requestBody);
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
        HttpRequest httpReq = CalloutUtility.prepareRequest(endPoint, ConstantClass.METHOD_POST, requestBody);
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

}