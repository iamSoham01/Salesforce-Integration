/*
************************************************************************
Class Name         : LinkedinUtil
Created Date       : Feb 13, 2024
@description       : This class is used to dynamically build soql query
@author            : Soham Datta

Modification Log   :
Ver   Date         Author                               Modification
1.0   13-02-2024   Soham Datta                         Initial Version
*************************************************************************
*/
global without sharing class SOQLUtil {

    private static FINAL String QUERY_SELECT = 'SELECT ';
    private static FINAL String QUERY_WHERE  = ' WHERE ';
    private static FINAL String QUERY_FROM   = ' FROM ';
    private static FINAL String QUERY_LIMIT  = ' LIMIT ';
    private static FINAL String SECURITY_ENFORCED = ' WITH SECURITY_ENFORCED';

    /*
    *********************************************************
    @Method Name    : buildSOQLQuery
    @author         : Soham Datta  
    @description    : Build SOQL string dynamically
    @param          : objName, filter
    *********************************************************
    */
    
    global static String buildSOQLQuery(String objName, String filter){
    
        Schema.sObjectType sobj = Schema.getGlobalDescribe().get(objName);
        DescribeSObjectResult objectDescribe = sobj.getDescribe();
        Map<String, Schema.SObjectField> fieldMap = objectDescribe.fields.getMap();
        
        String whereClause = 'Masterlabel ='+'\''+filter+'\'';
        String query = buildQueryAllString(fieldMap.values(),objectDescribe, whereClause, 1);
        
        return query;
    }

    /*
    *********************************************************
    @Method Name    : buildQueryAllString
    @author         : Soham Datta  
    @description    : Dynamically querying all fields of a object
    @param          : allFields, obj, filter, rLimit
    *********************************************************
    */
    
    private static String buildQueryAllString(List<Schema.SObjectField> allFields, DescribeSObjectResult obj, 
                        String filter, Integer rLimit) {
        
        String query = QUERY_SELECT;
        for(Schema.SObjectField dfr : allFields){
            query = query + dfr.getDescribe().getName() + ',';
        }
        query = query.subString(0,query.length() - 1);
        query = query + QUERY_FROM;
        query = query + obj.getName();
        if(!String.isBlank(filter)){
            query = query + QUERY_WHERE;
            query = query + filter;
        }
        query = query + SECURITY_ENFORCED;
        query = query + QUERY_LIMIT;
        query = query + rLimit;
        return query;
        
    }
}