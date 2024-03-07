/*
*********************************************************
Apex Class Name    : ServicenowUtil
Created Date       : Feb 25, 2024
@description       : Utility class for servicenow integration
@author            : Soham Datta

Modification Log:

Ver   Date         Author                               Modification
1.0   25-02-2024   Soham Datta                      	Initial Version
*********************************************************
*/

public with sharing class ServicenowUtil {
    
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
    public static Map<String, String> getCallerDetails(){
        
        //Preparing endpoint
        String endPoint = 'callout:Servicenow/api/now/table/sys_user?sysparm_limit=10';
        Map<String, String> mapCallerInfo = new Map<String, String>();
        
        Http http = new Http();
        //Preparing request for integration
        HttpRequest httpReq = prepareRequest(endPoint, ConstantClass.METHOD_GET, '');
        HttpResponse response = new HttpResponse();
        
        try{
            //Sending payload
            response = http.send(httpReq);
            
            if(response.getStatusCode() == 200){
                //Getting success response
                String responseBody = response.getBody();
                // Deserialize the response
                Map<String, Object> parsedJson = (Map<String, Object>) JSON.deserializeUntyped(responseBody);
                // Extract the result array
                List<Object> results = (List<Object>) parsedJson.get('result');
                
                // Iterate over each record in the result array
                for (Object result : results) {
                    Map<String, Object> record = (Map<String, Object>) result;
                    
                    // Extract first_name and last_name
                    String firstName = (String) record.get('first_name');
                    String lastName = (String) record.get('last_name');
                    
                    // Combine first_name and last_name to create the key
                    String fullName = firstName + ' ' + lastName;
                    
                    // Extract sys_id
                    String sysId = (String) record.get('sys_id');
                    
                    // Add to the mapCallerInfo
                    mapCallerInfo.put(fullName, sysId);
                }
                
            }else{
                throw new CustomException(response.getBody());
            }
        }catch(Exception e){
            throw new CustomException(e.getMessage());
        }

        return mapCallerInfo;
    }
    
    /*
    *********************************************************
    @Method Name    : createIncident
    @author         : Soham Datta  
    @description    : Method to create incidents in Servicenow
    @param          : callerId, requestBody
    @return         : String
    *********************************************************
	*/

    @AuraEnabled (cacheable=true)
    public static String createIncident(String callerId, String description){
        
        String requestBody = buildIncidentRequestBody(callerId, description);
        
        String incidentNumber = '';        
        String endPoint = 'callout:Servicenow/api/now/table/incident';
        
        Http http = new Http();
        //Preparing request for integration
        HttpRequest httpReq = prepareRequest(endPoint, ConstantClass.METHOD_POST, requestBody);
        HttpResponse response = new HttpResponse();
        
        try{
            //Sending payload
            response = http.send(httpReq);
           
            if(response.getStatusCode() == 201){
                //Getting success response
                String responseBody = response.getBody();
                //Fetch incident information
                Map<String, Object> parsedJson = (Map<String, Object>) JSON.deserializeUntyped(responseBody);
                Map<String, Object> result = (Map<String, Object>) parsedJson.get('result');
                incidentNumber = (String) result.get('task_effective_number');
            }else{
                throw new CustomException(response.getBody());
            }
        }catch(Exception e){
            throw new CustomException(e.getMessage());
        }
        return incidentNumber;
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
    
    /*
    *********************************************************
    @Method Name    : buildIncidentRequestBody
    @author         : Soham Datta
    @description    : Build request body to create incident in servicenow
    @param          : callerId, assigmentGrpId
    @return         : String
    ********************************************************
    */
    
    private static String buildIncidentRequestBody(String callerId, String description) {
        
        //Mapping between case record and servicenow fields
        Map<String, Object> requestBodyMap = new Map<String, Object>{
            'caller_id' => callerId,
                'short_description' => description
                };
                    
                    return JSON.serialize(requestBodyMap);
    }
    
}