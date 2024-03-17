/*
*********************************************************
Apex Class Name    : CalloutUtility
Created Date       : Mar 15, 2024
@description       : Utility class for integration callout
@author            : Soham Datta

Modification Log:

Ver   Date         Author                               Modification
1.0   29-02-2024   Soham Datta                      	Initial Version
*********************************************************
*/

public class CalloutUtility {
    
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