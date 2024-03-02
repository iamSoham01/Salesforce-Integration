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
    @Method Name    : getLookupRecord
    @author         : Soham Datta  
    @description    : Method to get Lookup Id from Servicenow
    @param          : tableName, fieldName, fieldValue
    @return         : String
    *********************************************************
	*/

    private static String getLookupRecord(String tableName, String fieldName, String fieldValue){
        
        String recordId = '';
        //Preparing endpoint
        String endPoint = 'callout:Servicenow/api/now/table/' + tableName;
        Map<String, String> queryParams = new Map<String, String>{
            'sysparm_limit' => '1',
                fieldName => fieldValue
                };
        endPoint += '?' + getQueryString(queryParams);
        
        Http http = new Http();
        //Preparing request for integration
        HttpRequest httpReq = prepareRequest(endPoint, ConstantClass.METHOD_GET, '');
        HttpResponse response = new HttpResponse();
        
        try{
            //Sending payload
            response = http.send(httpReq);
            
            if(response.getStatusCode() == 200){
                //Getting success response
                String body = response.getBody();
                LookupDetails getRecordDetails = (LookupDetails) System.JSON.deserialize(body, LookupDetails.class);
                if (getRecordDetails != null && !getRecordDetails.result.isEmpty()) {
                    //Store servicenow user Id
                    recordId = getRecordDetails.result[0].sys_id;
                }
                
            }else{
                throw new CustomException(response.getBody());
            }
        }catch(Exception e){
            throw new CustomException(e.getMessage());
        }

        return recordId;
    }
    
    /*
    *********************************************************
    @Method Name    : createIncident
    @author         : Soham Datta  
    @description    : Method to create incidents in Servicenow
    @param          : requestBody
    @return         : String
    *********************************************************
	*/

    @AuraEnabled (cacheable=true)
    public static String createIncident(String description){
        
        String userId = getLookupRecord('sys_user', 'user_name', 'admin');
        String requestBody = buildIncidentRequestBody(userId, description);
        
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
                //Fetch incident information
                IncidentDetails incidentInfo = (IncidentDetails) JSON.deserialize(response.getBody(), IncidentDetails.class);
                incidentNumber = incidentInfo.result.task_effective_number;
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
    @Method Name    : getQueryString
    @author         : Soham Datta  
    @description    : Method to create requestBody from objectMap
    @param          : params
    @return         : String
    *********************************************************
	*/
    private static String getQueryString(Map<String, String> params) {
        
        List<String> keyValuePairs = new List<String>();
        for (String key : params.keySet()) {
            keyValuePairs.add(key + '=' + EncodingUtil.urlEncode(params.get(key), 'UTF-8'));
        }
        return String.join(keyValuePairs, '&');
    
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
    @param          : userId, assigmentGrpId
    @return         : String
    ********************************************************
    */
    
    private static String buildIncidentRequestBody(String userId, String description) {
        
        //Mapping between case record and servicenow fields
        Map<String, Object> requestBodyMap = new Map<String, Object>{
            'caller_id' => userId,
                'short_description' => description
                };
                    
                    return JSON.serialize(requestBodyMap);
    }
    
}