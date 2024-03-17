/*
*********************************************************
Apex Class Name    : TrackWrapper
Created Date       : Mar 16, 2024
@description       : Wrapper class to deserialize all song tracks
@author            : Soham Datta

Modification Log:

Ver   Date         Author                               Modification
1.0   16-03-2024   Soham Datta                      	Initial Version
*********************************************************
*/

public class TrackWrapper {

    @AuraEnabled
    public String songName { get; set; }
    @AuraEnabled
    public String songUri { get; set; }
    @AuraEnabled
    public String songThumbnail { get; set; }

    public TrackWrapper(String songName, String songUri, String songThumbnail) {
        this.songName = songName;
        this.songUri = songUri;
        this.songThumbnail = songThumbnail;
    }
}

