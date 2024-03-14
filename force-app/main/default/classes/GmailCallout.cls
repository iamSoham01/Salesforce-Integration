/*
************************************************************************
Class Name         : GmailCallout
Created Date       : Feb 10, 2024
@description       : This class is used to perform callout to Gmail
@author            : Soham Datta

Modification Log   :
Ver   Date         Author                               Modification
1.0   11-03-2024   Soham Datta                         Initial Version
*************************************************************************
*/

public class GmailCallout {

    /*
    *********************************************************
    @Method Name    : sendEmail
    @author         : Soham Datta  
    @description    : Method to send email
    @param          : mapAttributes
    @return         : Map<String, String>
    *********************************************************
    */
    
    public static Map<String, String> sendEmail(Map<String, Object> mapAttributes){
        
        Map<String, String> responseMap = new Map<String, String>();
        
        String receiverEmail = (String)mapAttributes.get('receiverEmail');
        String emailSubject = (String)mapAttributes.get('emailSubject');
        String emailBody = (String)mapAttributes.get('emailBody');
        String filesData = (String)JSON.serialize(mapAttributes.get('filesData'));
        List<FileReaderWrapper> files = (List<FileReaderWrapper>) JSON.deserialize(filesData, List<FileReaderWrapper>.class);
        
        // Set up Gmail endpoint
        String endpoint = 'callout:Gmail/upload/gmail/v1/users/me/messages/send';

        // Construct multipart request body
        String requestBody = 'Content-Type: multipart/related; boundary=foo_bar_baz\r\n'
                            + 'To: '+ receiverEmail +'\r\n'
                            + 'Subject: '+ emailSubject +'\r\n'
                            + '\r\n'
                            + '--foo_bar_baz\r\n'
                            +  emailBody + '\r\n'
                            + '\r\n';
        
        // Check attachemnt uploaded
        if(files != null && files.size()>0) {

            requestBody += '--foo_bar_baz\r\n';

            for(FileReaderWrapper file : files) {
                requestBody += 'Content-Type: '+ file.fileType +'\r\n'
                            + 'Content-Transfer-Encoding: base64\r\n'
                            + 'MIME-Version: 1.0\r\n'
                            + 'Content-Disposition: attachment; filename="' + file.fileName +'"\r\n'
                            + '\r\n'
                            +  file.fileContent + '\r\n'
                            + '\r\n'
                            + '--foo_bar_baz\r\n';
            }
            requestBody = requestBody.removeEnd('\r\n');

        }
                
        // Create and send HTTP request
        Http http = new Http();
        HttpRequest httpReq   = GoogleUtil.prepareRequest(endPoint, ConstantClass.METHOD_POST, requestBody);
        HttpResponse response = new HttpResponse();
        
        try{
            response = http.send(httpReq);

            // Parse response and extract ID
            if( response.getStatusCode() == 200){
                Map<String, Object> jsonMap = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
                for (String key : jsonMap.keySet()) {
                    if (key != 'labelIds') {
                        responseMap.put(key, (String) jsonMap.get(key));
                    }
                }
            }else{
                throw new CustomException(response.getBody());
            }
            
        }catch(Exception e){
            throw new CustomException(e.getMessage());
        }

        return responseMap;
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