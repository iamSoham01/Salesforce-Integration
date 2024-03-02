/*
************************************************************************
Class Name         : OpenCageMock
Created Date       : Feb 6, 2024
@description       : Mock class for OpenCage Callout
@author            : Soham Datta

Modification Log   :
Ver   Date         Author                               Modification
1.0   06-02-2024   Soham Datta                         Initial Version
*************************************************************************
*/

@isTest
public class OpenCageMock implements HttpCalloutMock {

    /*
    *********************************************************
    @Method Name    : respond
    @author         : Soham Datta  
    @description    : Preparing mock response for OpenCage
    @param          :
    *********************************************************
    */

    public HttpResponse respond(HttpRequest req) {
        HttpResponse res = new HttpResponse();
        
        res.setHeader(ConstantClass.CONTENT_TYPE, ConstantClass.CONTENT_TYPE_VALUE);        
        String body = '';
        Integer statusCode = 200;
        String encodedCoordinate = EncodingUtil.urlDecode('22.5726,88.3639', 'UTF-8');
        String encodedAddress = EncodingUtil.urlDecode('ChatterjeeLane,Bowbazar,Kolkata-700073,WestBengal,India', 'UTF-8');

        // Determine the type of request and provide the corresponding mock response.
        if (req.getEndpoint().contains(encodedCoordinate) || req.getEndpoint().contains(encodedAddress)){
            body = openCageResponse();
        }else {
            statusCode = 500;
            body = 'Internal Server Error';
        }
        
        // Deserialize the response body and set it in the HttpResponse.
        Map<String, Object> jsonMap = (Map<String, Object>) JSON.deserializeUntyped(body);
        String serializedJson = JSON.serialize(jsonMap);
        res.setBody(serializedJson);
        res.setStatusCode(statusCode);
        
        return res;
    }

    /*
    *********************************************************
    @Method Name    : openCageResponse
    @author         : Soham Datta  
    @description    : Open cage response body
    @param          :
    *********************************************************
    */

    private String openCageResponse() {
        
        String body = '{'+
            '  \"documentation\": \"https://opencagedata.com/api\",'+
            '  \"results\": ['+
            '    {'+
            '      \"formatted\": \"Chatterjee Lane, Bowbazar, Kolkata - 700073, West Bengal, India\",'+
            '      \"geometry\": {'+
            '        \"lat\": 22.5728603,'+
            '        \"lng\": 88.3640167'+
            '      }'+
            '    }'+
            '  ],'+
            '  \"status\": {'+
            '    \"code\": 200,'+
            '    \"message\": \"OK\"'+
            '  },'+
            '  \"total_results\": 1'+
            '}';
        
        return body;
    }
    
}