/*
************************************************************************
Class Name         : OpenCageWrapper
Created Date       : Feb 5, 2024
@description       : This class is used to deserialize OpenCageData response
@author            : Soham Datta

Modification Log   :
Ver   Date         Author                               Modification
1.0   04-02-2024   Soham Datta                         Initial Version
*************************************************************************
*/

public with sharing class OpenCageWrapper {

	public class Geometry {
		@AuraEnabled public Double lat;
		@AuraEnabled public Double lng;
	}

	public class Status {
		public Integer code;
		public String message;
	}

	public class Results {
		public String formatted;
		public Geometry geometry;
	}

	public String documentation;
	public List<Results> results;
	public Status status;
	public Integer total_results;

	
	public static OpenCageWrapper parse(String json) {
		return (OpenCageWrapper) System.JSON.deserialize(json, OpenCageWrapper.class);
	}
}