/*
************************************************************************
Class Name         : YoutubeSearchWrapper
Created Date       : Mar 18, 2024
@description       : This class is used to store youtube video search details
@author            : Soham Datta

Modification Log   :
Ver   Date         Author                               Modification
1.0   18-03-2024   Soham Datta                         Initial Version
*************************************************************************
*/

public class YoutubeSearchWrapper {

    @AuraEnabled
    public String videoURL {get;set;}
    @AuraEnabled
    public String videoTitle {get;set;}
    @AuraEnabled
    public String videoThumbnail {get;set;}
    
}