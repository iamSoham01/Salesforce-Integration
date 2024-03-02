/*
************************************************************************
Class Name         : GoogleUtilMock
Created Date       : Feb 12, 2024
@description       : Mock class for Google Callout
@author            : Soham Datta

Modification Log   :

Ver   Date         Author                               Modification
1.0   12-02-2024   Soham Datta                         Initial Version
*************************************************************************
*/

@isTest
public class GoogleUtilMock implements HttpCalloutMock {
    
    /*
    *********************************************************
    @Method Name    : respond
    @author         : Soham Datta  
    @description    : Preparing mock response for Google
    @param          :
    *********************************************************
    */

    public HttpResponse respond(HttpRequest req) {
        HttpResponse res = new HttpResponse();
        
        res.setHeader(ConstantClass.CONTENT_TYPE, ConstantClass.CONTENT_TYPE_VALUE);        
        String body = '';
       
        // Determine the type of request and provide the corresponding mock response.
        if (req.getEndpoint().contains('calendar')){
            body = createMeetingResponse();
        }
        
        // Set serialized body in the HttpResponse.
        res.setBody(body);
        res.setStatusCode(200);
        
        return res;
    }

    /*
    *********************************************************
    @Method Name    : createMeetingResponse
    @author         : Soham Datta  
    @description    : Google meeting response
    @param          :
    *********************************************************
    */

    private String createMeetingResponse() {
        
        String body = '{'+
            '    "kind": "calendar#event",'+
            '    "status": "confirmed",'+
            '    "htmlLink": "https://www.google.com/calendar/event?eid=M3NycHYxZjhibmU2ZW1nbzh2NWc0cXJlYzQgc29oYW1kYXR0YTAxQG0",'+
            '    "created": "2024-02-12T07:26:12.000Z",'+
            '    "updated": "2024-02-12T07:26:12.511Z",'+
            '    "summary": "Test Subject"'+
            '}';
        
        return body;
    }

}