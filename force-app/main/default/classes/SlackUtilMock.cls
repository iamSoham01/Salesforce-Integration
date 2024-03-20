/*
************************************************************************
Class Name         : SlackUtilMock
Created Date       : Feb 28, 2024
@description       : Mock class for Slack Callout
@author            : Soham Datta

Modification Log   :

Ver   Date         Author                               Modification
1.0   28-02-2024   Soham Datta                         Initial Version
*************************************************************************
*/

@isTest
public class SlackUtilMock implements HttpCalloutMock {
    
    /*
    *********************************************************
    @Method Name    : respond
    @author         : Soham Datta  
    @description    : Preparing mock response for Slack
    @param          :
    *********************************************************
    */

    public HttpResponse respond(HttpRequest req) {
        HttpResponse res = new HttpResponse();
        
        res.setHeader(ConstantClass.CONTENT_TYPE, ConstantClass.CONTENT_TYPE_VALUE);        
        String body = '';
       
        // Determine the type of request and provide the corresponding mock response.
        if (req.getEndpoint().contains('conversations.list')){
            body = allChannelResponse();
        }else if (req.getEndpoint().contains('chat.postMessage')){
            body = postMsgResponse();
        }else if (req.getEndpoint().contains('chat.delete')){
            body = deleteMsgResponse();
        }
        
        // Set serialized body in the HttpResponse.
        res.setBody(body);
        res.setStatusCode(200);
        
        return res;
    }
    
    /*
    *********************************************************
    @Method Name    : allChannelResponse
    @author         : Soham Datta  
    @description    : Get all slack channels
    @param          :
    *********************************************************
    */

    private String allChannelResponse() {
        
        String body = '{'+
            '  "ok": true,'+
            '  "channels": ['+
            '    {'+
            '      "id": "C06LD5BSZFZ",'+
            '      "name": "random",'+
            '      "is_private": false,'+
            '      "is_member": true'+
            '    },'+
            '    {'+
            '      "id": "C06M6BQKMQ9",'+
            '      "name": "general",'+
            '      "is_private": false,'+
            '      "is_member": false'+
            '    }'+
            '  ]'+
            '}';
        
        return body;
    }

    /*
    *********************************************************
    @Method Name    : postMsgResponse
    @author         : Soham Datta  
    @description    : Post message response
    @param          :
    *********************************************************
    */

    private String postMsgResponse() {
        
        String body = '{'+
            '  "ok": true,'+
            '  "channel": "C06MGFRERPA",'+
            '  "ts": "1709140932.696539",'+
            '  "message": {'+
            '    "user": "C06MGMQERPA",'+
            '    "ts": "1709140932.696539",'+
            '    "text": "Hello World!"'+
            '  }'+
            '}';
        
        return body;
    }
    
    /*
    *********************************************************
    @Method Name    : deleteMsgResponse
    @author         : Soham Datta  
    @description    : Delete message response
    @param          :
    *********************************************************
    */

    private String deleteMsgResponse() {
        
        String body = '{'+
            '  "ok": true,'+
            '  "channel": "C06MGMQERPA",'+
            '  "ts": "1709140932.696539"'+
            '}';
        
        return body;
    }

}