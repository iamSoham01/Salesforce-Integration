/*
************************************************************************
Class Name         : CreateUpdateMetadataUtils
Created Date       : Feb 10, 2024
@description       : This class is used to save callout token details into metadata
@author            : Soham Datta

Modification Log   :
Ver   Date         Author                               Modification
1.0   10-02-2024   Soham Datta                         Initial Version
*************************************************************************
*/

public class CreateUpdateMetadataUtils implements Metadata.DeployCallback {
    
    public void handleResult(Metadata.DeployResult result, Metadata.DeployCallbackContext context) {
        if (result.status == Metadata.DeployStatus.Succeeded) {
            System.debug(' success : 😍 '+ result);
        } else {
            System.debug(' fail : 🥵 '+ result);
        }
    }
    
    /*
    *********************************************************
    @Method Name    : createUpdateMetadata
    @author         : Soham Datta  
    @description    : Save token details
    @param          :
    *********************************************************
    */
    
    public static void createUpdateMetadata(String fullName, String label, Map<String, Object> fieldWithValuesMap){
        
        Metadata.CustomMetadata customMetadata =  new Metadata.CustomMetadata();
        customMetadata.fullName = fullName; 
        customMetadata.label = label;
        
        for(String key : fieldWithValuesMap.keySet()){
            Metadata.CustomMetadataValue customField = new Metadata.CustomMetadataValue();
            customField.field = key;
            customField.value = fieldWithValuesMap.get(key); 
            customMetadata.values.add(customField);
        }
                
        Metadata.DeployContainer mdContainer = new Metadata.DeployContainer();
        mdContainer.addMetadata(customMetadata);
        CreateUpdateMetadataUtils callback = new CreateUpdateMetadataUtils();
        Id jobId;
        
        if(!Test.isRunningTest()) {
            jobId = Metadata.Operations.enqueueDeployment(mdContainer, callback);
        }else {
            jobId  = 'a0I0o00001MbaBJ'; 
        }
    }
    
}