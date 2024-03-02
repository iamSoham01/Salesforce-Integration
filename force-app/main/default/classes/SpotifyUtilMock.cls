/*
************************************************************************
Class Name         : SpotifyUtilMock
Created Date       : Feb 29, 2024
@description       : Mock class for Spotify Callout
@author            : Soham Datta

Modification Log   :

Ver   Date         Author                               Modification
1.0   29-02-2024   Soham Datta                         Initial Version
*************************************************************************
*/

@isTest
public class SpotifyUtilMock implements HttpCalloutMock {
    
    /*
    *********************************************************
    @Method Name    : respond
    @author         : Soham Datta  
    @description    : Preparing mock response for Spotify
    @param          :
    *********************************************************
    */

    public HttpResponse respond(HttpRequest req) {
        HttpResponse res = new HttpResponse();
        
        String body = '';
       
        // Determine the type of request and provide the corresponding mock response.
        if (req.getEndpoint().contains('currently-playing')){
            body = currentPlayingSongResponse();
        }
        
        // Set serialized body in the HttpResponse.
        res.setBody(body);
        res.setStatusCode(200);
        
        return res;
    }
    
    /*
    *********************************************************
    @Method Name    : currentPlayingSongResponse
    @author         : Soham Datta  
    @description    : Current playing track response
    @param          :
    *********************************************************
    */

    private String currentPlayingSongResponse() {
        
        String body = '{'+
		'    "timestamp": 1709188054048,'+
		'    "context": null,'+
		'    "progress_ms": 42797,'+
		'    "item": {'+
		'        "album": {'+
		'            "album_type": "album",'+
		'            "artists": ['+
		'                {'+
		'                    "external_urls": {'+
		'                        "spotify": "https://open.spotify.com/artist/1Xyo4u8uXC1ZmMpatF05PJ"'+
		'                    },'+
		'                    "href": "https://api.spotify.com/v1/artists/1Xyo4u8uXC1ZmMpatF05PJ",'+
		'                    "id": "1Xyo4u8uXC1ZmMpatF05PJ",'+
		'                    "name": "The Weeknd",'+
		'                    "type": "artist",'+
		'                    "uri": "spotify:artist:1Xyo4u8uXC1ZmMpatF05PJ"'+
		'                }'+
		'            ],'+
		'            "available_markets": ['+
		'                "AR",'+
		'                "AU",'+
		'                "AT",'+
		'                "BE",'+
		'                "BO",'+
		'                "BR",'+
		'                "BG",'+
		'                "CA",'+
		'                "CL",'+
		'                "CO",'+
		'                "CR",'+
		'                "CY",'+
		'                "CZ",'+
		'                "DK",'+
		'                "DO",'+
		'                "DE",'+
		'                "EC",'+
		'                "EE",'+
		'                "SV",'+
		'                "FI",'+
		'                "FR",'+
		'                "GR",'+
		'                "GT",'+
		'                "HN",'+
		'                "HK",'+
		'                "HU",'+
		'                "IS",'+
		'                "IE",'+
		'                "IT",'+
		'                "LV",'+
		'                "LT",'+
		'                "LU",'+
		'                "MY",'+
		'                "MT",'+
		'                "MX",'+
		'                "NL",'+
		'                "NZ",'+
		'                "NI",'+
		'                "NO",'+
		'                "PA",'+
		'                "PY",'+
		'                "PE",'+
		'                "PH",'+
		'                "PL",'+
		'                "PT",'+
		'                "SG",'+
		'                "SK",'+
		'                "ES",'+
		'                "SE",'+
		'                "CH",'+
		'                "TW",'+
		'                "TR",'+
		'                "UY",'+
		'                "US",'+
		'                "GB",'+
		'                "AD",'+
		'                "LI",'+
		'                "MC",'+
		'                "ID",'+
		'                "JP",'+
		'                "TH",'+
		'                "VN",'+
		'                "RO",'+
		'                "IL",'+
		'                "ZA",'+
		'                "SA",'+
		'                "AE",'+
		'                "BH",'+
		'                "QA",'+
		'                "OM",'+
		'                "KW",'+
		'                "EG",'+
		'                "MA",'+
		'                "DZ",'+
		'                "TN",'+
		'                "LB",'+
		'                "JO",'+
		'                "PS",'+
		'                "IN",'+
		'                "KZ",'+
		'                "MD",'+
		'                "UA",'+
		'                "AL",'+
		'                "BA",'+
		'                "HR",'+
		'                "ME",'+
		'                "MK",'+
		'                "RS",'+
		'                "SI",'+
		'                "KR",'+
		'                "BD",'+
		'                "PK",'+
		'                "LK",'+
		'                "GH",'+
		'                "KE",'+
		'                "NG",'+
		'                "TZ",'+
		'                "UG",'+
		'                "AG",'+
		'                "AM",'+
		'                "BS",'+
		'                "BB",'+
		'                "BZ",'+
		'                "BT",'+
		'                "BW",'+
		'                "BF",'+
		'                "CV",'+
		'                "CW",'+
		'                "DM",'+
		'                "FJ",'+
		'                "GM",'+
		'                "GE",'+
		'                "GD",'+
		'                "GW",'+
		'                "GY",'+
		'                "HT",'+
		'                "JM",'+
		'                "KI",'+
		'                "LS",'+
		'                "LR",'+
		'                "MW",'+
		'                "MV",'+
		'                "ML",'+
		'                "MH",'+
		'                "FM",'+
		'                "NA",'+
		'                "NR",'+
		'                "NE",'+
		'                "PW",'+
		'                "PG",'+
		'                "WS",'+
		'                "SM",'+
		'                "ST",'+
		'                "SN",'+
		'                "SC",'+
		'                "SL",'+
		'                "SB",'+
		'                "KN",'+
		'                "LC",'+
		'                "VC",'+
		'                "SR",'+
		'                "TL",'+
		'                "TO",'+
		'                "TT",'+
		'                "TV",'+
		'                "VU",'+
		'                "AZ",'+
		'                "BN",'+
		'                "BI",'+
		'                "KH",'+
		'                "CM",'+
		'                "TD",'+
		'                "KM",'+
		'                "GQ",'+
		'                "SZ",'+
		'                "GA",'+
		'                "GN",'+
		'                "KG",'+
		'                "LA",'+
		'                "MO",'+
		'                "MR",'+
		'                "MN",'+
		'                "NP",'+
		'                "RW",'+
		'                "TG",'+
		'                "UZ",'+
		'                "ZW",'+
		'                "BJ",'+
		'                "MG",'+
		'                "MU",'+
		'                "MZ",'+
		'                "AO",'+
		'                "CI",'+
		'                "DJ",'+
		'                "ZM",'+
		'                "CD",'+
		'                "CG",'+
		'                "IQ",'+
		'                "LY",'+
		'                "TJ",'+
		'                "VE",'+
		'                "ET",'+
		'                "XK"'+
		'            ],'+
		'            "external_urls": {'+
		'                "spotify": "https://open.spotify.com/album/4qZBW3f2Q8y0k1A84d4iAO"'+
		'            },'+
		'            "href": "https://api.spotify.com/v1/albums/4qZBW3f2Q8y0k1A84d4iAO",'+
		'            "id": "4qZBW3f2Q8y0k1A84d4iAO",'+
		'            "images": ['+
		'                {'+
		'                    "height": 640,'+
		'                    "url": "https://i.scdn.co/image/ab67616d0000b2731f6a2a40bb692936879db730",'+
		'                    "width": 640'+
		'                },'+
		'                {'+
		'                    "height": 300,'+
		'                    "url": "https://i.scdn.co/image/ab67616d00001e021f6a2a40bb692936879db730",'+
		'                    "width": 300'+
		'                },'+
		'                {'+
		'                    "height": 64,'+
		'                    "url": "https://i.scdn.co/image/ab67616d000048511f6a2a40bb692936879db730",'+
		'                    "width": 64'+
		'                }'+
		'            ],'+
		'            "name": "My Dear Melancholy,",'+
		'            "release_date": "2018-03-30",'+
		'            "release_date_precision": "day",'+
		'            "total_tracks": 7,'+
		'            "type": "album",'+
		'            "uri": "spotify:album:4qZBW3f2Q8y0k1A84d4iAO"'+
		'        },'+
		'        "artists": ['+
		'            {'+
		'                "external_urls": {'+
		'                    "spotify": "https://open.spotify.com/artist/1Xyo4u8uXC1ZmMpatF05PJ"'+
		'                },'+
		'                "href": "https://api.spotify.com/v1/artists/1Xyo4u8uXC1ZmMpatF05PJ",'+
		'                "id": "1Xyo4u8uXC1ZmMpatF05PJ",'+
		'                "name": "The Weeknd",'+
		'                "type": "artist",'+
		'                "uri": "spotify:artist:1Xyo4u8uXC1ZmMpatF05PJ"'+
		'            },'+
		'            {'+
		'                "external_urls": {'+
		'                    "spotify": "https://open.spotify.com/artist/3hteYQFiMFbJY7wS0xDymP"'+
		'                },'+
		'                "href": "https://api.spotify.com/v1/artists/3hteYQFiMFbJY7wS0xDymP",'+
		'                "id": "3hteYQFiMFbJY7wS0xDymP",'+
		'                "name": "Gesaffelstein",'+
		'                "type": "artist",'+
		'                "uri": "spotify:artist:3hteYQFiMFbJY7wS0xDymP"'+
		'            }'+
		'        ],'+
		'        "available_markets": ['+
		'            "AR",'+
		'            "AU",'+
		'            "AT",'+
		'            "BE",'+
		'            "BO",'+
		'            "BR",'+
		'            "BG",'+
		'            "CA",'+
		'            "CL",'+
		'            "CO",'+
		'            "CR",'+
		'            "CY",'+
		'            "CZ",'+
		'            "DK",'+
		'            "DO",'+
		'            "DE",'+
		'            "EC",'+
		'            "EE",'+
		'            "SV",'+
		'            "FI",'+
		'            "FR",'+
		'            "GR",'+
		'            "GT",'+
		'            "HN",'+
		'            "HK",'+
		'            "HU",'+
		'            "IS",'+
		'            "IE",'+
		'            "IT",'+
		'            "LV",'+
		'            "LT",'+
		'            "LU",'+
		'            "MY",'+
		'            "MT",'+
		'            "MX",'+
		'            "NL",'+
		'            "NZ",'+
		'            "NI",'+
		'            "NO",'+
		'            "PA",'+
		'            "PY",'+
		'            "PE",'+
		'            "PH",'+
		'            "PL",'+
		'            "PT",'+
		'            "SG",'+
		'            "SK",'+
		'            "ES",'+
		'            "SE",'+
		'            "CH",'+
		'            "TW",'+
		'            "TR",'+
		'            "UY",'+
		'            "US",'+
		'            "GB",'+
		'            "AD",'+
		'            "LI",'+
		'            "MC",'+
		'            "ID",'+
		'            "JP",'+
		'            "TH",'+
		'            "VN",'+
		'            "RO",'+
		'            "IL",'+
		'            "ZA",'+
		'            "SA",'+
		'            "AE",'+
		'            "BH",'+
		'            "QA",'+
		'            "OM",'+
		'            "KW",'+
		'            "EG",'+
		'            "MA",'+
		'            "DZ",'+
		'            "TN",'+
		'            "LB",'+
		'            "JO",'+
		'            "PS",'+
		'            "IN",'+
		'            "KZ",'+
		'            "MD",'+
		'            "UA",'+
		'            "AL",'+
		'            "BA",'+
		'            "HR",'+
		'            "ME",'+
		'            "MK",'+
		'            "RS",'+
		'            "SI",'+
		'            "KR",'+
		'            "BD",'+
		'            "PK",'+
		'            "LK",'+
		'            "GH",'+
		'            "KE",'+
		'            "NG",'+
		'            "TZ",'+
		'            "UG",'+
		'            "AG",'+
		'            "AM",'+
		'            "BS",'+
		'            "BB",'+
		'            "BZ",'+
		'            "BT",'+
		'            "BW",'+
		'            "BF",'+
		'            "CV",'+
		'            "CW",'+
		'            "DM",'+
		'            "FJ",'+
		'            "GM",'+
		'            "GE",'+
		'            "GD",'+
		'            "GW",'+
		'            "GY",'+
		'            "HT",'+
		'            "JM",'+
		'            "KI",'+
		'            "LS",'+
		'            "LR",'+
		'            "MW",'+
		'            "MV",'+
		'            "ML",'+
		'            "MH",'+
		'            "FM",'+
		'            "NA",'+
		'            "NR",'+
		'            "NE",'+
		'            "PW",'+
		'            "PG",'+
		'            "WS",'+
		'            "SM",'+
		'            "ST",'+
		'            "SN",'+
		'            "SC",'+
		'            "SL",'+
		'            "SB",'+
		'            "KN",'+
		'            "LC",'+
		'            "VC",'+
		'            "SR",'+
		'            "TL",'+
		'            "TO",'+
		'            "TT",'+
		'            "TV",'+
		'            "VU",'+
		'            "AZ",'+
		'            "BN",'+
		'            "BI",'+
		'            "KH",'+
		'            "CM",'+
		'            "TD",'+
		'            "KM",'+
		'            "GQ",'+
		'            "SZ",'+
		'            "GA",'+
		'            "GN",'+
		'            "KG",'+
		'            "LA",'+
		'            "MO",'+
		'            "MR",'+
		'            "MN",'+
		'            "NP",'+
		'            "RW",'+
		'            "TG",'+
		'            "UZ",'+
		'            "ZW",'+
		'            "BJ",'+
		'            "MG",'+
		'            "MU",'+
		'            "MZ",'+
		'            "AO",'+
		'            "CI",'+
		'            "DJ",'+
		'            "ZM",'+
		'            "CD",'+
		'            "CG",'+
		'            "IQ",'+
		'            "LY",'+
		'            "TJ",'+
		'            "VE",'+
		'            "ET",'+
		'            "XK"'+
		'        ],'+
		'        "disc_number": 1,'+
		'        "duration_ms": 241066,'+
		'        "explicit": false,'+
		'        "external_ids": {'+
		'            "isrc": "USUG11800570"'+
		'        },'+
		'        "external_urls": {'+
		'            "spotify": "https://open.spotify.com/track/1cKHdTo9u0ZymJdPGSh6nq"'+
		'        },'+
		'        "href": "https://api.spotify.com/v1/tracks/1cKHdTo9u0ZymJdPGSh6nq",'+
		'        "id": "1cKHdTo9u0ZymJdPGSh6nq",'+
		'        "is_local": false,'+
		'        "name": "I Was Never There",'+
		'        "popularity": 88,'+
		'        "preview_url": "https://p.scdn.co/mp3-preview/864beb42c5ce89268e7793268a606202c5aec12c?cid=c8143a8be8244c7d8702e0ad207c3a2d",'+
		'        "track_number": 4,'+
		'        "type": "track",'+
		'        "uri": "spotify:track:1cKHdTo9u0ZymJdPGSh6nq"'+
		'    },'+
		'    "currently_playing_type": "track",'+
		'    "actions": {'+
		'        "disallows": {'+
		'            "pausing": true,'+
		'            "toggling_repeat_context": true,'+
		'            "toggling_repeat_track": true,'+
		'            "toggling_shuffle": true'+
		'        }'+
		'    },'+
		'    "is_playing": true'+
		'}';
        
        return body;
    }

}