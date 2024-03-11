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
    @description    : Send email using gmail api
    @param          :
    *********************************************************
    */
    
    public static Map<String, String> sendEmail(Map<String, Object> mapAttributes){
        
        Map<String, String> responseMap = new Map<String, String>();
        String receiverEmail = (String)mapAttributes.get('receiverEmail');
        String emailSubject = (String)mapAttributes.get('emailSubject');
        String emailBody = (String)mapAttributes.get('emailBody');
        String fileContents = (String)mapAttributes.get('fileContents');
        String fileName = (String)mapAttributes.get('fileName');

        String endpoint = 'callout:Gmail/upload/gmail/v1/users/me/messages/send';

        String requestBody = 'Content-Type: multipart/related; boundary=foo_bar_baz\r\n'
                            + 'To: '+ receiverEmail +'\r\n'
                            + 'Subject: '+ emailSubject +'\r\n'
                            + '\r\n'
                            + '--foo_bar_baz\r\n'
                            +  emailBody + '\r\n'
                            + '\r\n';

        if(String.isNotBlank(fileName)) {
            requestBody += '--foo_bar_baz\r\n'
                            + 'Content-Type: application/png\r\n'
                            + 'Content-Transfer-Encoding: base64\r\n'
                            + 'MIME-Version: 1.0\r\n'
                            + 'Content-Disposition: attachment; filename="' + fileName +'"\r\n'
                            + '\r\n'
                            +  fileContents + '\r\n'
                            + '\r\n'
                            + '--foo_bar_baz--\r\n';
        }
                
        Http http = new Http();
        HttpRequest httpReq   = GoogleUtil.prepareRequest(endPoint, ConstantClass.METHOD_POST, requestBody);
        HttpResponse response = new HttpResponse();
        
        try{
            response = http.send(httpReq);
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

}