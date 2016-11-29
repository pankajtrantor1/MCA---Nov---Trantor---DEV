public with sharing class rs_reachableteaminvite
{
    public static String getteamemailid(Set<String> inviteemaillist, String Reachable_Team_ID, String accessToken)
    {
    
     String Status;
     String Error_message;
     String Message;
     String Email_ID;
     HTTPResponse res;
     
     system.debug('Reachable Team ID' + Reachable_Team_ID);
     system.debug('Invite Email List' + inviteemaillist);
     
     // JSON generator
     
     JSONGenerator gen = JSON.createGenerator(true);
     gen.writeStartObject();
     gen.writeStringField('accessToken', accessToken);
     gen.writeStringField('TRID', Reachable_Team_ID);
     gen.writeObjectField('inviteEmails',inviteemaillist);
     gen.writeEndObject();
     String jsonString = gen.getAsString();
     system.debug(jsonString);     
     
     // building http POST request
         
     Http h = new Http();
     HttpRequest req = new HttpRequest();
     req.setEndpoint('https://api.reachable.com/RestAPI.svc/TeamReachMultiInvite');
     req.setMethod('POST'); 
     req.setHeader('content-type', 'application/json');
     req.setBody(jsonString);
     
     // sending request
         
             if(Test.isRunningTest())
         {
            res = new HttpResponse();
            String fake_response = '{"Message" : "ABC","Status" : "false"}';  
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
     system.debug('res' + res);
     system.debug('resp'+resp);
     JSONParser parser = JSON.createParser(resp);

     // parsing response to check status == true & get message
     
         while (parser.nextToken() != null)
         {
           if ((parser.getCurrentToken() == JSONToken.FIELD_NAME))
           {
               String fieldName = parser.getText();
               parser.nextToken();
               if (fieldName == 'Message')  
               {
                 Message = parser.getText();
                 system.debug('Message :'+ Message); 
               }
               if(fieldName == 'Status')
               {
                 Status = parser.getText();
                 system.debug('Status :'+Status);
               }         
           }
         }
         
     // validate the status and Message. Message should be null & status should be true
       
     if(Status == 'false' || Message != 'null')
     {
       Error_message = 'Unable to send invite to team on reachable.';
       system.debug('Error Message :'+ Error_message);
       system.debug('Reason :'+ Message);
     }              

     return Message;
    }
}