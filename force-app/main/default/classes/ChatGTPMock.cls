/*
************************************************************************
Class Name         : ChatGTPMock
Created Date       : Feb 6, 2024
@description       : Mock class for ChatGTP Callout
@author            : Soham Datta

Modification Log   :
Ver   Date         Author                               Modification
1.0   04-02-2024   Soham Datta                         Initial Version
*************************************************************************
*/

@isTest
public class ChatGTPMock implements HttpCalloutMock {
    
    /*
    *********************************************************
    @Method Name    : setupData
    @author         : Soham Datta  
    @description    : Preparing mock response for ChatGTP
    @param          :
    *********************************************************
    */

    public HttpResponse respond(HttpRequest req) {
        HttpResponse res = new HttpResponse();
        res.setHeader(ConstantClass.CONTENT_TYPE, ConstantClass.CONTENT_TYPE_VALUE);        
        String body = chatGTPResponse();
        // Deserialize the response body and set it in the HttpResponse.
        Map<String, Object> jsonMap = (Map<String, Object>) JSON.deserializeUntyped(body);
        String serializedJson = JSON.serialize(jsonMap);
        res.setBody(serializedJson);
        res.setStatusCode(200);       
        return res;
    }

    /*
    *********************************************************
    @Method Name    : setupData
    @author         : Soham Datta  
    @description    : Test setup data
    @param          :
    *********************************************************
    */

    private String chatGTPResponse() {
        
        String body = '{'+
		'  "id": "chatcmpl-8px5AgcIqEmQbPgB2fC7Q9YbXNFge",'+
		'  "object": "chat.completion",'+
		'  "created": 1707392532,'+
		'  "model": "gpt-3.5-turbo-0613",'+
		'  "choices": ['+
		'    {'+
		'      "index": 0,'+
		'      "message": {'+
		'        "role": "assistant",'+
		'        "content": "MS Dhoni, also known as Mahendra Singh Dhoni, is a former Indian international cricketer and captain of the Indian national cricket team."'+
		'      },'+
		'      "logprobs": null,'+
		'      "finish_reason": "stop"'+
		'    }'+
		'  ]'+
		'}';
        
        return body;
    }

}