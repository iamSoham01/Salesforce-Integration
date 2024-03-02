/*
************************************************************************
Class Name         : FacebookUtilMock
Created Date       : March 02, 2024
@description       : Mock class for Slack Facebook
@author            : Soham Datta

Modification Log   :

Ver   Date         Author                               Modification
1.0   02-03-2024   Soham Datta                         Initial Version
*************************************************************************
*/

@isTest
public class FacebookUtilMock implements HttpCalloutMock {
    
    /*
    *********************************************************
    @Method Name    : respond
    @author         : Soham Datta  
    @description    : Preparing mock response for Slack
    @param          :
    *********************************************************
    */

    public HttpResponse respond(HttpRequest req) {
        HttpResponse res = new HttpResponse();
        
        String endPoint = req.getEndpoint();
        String body = '';
       
        // Determine the type of request and provide the corresponding mock response.
        if (endPoint.contains('me?fields')){
            body = profileInfoResponse();
        }else if (endPoint.contains('accounts')){
            body = pageInfoResponse();
        }else if (endPoint.contains('chat.delete')){
            body = pageFeedPost();
        }
        
        // Set serialized body in the HttpResponse.
        res.setBody(body);
        res.setStatusCode(200);
        
        return res;
    }
    
    /*
    *********************************************************
    @Method Name    : profileInfoResponse
    @author         : Soham Datta  
    @description    : Facebook page profile response
    @param          :
    *********************************************************
    */

    private String profileInfoResponse() {
        
        String body = '{'+
            '  "id": "102529081207021",'+
            '  "name": "My Blog"'+
            '}';
        
        return body;
    }

    /*
    *********************************************************
    @Method Name    : postMsgResponse
    @author         : Soham Datta  
    @description    : Facebook page response
    @param          :
    *********************************************************
    */

    private String pageInfoResponse() {
        
        String body = '{'+
            '   "data": ['+
            '      {'+
            '         "access_token": "EABj5uqUdhBYBO9VM4P1d442CrUysC3LZA2QKNKUHSUHPbZC5uGZAXIrV8ZBaS4F20OfW76CjgaShmCP9nnns93RakyZCrrujeJEjSQJOZCATlSZAmvKHhzeI3Wh8KzgJN9rpVkMPm0H20hx9xSAP4sKTXDpGlUSdndywGHkJg0JdBrz01ZAtfZAMhqwavnAOj9sUKPGPqg9HyXZCOyaCAV3byhvF3uwZD",'+
            '         "category": "Education website",'+
            '         "category_list": ['+
            '            {'+
            '               "id": "2704",'+
            '               "name": "Education website"'+
            '            }'+
            '         ],'+
            '         "name": "Test Education",'+
            '         "id": "2468121311345997",'+
            '         "tasks": ['+
            '            "ADVERTISE",'+
            '            "ANALYZE",'+
            '            "CREATE_CONTENT",'+
            '            "MESSAGING",'+
            '            "MODERATE",'+
            '            "MANAGE"'+
            '         ]'+
            '      },'+
            '      {'+
            '         "access_token": "EABj5uqUdhBYBOxiPNEHWsdfsdjbQBBSbhbdbWnJRps4Xxz1HhYDK7Vy01inIOOUMWgeUi7GjACefs9pZBwhR6rlKWAR4tuWTcWIl4quGJnMnirwePkAX4BTlUB7DrNokvHeP9jFcIb3D5GcKPNdTx5ZBt2lzWNEGHS50O8McjMQMqjvehj6HO4W2xjr6ZAyBJQSehmaT8brgZD",'+
            '         "category": "Personal blog",'+
            '         "category_list": ['+
            '            {'+
            '               "id": "2700",'+
            '               "name": "Personal blog"'+
            '            }'+
            '         ],'+
            '         "name": "My Blog",'+
            '         "id": "102529014507881",'+
            '         "tasks": ['+
            '            "ADVERTISE",'+
            '            "ANALYZE",'+
            '            "CREATE_CONTENT",'+
            '            "MESSAGING",'+
            '            "MODERATE",'+
            '            "MANAGE"'+
            '         ]'+
            '      }'+
            '   ],'+
            '   "paging": {'+
            '      "cursors": {'+
            '         "before": "QVFIUmN4QWlzUHJZAV3oyaFNDRVloc1pobGptRzNBcGdnLWx2cy1yaVZAUSUlPdGtxQ2NjVXJYZA2Q5eVFIbUgwSzB2S0J6Rld0Sy04ZAkpMTG5VcXBYMFFjN25R",'+
            '         "after": "QVFIUkk4NnM5Ql9WX1hMcUxSb09OOGNLM3VkUEczTnBfZA04yeGhmQmhoeFcwYjJMVXJLXzZA2dXRsWFBhMlktMkdwUnVKNzNwM295MUw4MjJGVjRKOVRIOWln"'+
            '      }'+
            '   }'+
            '}'+
            '';
        
        return body;
    }
    
    /*
    *********************************************************
    @Method Name    : pageFeedPost
    @author         : Soham Datta  
    @description    : Post on facebook page response
    @param          :
    *********************************************************
    */

    private String pageFeedPost() {
        
        String body = '{'+
            '  "id": "102529081507021_713086634315952",'+
            '}';
        
        return body;
    }

}