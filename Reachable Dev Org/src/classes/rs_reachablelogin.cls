public with sharing class rs_reachablelogin
{
    public static String gettoken(String username, String password)
    {
        // Declarations
       
        String accesstoken;
        String Status;
        String Error_message;
         HTTPResponse res;
        // Display username
        
        system.debug('username:' + username);
        
        // JSON generator
        
        JSONGenerator gen = JSON.createGenerator(true);
        gen.writeStartObject();        
        gen.writeStringField('user', username); 
        gen.writeStringField('password', password);   
        gen.writeEndObject();
        String jsonString = gen.getAsString();
        
        // building http POST request
        
        Http h = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://api.reachable.com/RestAPI.svc/AccessToken');
        req.setMethod('POST'); 
        req.setHeader('content-type', 'application/json');
        req.setBody(jsonString);
        
        // sending request
         if(Test.isRunningTest())
         {
            res = new HttpResponse();
            String fake_response = '{"Status" : "false","accessToken" : "sjxbskjxb-8uy8-xj90-xlknxlks"}';  
            res.setHeader('Content-Type', 'application/json');
            res.setBody(fake_response);
            res.setStatusCode(200);
         }
        else
        {        
            res = h.send(req);
        }
       
        System.debug(res.getBody());
        
        // res is response ans resp is response body
        
        String resp=res.getBody();
        system.debug('resp'+resp);
        JSONParser parser = JSON.createParser(resp);
        
        // parsing response to check status == true & get access token
        
        while (parser.nextToken() != null) 
        { 
          if ((parser.getCurrentToken() == JSONToken.FIELD_NAME)) 
           {
              String fieldName = parser.getText();
              parser.nextToken();
              
              if(fieldName == 'Status')
              {
                Status = parser.getText();
                system.debug('Status'+Status);
              }
            
              if (fieldName == 'accessToken')  
              {
                accessToken = parser.getText();
                system.debug('Access Token is :'+accessToken); 
              }    
           }
        }
        
        
        if(Status == 'false')
        {
          Error_message = 'Username or Password is incorrect.';
          system.debug(Error_message);
        }
        
        return accesstoken;
    }
}