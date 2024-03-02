/*
*********************************************************
Apex Class Name    : IncidentDetails
Created Date       : Feb 25, 2024
@description       : Wrapper class to deserialize Servicenow Incident Details
@author            : Soham Datta

Modification Log:

Ver   Date         Author                               Modification
1.0   25-02-2024   Soham Datta                        Initial Version
*********************************************************
*/

public class IncidentDetails {
    
    public Result result;

    public class Result {
        public String made_sla;
        public String sys_updated_on;
        public String task_effective_number;
        public String sys_created_on;
        public String sys_created_by;
        public String short_description;
        public String sys_id;
  }
    
}