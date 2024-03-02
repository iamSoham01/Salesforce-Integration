/*
*********************************************************
Test Class Name    : ServicenowCommunicationMock
Created Date       : Jan 30, 2024
@description       : Mock class for serviceNow integrtion.
@author            : Soham Datta

Modification Log:

Ver   Date         Author                               Modification
1.0   30-01-2024   Soham Datta                      	Initial Version
*********************************************************
*/

@isTest
public class ServicenowCommunicationMock implements HttpCalloutMock {
    
    /*
    *********************************************************
    @Method Name    : respond
    @author         : Soham Datta  
    @description    : Mock response for servicenow.
    @param          :
    *********************************************************
    */
    
    public HttpResponse respond(HttpRequest req) {
        HttpResponse res = new HttpResponse();
        Integer statusCode = 200;
        res.setHeader('Content-Type', 'application/json');
        
        String body = '';
        
        // Determine the type of request and provide the corresponding mock response.
        if (req.getEndpoint().contains('sys_user')){
            body = getUserIdResponse();
        }else if (req.getEndpoint().contains('incident')){
            statusCode = 201;
            body = getIncidentResponse();
        }
        
        // Deserialize the response body and set it in the HttpResponse.
        Map<String, Object> jsonMap = (Map<String, Object>) JSON.deserializeUntyped(body);
        String serializedJson = JSON.serialize(jsonMap);
        res.setBody(serializedJson);
        res.setStatusCode(statusCode);
        return res;
    }
    
    /*
    *********************************************************
    @Method Name    : getUserIdResponse
    @author         : Soham Datta  
    @description    : Mock response body for user
    @param          :
    *********************************************************
    */
    
    private String getUserIdResponse() {
        
        String body = '{'+
            '    \"result\": ['+
            '        {'+
            '            \"calendar_integration\": \"1\",'+
            '            \"country\": \"\",'+
            '            \"user_password\": \"$s$ykdSTfJoL3fsTmxyWALszeetw=$Whkeb9gxS1mByTjTQfsPFcEfOHq00yB4Gcih0DTQyDw=\",'+
            '            \"last_login_time\": \"\",'+
            '            \"source\": \"\",'+
            '            \"sys_updated_on\": \"2024-01-22 12:13:14\",'+
            '            \"building\": \"\",'+
            '            \"web_service_access_only\": \"false\",'+
            '            \"notification\": \"2\",'+
            '            \"enable_multifactor_authn\": \"false\",'+
            '            \"sys_updated_by\": \"admin\",'+
            '            \"sys_created_on\": \"2017-08-23 22:50:47\",'+
            '            \"sys_domain\": {'+
            '                \"link\": \"https://dev199939.service-now.com/api/now/table/sys_user_group/global\",'+
            '                \"value\": \"global\"'+
            '            },'+
            '            \"state\": \"\",'+
            '            \"vip\": \"false\",'+
            '            \"sys_created_by\": \"admin\",'+
            '            \"zip\": \"\",'+
            '            \"home_phone\": \"\",'+
            '            \"time_format\": \"\",'+
            '            \"last_login\": \"\",'+
            '            \"default_perspective\": \"\",'+
            '            \"active\": \"true\",'+
            '            \"sys_domain_path\": \"\",'+
            '            \"cost_center\": \"\",'+
            '            \"phone\": \"\",'+
            '            \"name\": \"admin\",'+
            '            \"employee_number\": \"\",'+
            '            \"password_needs_reset\": \"false\",'+
            '            \"gender\": \"\",'+
            '            \"city\": \"\",'+
            '            \"failed_attempts\": \"\",'+
            '            \"user_name\": \"admin\",'+
            '            \"roles\": \"\",'+
            '            \"title\": \"Admin\",'+
            '            \"sys_class_name\": \"sys_user\",'+
            '            \"sys_id\": \"88aad6c5c73003005f1b78d48b9763a5\",'+
            '            \"federated_id\": \"u76Pc4T4XGcpCzzT9gc8OubKXHnPd+r9iL+4l/2lANw=\",'+
            '            \"internal_integration_user\": \"false\",'+
            '            \"ldap_server\": \"\",'+
            '            \"mobile_phone\": \"\",'+
            '            \"street\": \"\",'+
            '            \"company\": \"\",'+
            '            \"department\": \"\",'+
            '            \"first_name\": \"Admin\",'+
            '            \"email\": \"test@gmail.com\",'+
            '            \"introduction\": \"\",'+
            '            \"preferred_language\": \"\",'+
            '            \"manager\": \"\",'+
            '            \"locked_out\": \"false\",'+
            '            \"sys_mod_count\": \"7\",'+
            '            \"last_name\": \"User\",'+
            '            \"photo\": \"\",'+
            '            \"avatar\": \"\",'+
            '            \"middle_name\": \"\",'+
            '            \"sys_tags\": \"\",'+
            '            \"time_zone\": \"\",'+
            '            \"u_ab_number\": \"AB0002\",'+
            '            \"schedule\": \"\",'+
            '            \"date_format\": \"\",'+
            '            \"location\": \"\"'+
            '        }'+
            '    ]'+
            '}';
        
        return body;
    }
    
    /*
    *********************************************************
    @Method Name    : getUserIdResponse
    @author         : Soham Datta  
    @description    : Mock response body for creating incident
    @param          :
    *********************************************************
    */
    
    private String getIncidentResponse() {
        
        String body = '{'+
            '    \"result\": {'+
            '        \"parent\": \"\",'+
            '        \"made_sla\": \"true\",'+
            '        \"caused_by\": \"\",'+
            '        \"watch_list\": \"\",'+
            '        \"upon_reject\": \"cancel\",'+
            '        \"sys_updated_on\": \"2024-01-24 09:30:25\",'+
            '        \"child_incidents\": \"0\",'+
            '        \"hold_reason\": \"\",'+
            '        \"origin_table\": \"\",'+
            '        \"task_effective_number\": \"INC0010032\",'+
            '        \"approval_history\": \"\",'+
            '        \"number\": \"INC0010032\",'+
            '        \"resolved_by\": \"\",'+
            '        \"sys_updated_by\": \"admin\",'+
            '        \"opened_by\": {'+
            '            \"link\": \"https://dev199939.service-now.com/api/now/table/sys_user/6816f79cc0a8016401c5a33be04be441\",'+
            '            \"value\": \"6816f79cc0a8016401c5a33be04be441\"'+
            '        },'+
            '        \"user_input\": \"\",'+
            '        \"sys_created_on\": \"2024-01-24 09:30:25\",'+
            '        \"sys_domain\": {'+
            '            \"link\": \"https://dev199939.service-now.com/api/now/table/sys_user_group/global\",'+
            '            \"value\": \"global\"'+
            '        },'+
            '        \"state\": \"1\",'+
            '        \"route_reason\": \"\",'+
            '        \"sys_created_by\": \"admin\",'+
            '        \"knowledge\": \"false\",'+
            '        \"order\": \"\",'+
            '        \"calendar_stc\": \"\",'+
            '        \"closed_at\": \"\",'+
            '        \"cmdb_ci\": \"\",'+
            '        \"delivery_plan\": \"\",'+
            '        \"contract\": \"\",'+
            '        \"impact\": \"3\",'+
            '        \"active\": \"true\",'+
            '        \"work_notes_list\": \"\",'+
            '        \"business_service\": \"\",'+
            '        \"business_impact\": \"\",'+
            '        \"priority\": \"5\",'+
            '        \"sys_domain_path\": \"/\",'+
            '        \"rfc\": \"\",'+
            '        \"time_worked\": \"\",'+
            '        \"expected_start\": \"\",'+
            '        \"opened_at\": \"2024-01-24 09:30:25\",'+
            '        \"business_duration\": \"\",'+
            '        \"group_list\": \"\",'+
            '        \"work_end\": \"\",'+
            '        \"caller_id\": {'+
            '            \"link\": \"https://dev199939.service-now.com/api/now/table/sys_user/6816f79cc0a8016401c5a33be04be441\",'+
            '            \"value\": \"6816f79cc0a8016401c5a33be04be441\"'+
            '        },'+
            '        \"reopened_time\": \"\",'+
            '        \"resolved_at\": \"\",'+
            '        \"approval_set\": \"\",'+
            '        \"subcategory\": \"\",'+
            '        \"work_notes\": \"\",'+
            '        \"universal_request\": \"\",'+
            '        \"short_description\": \"Test Incident\",'+
            '        \"close_code\": \"\",'+
            '        \"correlation_display\": \"\",'+
            '        \"delivery_task\": \"\",'+
            '        \"work_start\": \"\",'+
            '        \"assignment_group\": \"\",'+
            '        \"additional_assignee_list\": \"\",'+
            '        \"business_stc\": \"\",'+
            '        \"cause\": \"\",'+
            '        \"description\": \"\",'+
            '        \"origin_id\": \"\",'+
            '        \"calendar_duration\": \"\",'+
            '        \"close_notes\": \"\",'+
            '        \"notify\": \"1\",'+
            '        \"service_offering\": \"\",'+
            '        \"sys_class_name\": \"incident\",'+
            '        \"closed_by\": \"\",'+
            '        \"follow_up\": \"\",'+
            '        \"parent_incident\": \"\",'+
            '        \"sys_id\": \"f8bb772f93b33110629f3d6efaba1037\",'+
            '        \"contact_type\": \"\",'+
            '        \"reopened_by\": \"\",'+
            '        \"incident_state\": \"1\",'+
            '        \"urgency\": \"3\",'+
            '        \"problem_id\": \"\",'+
            '        \"company\": \"\",'+
            '        \"reassignment_count\": \"0\",'+
            '        \"activity_due\": \"\",'+
            '        \"assigned_to\": \"\",'+
            '        \"severity\": \"3\",'+
            '        \"comments\": \"\",'+
            '        \"approval\": \"not requested\",'+
            '        \"sla_due\": \"\",'+
            '        \"comments_and_work_notes\": \"\",'+
            '        \"due_date\": \"\",'+
            '        \"sys_mod_count\": \"0\",'+
            '        \"reopen_count\": \"0\",'+
            '        \"sys_tags\": \"\",'+
            '        \"escalation\": \"0\",'+
            '        \"upon_approval\": \"proceed\",'+
            '        \"correlation_id\": \"\",'+
            '        \"location\": \"\",'+
            '        \"category\": \"inquiry\"'+
            '    }'+
            '}';
        
        return body;
    }
    
}