/*
************************************************************************
Class Name         : GoogleCalendarCallout
Created Date       : March 111, 2024
@description       : This class is used to perform callout to Google Calendar
@author            : Soham Datta

Modification Log   :
Ver   Date         Author                               Modification
1.0   11-03-2024   Soham Datta                         Initial Version
*************************************************************************
*/
public class GoogleCalendarCallout {

    /*
    *********************************************************
    @Method Name    : createMeeting
    @author         : Soham Datta  
    @description    : Create google calender meeting using api
    @param          : mapAttributes
    *********************************************************
    */

    public static String createMeeting(Map<String, Object> mapAttributes){

        //Preparing request
        String evtURL = '';
        String endpoint = 'callout:GoogleCalendar/calendar/v3/calendars/primary/events';
        String requestBody = buildRequestBody(mapAttributes);
        
        Http http = new Http();
        HttpRequest httpReq   = GoogleUtil.prepareRequest(endPoint, ConstantClass.METHOD_POST, requestBody);
        HttpResponse response = new HttpResponse();
        
        try{
            response = http.send(httpReq);
            if( response.getStatusCode() == 200){
                CalendarEventDetails evtDetails = (CalendarEventDetails) System.JSON.deserialize(response.getBody(), CalendarEventDetails.class);
                evtURL = evtDetails.htmlLink;
            }else{
                throw new CustomException(response.getBody());
            }
            
        }catch(Exception e){
            throw new CustomException(e.getMessage());
        }
        return evtURL; 
    }

    /*
    *********************************************************
    @Method Name    : buildRequestBody
    @author         : Soham Datta  
    @description    : Prepare request body for create google calendar meeting
    @param          : mapAttributes
    *********************************************************
    */
    
    public static String buildRequestBody(Map<String, Object> mapAttributes){
                                                 
        // Attributes for requestBody
        String endDateTime = (String)mapAttributes.get('endDateTime');
        String startDateTime = (String)mapAttributes.get('startDateTime');
        String timeZone = (String)mapAttributes.get('timeZone');
        String meetingSubject = (String)mapAttributes.get('meetingSubject');
        String meetingDescription = (String)mapAttributes.get('meetingDescription');

        // Extract attendees email list and convert it to JSON string
        List<Map<String, String>> attendeesList = new List<Map<String, String>>();
        Object attendeesObj = mapAttributes.get('attendeesEmailList');
        if (attendeesObj instanceof List<Object>) {
            for (Object obj : (List<Object>)attendeesObj) {
                attendeesList.add(new Map<String, String>{'email' => String.valueOf(obj)});
            }
        } else if (attendeesObj != null) {
            attendeesList.add(new Map<String, String>{'email' => String.valueOf(attendeesObj)});
        }
        String attendeesJson = JSON.serialize(attendeesList);

        // Construct requestBody
        Map<String, Object> requestBody = new Map<String, Object>{
            'end' => new Map<String, String>{
                'dateTime' => endDateTime,
                'timeZone' => timeZone
            },
            'start' => new Map<String, String>{
                'dateTime' => startDateTime,
                'timeZone' => timeZone
            },
            'summary' => meetingSubject,
            'location' => 'Online',
            'sendUpdates' => 'all',
            'reminders' => new Map<String, Object>{
                'useDefault' => false,
                'overrides' => new List<Object>{
                    new Map<String, Object>{
                        'method' => 'email',
                        'minutes' => 1440
                    },
                    new Map<String, Object>{
                        'method' => 'popup',
                        'minutes' => 60
                    }
                }
            },
            'description' => meetingDescription,
            'attendees' => attendeesJson
        };

        return JSON.serialize(requestBody);
    }
    
}