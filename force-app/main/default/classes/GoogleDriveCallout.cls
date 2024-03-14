/*
*********************************************************
Apex Class Name    : GoogleDriveCallout
Created Date       : March 13, 2024
@description       : Utility class for google drive integration
@author            : Soham Datta

Modification Log:

Ver   Date         Author                               Modification
1.0   13-03-2024   Soham Datta                      	Initial Version
*********************************************************
*/

public class GoogleDriveCallout {
    
    /*
    *********************************************************
    @Method Name    : uploadFiles
    @author         : Soham Datta  
    @description    : Method to upload files to google drive
    @param          : mapAttributes
    @return         : String
    *********************************************************
	*/

    public static String uploadFiles(Map<String, Object> mapAttributes) {

        String uploadedFileId = '';
        String fileName = (String) mapAttributes.get('fileName');
        String fileContent = (String) mapAttributes.get('fileContent');
        String fileType = (String) mapAttributes.get('fileType');

        // Set up Google Drive API endpoint
        String endpoint = 'callout:GoogleDrive/upload/drive/v3/files?uploadType=multipart';
        
        // Set up file metadata
        String fileMetadata = '{"name":"' + fileName + '"}';
        
        // Construct multipart request body
        String requestBody = '--foo_bar_baz\r\n'
            + 'Content-Type: application/json; charset=UTF-8'
            + '\r\nContent-Disposition: form-data; name="metadata"\r\n\r\n'
            + fileMetadata + '\r\n'
            + '\r\n--foo_bar_baz\r\n'
            + 'Content-Disposition: form-data; name="data"\r\n'
            + 'Content-Transfer-Encoding: base64\r\n'
            + 'Content-Type: ' + fileType + '\r\n\r\n'
            + fileContent
            + '\r\n\r\n--foo_bar_baz--';

        // Create and send HTTP request
        Http http = new Http();
        HttpRequest httpReq   = GoogleUtil.prepareRequest(endPoint, ConstantClass.METHOD_POST, requestBody);
        HttpResponse response = new HttpResponse();

        try {
            response = http.send(httpReq);

            // Parse response and extract file ID
            if (response.getStatusCode() == 200) {
                Map<String, Object> jsonResponse = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
                uploadedFileId = (String) jsonResponse.get('id');
            } else {
                throw new CustomException(response.getBody());
            }

        } catch (Exception e) {
            throw new CustomException(e.getMessage());
        }

        return uploadedFileId;
    }

    /*
    *********************************************************
    @Method Name    : deleteFiles
    @author         : Soham Datta  
    @description    : Method to delete a file
    @param          : fileId
    @return         : String
    *********************************************************
	*/

    public static String deleteFiles(String fileId){
        
        String responseMsg = '';
        String endPoint = 'callout:GoogleDrive/drive/v3/files/' + fileId;
        
        Http http = new Http();
        //Preparing request for integration
        HttpRequest httpReq = GoogleUtil.prepareRequest(endPoint, ConstantClass.METHOD_DELETE, '');
        HttpResponse response = new HttpResponse();
        
        try{
            //Sending payload
            response = http.send(httpReq);
           
            if(response.getStatusCode() == 204){
                responseMsg = 'Your file has been deleted successfully!';
            }else{
                throw new CustomException(response.getBody());
            }
        }catch(Exception e){
            throw new CustomException(e.getMessage());
        }
        return responseMsg;
    }

    /*
    ************************************************************************
    Class Name         : FileReaderWrapper
    Created Date       : March 13, 2024
    @description       : This class is used to deserialize files
    @author            : Soham Datta

    Modification Log   :
    Ver   Date         Author                               Modification
    1.0   13-03-2024   Soham Datta                         Initial Version
    *************************************************************************
    */

    public class FileReaderWrapper {
        public String fileName;
        public String fileContent;
        public String fileType;
    }

}