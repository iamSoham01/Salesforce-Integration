/*
************************************************************************
Class Name         : GoogleUtilMock
Created Date       : Feb 12, 2024
@description       : Mock class for Google Callout
@author            : Soham Datta

Modification Log   :

Ver   Date         Author                               Modification
1.0   12-02-2024   Soham Datta                         Initial Version
*************************************************************************
*/

@isTest
public class GoogleUtilMock implements HttpCalloutMock {
    
    /*
    *********************************************************
    @Method Name    : respond
    @author         : Soham Datta  
    @description    : Preparing mock response for Google
    @param          :
    *********************************************************
    */

    public HttpResponse respond(HttpRequest req) {
        
        HttpResponse res = new HttpResponse();
        String requestMethod = req.getMethod();
        Integer statusCode = 200;
        
        res.setHeader(ConstantClass.CONTENT_TYPE, ConstantClass.CONTENT_TYPE_VALUE);        
        String body = '';
       
        // Determine the type of request and provide the corresponding mock response.
        if (req.getEndpoint().contains('calendar')){
            body = createMeetingResponse();
        }else if (req.getEndpoint().contains('gmail')){
            body = gmailResponse();
        }else if (req.getEndpoint().contains('drive')){
            
            if(requestMethod.contains('POST')){
                body = driveResponse();
            }else if(requestMethod.contains('DELETE')){
                statusCode = 204;
            }
            
        }else if (req.getEndpoint().contains('youtube')){
            body = youtubeResponse();
        }
        
        // Set serialized body in the HttpResponse.
        res.setBody(body);
        res.setStatusCode(statusCode);
        
        return res;
    }

    /*
    *********************************************************
    @Method Name    : createMeetingResponse
    @author         : Soham Datta  
    @description    : Google meeting response
    @param          :
    *********************************************************
    */

    private String createMeetingResponse() {
        
        String body = '{'+
            '    "kind": "calendar#event",'+
            '    "status": "confirmed",'+
            '    "htmlLink": "https://www.google.com/calendar/event?eid=M3NycHYxZjhibmU2ZW1nbzh2NWc0cXJlYzQgc29oYW1kYXR0YTAxQG0",'+
            '    "created": "2024-02-12T07:26:12.000Z",'+
            '    "updated": "2024-02-12T07:26:12.511Z",'+
            '    "summary": "Test Subject"'+
            '}';
        
        return body;
    }

    /*
    *********************************************************
    @Method Name    : gmailResponse
    @author         : Soham Datta  
    @description    : Gmail response
    @param          :
    *********************************************************
    */

    private String gmailResponse() {
        
        String body = '{'+
		'    "id": "18e2ca4e7db42dff",'+
		'    "threadId": "18e2ca4e7db42dff",'+
		'    "labelIds": ['+
		'        "UNREAD",'+
		'        "SENT",'+
		'        "INBOX"'+
		'    ]'+
		'}';
        
        return body;
    }
    
    /*
    *********************************************************
    @Method Name    : driveResponse
    @author         : Soham Datta  
    @description    : Google drive response
    @param          :
    *********************************************************
    */

    private String driveResponse() {
        
        String body = '{'+
            '    "kind": "drive#file",'+
            '    "id": "1-aio3oRYmrvWfV-glLWfj_Kiw0Y_Sg_7",'+
            '    "name": "logo.png",'+
            '    "mimeType": "image/png"'+
            '}';
        
        return body;
    }
    
    /*
    *********************************************************
    @Method Name    : youtubeResponse
    @author         : Soham Datta  
    @description    : Youtube search response
    @param          :
    *********************************************************
    */

    private String youtubeResponse() {
        
        String body = '{'+
            '  "items": ['+
            '    {'+
            '      "id": {'+
            '        "videoId": "2uUmHTgT65I"'+
            '      },'+
            '      "snippet": {'+
            '        "title": "Dhoom Machale Song | DHOOM, Esha Deol, John Abraham, Abhishek, Uday, Sunidhi Chauhan, Pritam, Sameer",'+
            '        "thumbnails": {'+
            '          "default": {'+
            '            "url": "https://i.ytimg.com/vi/2uUmHTgT65I/default.jpg",'+
            '            "width": 120,'+
            '            "height": 90'+
            '          },'+
            '          "medium": {'+
            '            "url": "https://i.ytimg.com/vi/2uUmHTgT65I/mqdefault.jpg",'+
            '            "width": 320,'+
            '            "height": 180'+
            '          },'+
            '          "high": {'+
            '            "url": "https://i.ytimg.com/vi/2uUmHTgT65I/hqdefault.jpg",'+
            '            "width": 480,'+
            '            "height": 360'+
            '          }'+
            '        }'+
            '      }'+
            '    },'+
            '    {'+
            '      "id": {'+
            '        "videoId": "q0loWjfX0d8"'+
            '      },'+
            '      "snippet": {'+
            '        "title": "Dilbara | Full Song | Dhoom | Abhishek Bachchan, Uday, Esha | Abhijeet, Sowmya | Pritam, Sameer",'+
            '        "thumbnails": {'+
            '          "default": {'+
            '            "url": "https://i.ytimg.com/vi/q0loWjfX0d8/default.jpg",'+
            '            "width": 120,'+
            '            "height": 90'+
            '          },'+
            '          "medium": {'+
            '            "url": "https://i.ytimg.com/vi/q0loWjfX0d8/mqdefault.jpg",'+
            '            "width": 320,'+
            '            "height": 180'+
            '          },'+
            '          "high": {'+
            '            "url": "https://i.ytimg.com/vi/q0loWjfX0d8/hqdefault.jpg",'+
            '            "width": 480,'+
            '            "height": 360'+
            '          }'+
            '        }'+
            '      }'+
            '    },'+
            '    {'+
            '      "id": {'+
            '        "videoId": "ilRIS3x2YA4"'+
            '      },'+
            '      "snippet": {'+
            '        "title": "Dhoom status",'+
            '        "thumbnails": {'+
            '          "default": {'+
            '            "url": "https://i.ytimg.com/vi/ilRIS3x2YA4/default.jpg",'+
            '            "width": 120,'+
            '            "height": 90'+
            '          },'+
            '          "medium": {'+
            '            "url": "https://i.ytimg.com/vi/ilRIS3x2YA4/mqdefault.jpg",'+
            '            "width": 320,'+
            '            "height": 180'+
            '          },'+
            '          "high": {'+
            '            "url": "https://i.ytimg.com/vi/ilRIS3x2YA4/hqdefault.jpg",'+
            '            "width": 480,'+
            '            "height": 360'+
            '          }'+
            '        }'+
            '      }'+
            '    }'+
            '  ]'+
            '}';
        
        return body;
    }

}