/*
************************************************************************
Class Name         : GoogleUtil
Created Date       : Feb 10, 2024
@description       : This class is used to perform callout to Google
@author            : Soham Datta

Modification Log   :
Ver   Date         Author                               Modification
1.0   10-02-2024   Soham Datta                         Initial Version
*************************************************************************
*/

public class GoogleUtil {
    
    /*
    *********************************************************
    @Method Name    : getGoogleConfig
    @author         : Soham Datta  
    @description    : Fetch Google_Config__mdt records
    @param          :
    *********************************************************
    */

    /*
    public static Google_Config__mdt getGoogleConfig(){
        String query = SOQLUtil.buildSOQLQuery('Google_Config__mdt', System.Label.GoogleToken);
        List<Google_Config__mdt> g_CredList = Database.query(query);
        return g_CredList.isEmpty() ? null : g_CredList[0];
    }
	*/
    
    /*
    *********************************************************
    @Method Name    : getAuthorizationCode
    @author         : Soham Datta  
    @description    : This method is used to generate authorization code 
    @param          :
    *********************************************************
    */
    
    /*
    public PageReference getAuthorizationCode(){
        
        Google_Config__mdt g_Cred = getGoogleConfig();
        if(g_Cred == null){
            return null;
        }
        
        String baseUrl = URL.getOrgDomainURL().toExternalForm() + '/apex/' + g_Cred.PageName__c;
        
        String authUrl = g_Cred.auth_url__c 
            + '?scope=' + g_Cred.scope__c
            + '&prompt=consent'
            + '&access_type=offline'
            + '&include_granted_scopes=true'
            + '&response_type=code' 
            + '&state'+ Crypto.getRandomInteger()
            + '&redirect_uri='+ baseUrl
            + '&client_id='+ g_Cred.client_id__c;
        
        PageReference pageRef = new PageReference(authUrl);
        pageRef.setRedirect(true);
        return pageRef;
        
    }
	*/
    
    /*
    *********************************************************
    @Method Name    : checkTokenValidity
    @author         : Soham Datta  
    @description    : Check validity of access token
    @param          : token
    *********************************************************
    */
    /*
    public static Boolean checkTokenValidity(Google_Config__mdt token){
        Boolean isValid = true;
        if(token.expires_in_time__c < System.now()){
            isValid = false;
        }
        return isValid;
    }
	*/
    
    /*
    *********************************************************
    @Method Name    : getAccessToken
    @author         : Soham Datta  
    @description    : Get access token for Google api
    @param          :
    *********************************************************
    */
    
    /*
    public static void getAccessToken(){
        
        Google_Config__mdt g_Cred = getGoogleConfig();
        
        if(g_Cred == null){
            return;
        }
        
        String endPoint = g_Cred.token_url__c;
        String baseUrl = URL.getOrgDomainURL().toExternalForm() + '/apex/' + g_Cred.PageName__c;
        String code    = ApexPages.currentPage().getParameters().get('code');
        
        String requestBody = 'code='+ code
            + '&client_id='+ g_Cred.client_id__c
            + '&client_secret='+ g_Cred.client_secret__c
            + '&redirect_uri='+ baseUrl 
            + '&grant_type=authorization_code';
        
        Http http = new Http();
        HttpRequest httpReq   = prepareRequest(endPoint, '', ConstantClass.METHOD_POST, requestBody, 'application/x-www-form-urlencoded');
        HttpResponse response = new HttpResponse();
        
        try{
            response = http.send(httpReq);
            
            if( response.getStatusCode() == 200){
                String body = response.getBody();
                Map<String, Object> tokenMap = new Map<String, Object>();
                
                GoogleToken token = (GoogleToken)System.JSON.deserialize(body, GoogleToken.class);
                tokenMap.put('access_token__c', token.access_token);
                tokenMap.put('refresh_token__c', token.refresh_token);
                tokenMap.put('expires_in__c', Decimal.valueOf(token.expires_in));
                tokenMap.put('expires_in_time__c', System.now().addSeconds(token.expires_in));
                
                String fullName = 'Google_Config.'+System.Label.GoogleToken;
                CreateUpdateMetadataUtils.createUpdateMetadata(fullName, System.Label.GoogleToken, tokenMap);
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM, 'Successfully Authenticated! You can close the window now.'));
                
            }else{
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR, response.getBody()));
                throw new CustomException(response.getBody()); 
            }
        }catch(Exception e){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR, e.getMessage()));
            throw new CustomException(e.getMessage());
        }
    }
    */
    
    /*
    *********************************************************
    @Method Name    : refreshToken
    @author         : Soham Datta  
    @description    : Generate refresh token
    @param          : gConfig
    *********************************************************
    */
    
    /*
    public static Map<String, Object> refreshToken(Google_Config__mdt gConfig){
                
        String endPoint = gConfig.token_url__c;
        String baseUrl = URL.getOrgDomainURL().toExternalForm() + '/apex/' + gConfig.PageName__c;
        
        String requestBody = 'client_id='+ gConfig.client_id__c
            + '&client_secret=' + gConfig.client_secret__c
            + '&refresh_token=' + gConfig.refresh_token__c
            + '&grant_type=refresh_token';
        
        Http http = new Http();
        HttpRequest httpReq   = prepareRequest(endPoint, '', ConstantClass.METHOD_POST, requestBody, 'application/x-www-form-urlencoded');
        HttpResponse response = new HttpResponse();
        
        Map<String, Object> tokenMap = new Map<String, Object>();
        
        try{
            response = http.send(httpReq);
            
            if( response.getStatusCode() == 200){
                
                String responseBody = response.getBody();
                GoogleToken token = (GoogleToken)System.JSON.deserialize(responseBody, GoogleToken.class);
                tokenMap.put('access_token__c', token.access_token);
                tokenMap.put('expires_in__c', Decimal.valueOf(token.expires_in));
                tokenMap.put('expires_in_time__c', System.now().addSeconds(token.expires_in));
                
            }else{
                throw new CustomException(response.getBody());
            }
            
        }catch(Exception e){
            throw new CustomException(e.getMessage());
        } 
        return tokenMap;
    }
	*/
    
    /*
    *********************************************************
    @Method Name    : prepareRequest
    @author         : Soham Datta  
    @description    : Prepare request for callout
    @param          : endPoint, accessToken, method, requestBody, contentType
    *********************************************************
    */
    
    /*
    public static HttpRequest prepareRequest(String endPoint, String accessToken, String method, String requestBody,
                                             String contentType){
                                                 
                                                 HttpRequest httpReq = new HttpRequest();
                                                 httpReq.setMethod(method);
                                                 httpReq.setEndpoint(endPoint);
                                                 httpReq.setHeader(ConstantClass.CONTENT_TYPE, contentType);
                                                 httpReq.setHeader(ConstantClass.ACCEPT, ConstantClass.CONTENT_TYPE_VALUE);
                                                 if(String.isNotBlank(accessToken)){
                                                     httpReq.setHeader(ConstantClass.AUTHORIZATION, ConstantClass.BEARER + ' ' + accessToken);
                                                 }
                                                 if(String.isNotBlank(requestBody)){
                                                     httpReq.setBody(requestBody);
                                                 }
                                                 return httpReq;
                                                 
                                             }
	*/    

    /*
    *********************************************************
    @Method Name    : createCalenderMeeting
    @author         : Soham Datta  
    @description    : Create Google Calender Meeting
    @param          : calendarId, requestBody
    *********************************************************
    */
    
    /*
    @AuraEnabled
    public static String createCalenderMeeting(String calendarId, String requestBody){
        
        Google_Config__mdt g_Cred = getGoogleConfig();
        
        if(g_Cred == null || ( g_Cred != null && String.isBlank(g_Cred.access_token__c) ) ){
            return '';
        }
        
        String evtURL = '';
        String endPoint = g_Cred.Event_Url__c;
        endPoint = endPoint.replace('{calendarId}', calendarId);
        
        String accessToken = g_Cred.access_token__c;
        
        Boolean isValid = checkTokenValidity(g_Cred);
        Map<String, Object> refreshTokenMap = new Map<String, Object>();
        
        if(!isValid){
            refreshTokenMap = refreshToken(g_Cred);
            accessToken     = (String)refreshTokenMap.get('access_token__c');
        }
        
        Http http = new Http();
        HttpRequest httpReq   = prepareRequest(endPoint, accessToken, ConstantClass.METHOD_POST, requestBody, ConstantClass.CONTENT_TYPE_VALUE);
        HttpResponse response = new HttpResponse();
        
        try{
            response = http.send(httpReq);
            if( response.getStatusCode() == 200){
                CalendarEventDetails evtDetails = (CalendarEventDetails) System.JSON.deserialize(response.getBody(), CalendarEventDetails.class);
                evtURL = evtDetails.htmlLink;
            }else{
                throw new CustomException(response.getBody());
            }
            
        }catch(Exception e){
            throw new CustomException(e.getMessage());
        }
        return evtURL; 
    }
	*/

    /*
    *********************************************************
    @Method Name    : createCalenderMeeting
    @author         : Soham Datta  
    @description    : Create Google Calender Meeting
    @param          : mapAttributes
    @return         : String
    *********************************************************
    */

    @AuraEnabled
    public static String createCalenderMeeting(Map<String, Object> mapAttributes){
        return GoogleCalendarCallout.createMeeting(mapAttributes);
    }

    /*
    *********************************************************
    @Method Name    : createCalenderMeeting
    @author         : Soham Datta  
    @description    : Create Google Calender Meeting
    @param          : mapAttributes
    @return         : Map<String, String>
    *********************************************************
    */

    @AuraEnabled
    public static Map<String, String> sendEmail(Map<String, Object> mapAttributes){
        return GmailCallout.sendEmail(mapAttributes);
    }

    /*
    *********************************************************
    @Method Name    : uploadFiles
    @author         : Soham Datta  
    @description    : Upload files to Google Drive
    @param          : mapAttributes
    @return         : String
    *********************************************************
    */

    @AuraEnabled
    public static String uploadFiles(Map<String, Object> mapAttributes){
        return GoogleDriveCallout.uploadFiles(mapAttributes);
    }

    /*
    *********************************************************
    @Method Name    : uploadFiles
    @author         : Soham Datta  
    @description    : Upload files to Google Drive
    @param          : mapAttributes
    @return         : String
    *********************************************************
    */

    @AuraEnabled
    public static String deleteFiles(String fileId){
        return GoogleDriveCallout.deleteFiles(fileId);
    }
   
}