/*
************************************************************************
Class Name         : OpenCageUtil
Created Date       : Feb 5, 2024
@description       : This class is used to integrate Salesforce with OpenCageData
@author            : Soham Datta

Modification Log   :
Ver   Date         Author                               Modification
1.0   04-02-2024   Soham Datta                         Initial Version
*************************************************************************
*/

public class ChatGTPUtil {
    
    @AuraEnabled (cacheable=true)
    public static String getResponseMsg(String message){
        
        String responseMsg = '';
        
        //ChatGTP Endpoint
        final String endPoint = 'callout:ChatGTP/v1/chat/completions';
        //Request body
        String requestBody = '{"model": "gpt-3.5-turbo","messages": [{"role": "user", "content": "' + message + '"}],"temperature": 0.8}';
        
        Http http = new Http();
        HttpRequest req = new HttpRequest();
        HttpResponse res = new HttpResponse();
        
        //Preparing request
        req.setEndpoint(endPoint);
        req.setMethod(ConstantClass.METHOD_POST);
        req.setBody(requestBody);
        req.setTimeout(120000);
        
        try {
            //Callout to ChatGTP
            res = http.send(req);
            if(res.getStatusCode() == 200){
                
                ChatGTPResponseWrapper data = ChatGTPResponseWrapper.parse(res.getBody());
                responseMsg = data.choices[0].message.content;
                
            }else {
                throw new CustomException(res.getBody()); 
            }            
        } catch (Exception e) {
            throw new CustomException(e.getMessage());
        }
        
        return responseMsg;
        
    }
}