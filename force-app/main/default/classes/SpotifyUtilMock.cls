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
        Integer statusCode = 200;
        
        String body = '';
       
        // Determine the type of request and provide the corresponding mock response.
        if (req.getEndpoint().contains('currently-playing')){
            body = currentPlayingSongResponse();
        }else if (req.getEndpoint().contains('search')){
            body = searchTrackResponse();
        }else if (req.getEndpoint().contains('devices')){
            body = getAvailableDevicesResponse();
        }else if (req.getEndpoint().contains('play')){
            statusCode = 204;
        }else if (req.getEndpoint().contains('pause')){
            statusCode = 204;
        }
        
        // Set serialized body in the HttpResponse.
        res.setBody(body);
        res.setStatusCode(statusCode);
        
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
    
    /*
    *********************************************************
    @Method Name    : searchTrackResponse
    @author         : Soham Datta  
    @description    : Search track response
    @param          :
    *********************************************************
    */

    private String searchTrackResponse() {
        
        String body = '{'+
            '  "tracks": {'+
            '    "items": ['+
            '      {'+
            '        "album": {'+
            '          "images": ['+
            '            {'+
            '              "height": 640,'+
            '              "url": "https://i.scdn.co/image/ab67616d0000b273d9cc24c0d415e40d5af3c8d5",'+
            '              "width": 640'+
            '            },'+
            '            {'+
            '              "height": 300,'+
            '              "url": "https://i.scdn.co/image/ab67616d00001e02d9cc24c0d415e40d5af3c8d5",'+
            '              "width": 300'+
            '            },'+
            '            {'+
            '              "height": 64,'+
            '              "url": "https://i.scdn.co/image/ab67616d00004851d9cc24c0d415e40d5af3c8d5",'+
            '              "width": 64'+
            '            }'+
            '          ]'+
            '        },'+
            '        "name": "Malang",'+
            '        "uri": "spotify:track:65bMbbRjIlGyJBgQRi6Qvv"'+
            '      },'+
            '      {'+
            '        "album": {'+
            '          "images": ['+
            '            {'+
            '              "height": 640,'+
            '              "url": "https://i.scdn.co/image/ab67616d0000b27390ecbd32d810440ceac60938",'+
            '              "width": 640'+
            '            },'+
            '            {'+
            '              "height": 300,'+
            '              "url": "https://i.scdn.co/image/ab67616d00001e0290ecbd32d810440ceac60938",'+
            '              "width": 300'+
            '            },'+
            '            {'+
            '              "height": 64,'+
            '              "url": "https://i.scdn.co/image/ab67616d0000485190ecbd32d810440ceac60938",'+
            '              "width": 64'+
            '            }'+
            '          ]'+
            '        },'+
            '        "name": "Dhoom Machale",'+
            '        "uri": "spotify:track:1j6aCQO3m8Vo9xaIqzoAPh"'+
            '      }'+
            '    ]'+
            '  }'+
            '}';
        
        return body;
    }
    
    /*
    *********************************************************
    @Method Name    : getAvailableDevicesResponse
    @author         : Soham Datta  
    @description    : Available devices response
    @param          :
    *********************************************************
    */

    private String getAvailableDevicesResponse() {
        
        String body = '{'+
            '    "devices": ['+
            '        {'+
            '            "id": "cb5a2c3eeb6775985fe959c03b1c57d54523e680",'+
            '            "is_active": false,'+
            '            "is_private_session": false,'+
            '            "is_restricted": false,'+
            '            "name": "Web Player (Chrome)",'+
            '            "supports_volume": true,'+
            '            "type": "Computer",'+
            '            "volume_percent": 80'+
            '        }'+
            '    ]'+
            '}';
        
        return body;
    }

}