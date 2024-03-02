/*
*********************************************************
Test Class Name    : TestDataSetup
Created Date       : Feb 6, 2024
@description       : Testsetup Utility Class
@author            : Soham Datta

Modification Log:

Ver   Date         Author                               Modification
1.0   30-01-2024   Soham Datta                        Initial Version
*********************************************************
*/

public class TestDataSetup {

    /*
    *********************************************************
    @Method Name    : createProfile
    @author         : Soham Datta  
    @description    : Create a profile for test data setup
    @param          : profileName
    @return         : Profile
    *********************************************************
  */

    public static Profile createProfile(String profileName){
        
        return [SELECT Id, Name FROM Profile WHERE Name =: profileName Limit 1];
        
    }

    /*
    *********************************************************
    @Method Name    : createUser
    @author         : Soham Datta  
    @description    : Create an user for test data setup
    @param          : pID, abNumber
    @return         : User
    *********************************************************
  */

    public static User createUser(String pID, String uniqueUserName){
        
        User testUser = new User(
            Alias = 'USERT', 
            Email ='testuser@testorg.com',
            EmailEncodingKey ='UTF-8', 
            LastName ='Test', 
            LanguageLocaleKey ='en_US',
            LocaleSidKey ='en_US', 
            ProfileId = pID,
            TimeZoneSidKey ='America/Los_Angeles',
            UserName = uniqueUserName
            );
        
        insert testUser;
        return testUser;
        
    }
    
}