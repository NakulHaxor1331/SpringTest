public with sharing class SpringSOAcallOutApex {
    
    public static void callOutHandler(){

        String endPoint = 'https://postman-echo.com/get?foo1=bar1&foo2=bar2';

        httpRequest req = new HttpRequest();
        req.setEndpoint(endpoint);
        req.setMethod('GET');
        http http = new http();

        HttpResponse res = http.send(req);

        if(res.getStatusCode() == 200){
            system.debug('res 200 is :::' + JSON.serialize(res.getBody()));
        }
        else{
            system.debug('Callout Error ::: ' + res.getStatusCode());
        }
        

    }
}