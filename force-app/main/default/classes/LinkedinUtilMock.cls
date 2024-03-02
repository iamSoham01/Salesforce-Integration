/*
************************************************************************
Class Name         : LinkedinUtilMock
Created Date       : Feb 15, 2024
@description       : Mock class for Linkedin Callout
@author            : Soham Datta

Modification Log   :

Ver   Date         Author                               Modification
1.0   15-02-2024   Soham Datta                         Initial Version
*************************************************************************
*/

@isTest
public class LinkedinUtilMock implements HttpCalloutMock {
    
    /*
    *********************************************************
    @Method Name    : respond
    @author         : Soham Datta  
    @description    : Preparing mock response for Linkedin
    @param          :
    *********************************************************
    */

    public HttpResponse respond(HttpRequest req) {
        HttpResponse res = new HttpResponse();
        
        res.setHeader(ConstantClass.CONTENT_TYPE, ConstantClass.CONTENT_TYPE_VALUE);
        Integer statusCode = 200;        
        String body = '';
       
        // Determine the type of request and provide the corresponding mock response.
        if (req.getEndpoint().contains('v2/me')){
            body = getProfileResponse();
        }else if (req.getEndpoint().contains('rest/posts')){
            statusCode = 201;
            body = LinkedinUtil.SUCCESS_RESPONSE;
        }
        
        // Set serialized body in the HttpResponse.
        res.setBody(body);
        res.setStatusCode(statusCode);
        
        return res;
    }

    /*
    *********************************************************
    @Method Name    : getProfileResponse
    @author         : Soham Datta  
    @description    : Linkedin Profile response
    @param          :
    *********************************************************
    */

    private String getProfileResponse() {
        
        String body = '{'+
            '  "localizedLastName": "User",'+
            '  "vanityName": "test-user",'+
            '  "localizedHeadline": "Test User",'+
            '  "id": "qiYJA5QUOL",'+
            '  "localizedFirstName": "Test"'+
            '}';
        
        return body;
    }
    
}