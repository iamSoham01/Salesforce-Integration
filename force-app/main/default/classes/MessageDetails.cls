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

public with sharing class MessageDetails {
  public boolean ok;
	public String channel;	
	public String ts;	
	public cls_message message;

	class cls_message {
		public String user;	
		public String ts;	
		public String text;	
	}
    
	public static MessageDetails parse(String json){
		return (MessageDetails) System.JSON.deserialize(json, MessageDetails.class);
	}
}