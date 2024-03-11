/*
************************************************************************
@Class Name         : OpenCageUtil
@Created Date       : Feb 5, 2024
@description       : This class is used to integrate Salesforce with OpenCageData
@author            : Soham Datta

@Modification Log   :
Ver   Date         Author                               Modification
1.0   04-02-2024   Soham Datta                         Initial Version
*************************************************************************
*/

public class OpenCageUtil {

    /*
    *********************************************************
    @Method Name    : reverseGeoCoding
    @author         : Soham Datta
    @description    : This method takes coordinates as input and provides corresponding address as output
    @param          : lat, lng
    @return         : String
    *********************************************************
    */
    
    @AuraEnabled(cacheable=true)
    public static String reverseGeoCoding(String lat, String lng) {

        String address = '';
        
        String coordinate = lat + ',' + lng;
        //Encode coordinates
        String encodedCoordinate = EncodingUtil.urlDecode(coordinate, 'UTF-8');
        //Preparing final endpoint
        //String endPoint = 'https://api.opencagedata.com/geocode/v1/json?key=b139c2a7f14e4fd58c11d68fd0982587&q=' + encodedCoordinate + '&pretty=1';
        String endPoint = System.Label.OpenCageEndPoint + 'key=' + System.Label.OpenCageApiKey + '&q=' + encodedCoordinate + '&pretty=1';
        
        Http http = new Http();
        HttpRequest req = new HttpRequest();
        HttpResponse res = new HttpResponse();
        
        //Preparing request
        req.setEndpoint(endPoint);
        req.setMethod(ConstantClass.METHOD_GET);
        req.setHeader(ConstantClass.CONTENT_TYPE, ConstantClass.CONTENT_TYPE_VALUE);
        
        try {
            //Callout to OpenCageData
            res = http.send(req);
            if(res.getStatusCode() == 200){
                //Storing response data
                OpenCageWrapper data = OpenCageWrapper.parse(res.getBody());
                address = data.results[0].formatted;
            }else {
                throw new CustomException(res.getBody());   
            }
        }catch(Exception e){
            throw new CustomException( e.getMessage());
        }
        
        return address;
        
    }

    /*
    *********************************************************
    @Method Name    : forwardGeoCoding
    @author         : Soham Datta
    @description    : This method takes address as input and provides corresponding coordinates as output
    @param          : addrss
    @return         : String
    *********************************************************
    */
    
    @AuraEnabled(cacheable=true)
    public static OpenCageWrapper.Geometry forwardGeoCoding(String address) {
        
        String errorMessage = '';
        OpenCageWrapper.Geometry coordinates;
        //Encode address
        String encodedAddress = EncodingUtil.urlDecode(address.deleteWhitespace(), 'UTF-8');
        //Preparing final endpoint
        //String endPoint = 'https://api.opencagedata.com/geocode/v1/json?key=b139c2a7f14e4fd58c11d68fd0982587&q=' + encodedAddress + '&pretty=1';
        String endPoint = System.Label.OpenCageEndPoint + 'key=' + System.Label.OpenCageApiKey + '&q=' + encodedAddress + '&pretty=1';
        
        Http http = new Http();
        HttpRequest req = new HttpRequest();
        HttpResponse res = new HttpResponse();
        
        //Preparing request
        req.setEndpoint(endPoint);
        req.setMethod(ConstantClass.METHOD_GET);
        req.setHeader(ConstantClass.CONTENT_TYPE, ConstantClass.CONTENT_TYPE_VALUE);
        
        try {
            //Callout to OpenCageData
            res = http.send(req);
            if(res.getStatusCode() == 200){
                //Storing response data
                OpenCageWrapper data = OpenCageWrapper.parse(res.getBody());
                coordinates = data.results[0].geometry;
            }else {
                throw new CustomException(res.getBody());   
            }
        }catch(Exception e){
            throw new CustomException(e.getMessage());
        }

        return coordinates;
                
    }
    
}