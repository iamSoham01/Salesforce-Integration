/*
************************************************************************
Class Name         : LinkedinUtil
Created Date       : Feb 13, 2024
@description       : This class is used to perform callout to Linkedin
@author            : Soham Datta

Modification Log   :
Ver   Date         Author                               Modification
1.0   13-02-2024   Soham Datta                         Initial Version
*************************************************************************
*/
public class LinkedinUtil {
    
    @TestVisible
    private static String profileId = '';
    public static final String SUCCESS_RESPONSE = 'Your message has been posted successfully!';
    
    /*
    *********************************************************
    @Method Name    : getProfileInformation
    @author         : Soham Datta  
    @description    : Get LinkedIn Profile Information
    @param          : 
    *********************************************************
    */
    
    public static void getProfileInformation(){

        String endPoint = 'callout:Linkedin/v2/me';
        
        Http http = new Http();
        HttpRequest httpReq   = CalloutUtility.prepareRequest(endPoint, ConstantClass.METHOD_GET, '', '');
        HttpResponse response = new HttpResponse();
        
        try{
            response = http.send(httpReq);
            
            if( response.getStatusCode() == 200){
                
                String responseBody = response.getBody();
                LinkedinProfileDetails profileData = (LinkedinProfileDetails)System.JSON.deserialize(responseBody, LinkedinProfileDetails.class);
                profileId = profileData.id;
                
            }else{
                throw new CustomException(response.getBody());
            }
            
        }catch(Exception e){
            throw new CustomException(e.getMessage());
        }
        
    }
    
    /*
    *********************************************************
    @Method Name    : createPost
    @author         : Soham Datta  
    @description    : Create LinkedIn Text Post
    @param          : 
    *********************************************************
    */
    
    @AuraEnabled(cacheable=true)
    public static String createPost(String msg, String linkedinVersion){
        
        
        String responseMsg = '';

        if(String.isBlank(profileId)){
            getProfileInformation();
        }
        
        String endPoint = 'callout:Linkedin/rest/posts';
        String requestBody = '{' +
            '"author": "urn:li:person:' + profileId + '",' +
            '"commentary": "' + msg + '",' +
            '"visibility": "PUBLIC",' +
            '"distribution": {' +
            '"feedDistribution": "MAIN_FEED",' +
            '"targetEntities": [],' +
            '"thirdPartyDistributionChannels": []' +
            '},' +
            '"lifecycleState": "PUBLISHED",' +
            '"isReshareDisabledByAuthor": true' +
            '}';
        
        Http http = new Http();
        HttpRequest httpReq   = CalloutUtility.prepareRequest(endPoint, ConstantClass.METHOD_POST, requestBody, linkedinVersion);
        HttpResponse response = new HttpResponse();
        
        try{
            response = http.send(httpReq);
            
            if( response.getStatusCode() == 201){
                responseMsg = LinkedinUtil.SUCCESS_RESPONSE;
                
            }else{
                throw new CustomException(response.getBody());
            }
            
        }catch(Exception e){
            throw new CustomException(e.getMessage());
        }
        
        return responseMsg;
    }
    
}