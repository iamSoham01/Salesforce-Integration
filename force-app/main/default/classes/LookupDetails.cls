/*
*********************************************************
Apex Class Name    : UserDetails
Created Date       : Feb 25, 2024
@description       : Wrapper class to deserialize Servicenow User Details
@author            : Soham Datta

Modification Log:

Ver   Date         Author                               Modification
1.0   25-02-2024   Soham Datta                        Initial Version
*********************************************************
*/


public class LookupDetails {
    
    public List<Result> result;
    public class Result {
        public String active;
        public String phone;
        public String name;
        public String employee_number;
        public String user_name;
        public String sys_id;
        public String internal_integration_user;
        public String first_name;
        public String email;
    }
  
}