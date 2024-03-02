/*
************************************************************************
Class Name         : ChatGTPResponseWrapper
Created Date       : Feb 8, 2024
@description       : This class is used to deserialize ChatGTP response
@author            : Soham Datta

Modification Log   :
Ver   Date         Author                               Modification
1.0   08-02-2024   Soham Datta                         Initial Version
*************************************************************************
*/

public class ChatGTPResponseWrapper{
	public String id;	
	public String model;	
	public List<cls_choices> choices;

	public class cls_choices {
		public Integer index;	
		public cls_message message;
		public String finish_reason;
	}

	public class cls_message {
		public String role;	
		public String content;	
	}

	public static ChatGTPResponseWrapper parse(String json){
		return (ChatGTPResponseWrapper) System.JSON.deserialize(json, ChatGTPResponseWrapper.class);
	}

}