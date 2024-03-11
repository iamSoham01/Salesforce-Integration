/*
************************************************************************
Class Name         : ApexWebService
Created Date       : Feb 4, 2024
@description       : This class is used to demnstrate apex rest web servicees
@author            : Soham Datta
Endpoint           : /services/apexrest/namespace/ApexWebService

Modification Log   :
Ver   Date         Author                               Modification
1.0   04-02-2024   Soham Datta                         Initial Version
*************************************************************************
*/

@RestResource(urlMapping='/ApexWebService/*')
global class ApexWebService {

    /*
    *********************************************************
    @Method Name    : getAccountRecords
    @author         : Soham Datta
    @description    : This method return an account record provided by Id
    @param          :
    @return         : List<Account>
    *********************************************************
	    */

    @httpGet
    global static List<Account> getAccountRecords() {

        RestRequest req = RestContext.request;
        String reqURI = req.requestURI;
        String accountId = reqURI.substringAfterLast('/');

        return [Select Id, Name, Rating, Industry From Account Where Id = :accountId];

    }

    /*
    *********************************************************
    @Method Name    : createAccountRecord
    @author         : Soham Datta
    @description    : This method creates an account record
    @param          : name, industry, rating
    @return         : String
    *********************************************************
    */

    @httpPost
    global static Id createAccountRecord(String name, String industry, String rating) {

        Account accountRecordToBeCreated = new Account(Name = name, Industry = industry, Rating = rating);        
        insert accountRecordToBeCreated;
        return accountRecordToBeCreated.Id;

    }

    /*
    *********************************************************
    @Method Name    : deleteAccountRecord
    @author         : Soham Datta
    @description    : This method deletes an account record
    @param          : 
    @return         : String
    *********************************************************
    */

    @httpDelete
    global static String deleteAccountRecord() {

        RestRequest req = RestContext.request;
        String reqURI = req.requestURI;
        String accountId = reqURI.substringAfterLast('/');

        Delete [Select Id From Account Where Id = :accountId];
        return accountId + ' Id has been deleted successfully';

    }

    /*
    *********************************************************
    @Method Name    : updateAccountRecord
    @author         : Soham Datta
    @description    : This method update an account record
    @param          : 
    @return         : String
    *********************************************************
    */

    @httpPatch
    global static String updateAccountRecord(String rating) {

        RestRequest req = RestContext.request;
        String reqURI = req.requestURI;
        String accountId = reqURI.substringAfterLast('/');

        Account accountRecordToBeUpdated = [Select Id, Name, Rating From Account Where Id = :accountId Limit 1];
        String message;

        if(accountRecordToBeUpdated != null) {
            
            accountRecordToBeUpdated.Rating = rating;
            update accountRecordToBeUpdated;
            message = accountRecordToBeUpdated.Id + ' Record has been updated successfully';

        }else {
            message = 'Sorry, record not found.';
        }
        
        return message;

    }
    
}
