public with sharing class RS_Reachable_Team_Create_API
{
    public static String getteamid(String accessToken,String username)
    {
         String Error_Message;
         String Status;
         String Team_Name;
         String Reachable_Team_ID;
         HTTPResponse res;
        
         System.debug('AccessToken :'+ accessToken);
        
         // Fetch organization ID and name - Team Name = Organization name 
        
         Organization org_det = [SELECT Id, Name FROM Organization limit1];
         Team_Name = org_det.name;
         system.debug('Team Name :'+ Team_Name);    
         
         // JSON generator
         
         JSONGenerator gen = JSON.createGenerator(true);
         gen.writeStartObject();
         gen.writeStringField('accessToken', accessToken);
         gen.writeStringField('trName', Team_Name);
         gen.writeEndObject();
         String jsonString = gen.getAsString();
         system.debug(jsonString);
         
         // building http POST request
         
         Http h = new Http();
         HttpRequest req = new HttpRequest();
         req.setEndpoint('https://api.reachable.com/RestAPI.svc/CreateTeamReach');
         req.setMethod('POST'); 
         req.setHeader('content-type', 'application/json');
         req.setBody(jsonString);
         
         // sending request
         
         if(Test.isRunningTest())
         {
            res = new HttpResponse();
            String fake_response = '{"Message" : "ABC","Status" : "OK"}';  
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
         
         // parsing response to check status == true & get message
         
         while (parser.nextToken() != null)
         {
           if ((parser.getCurrentToken() == JSONToken.FIELD_NAME))
           {
               String fieldName = parser.getText();
               parser.nextToken();
               if (fieldName == 'Message')  
               {
                 Reachable_Team_ID = parser.getText();
                 system.debug('Reachable Team ID is :'+Reachable_Team_ID); 
               }
               if(fieldName == 'Status')
               {
                 Status = parser.getText();
                 system.debug('Status :'+Status);
               }
           }
         }
         
         // validate the status and reachable team id
         
         if(Status == 'false' || Reachable_Team_ID == 'null' || Reachable_Team_ID == null || Reachable_Team_ID == '')
         {
             Error_message = 'Unable to create team on reachable';
             system.debug('Error Message :'+ Error_message);
         }
         if(Status != 'false' && Reachable_Team_ID != 'null')         
         {
             List<Reachable_Org_Setting__c> org_set  = Reachable_Org_Setting__c.getall().values();
             
             if (!Schema.sObjectType.Reachable_Org_Setting__c.isAccessible())
             {
               ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL,'Insufficient access to update status'));
               return null;
             }
             
             for(Integer i = 0; i < org_set.size(); i++)
             {
                 if(org_set[i].Name == 'Reachable Org Settings')
                 {
                  if (!Schema.sObjectType.Reachable_Org_Setting__c.fields.Org_Team_ID__c.isAccessible())
                  {
                   ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL,'Insufficient access'));
                     return null;
                  } 
                  if (!Schema.sObjectType.Reachable_Org_Setting__c.fields.Org_Team_ID__c.isUpdateable())
                  {
                     ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL,'Insufficient access to update status'));
                     return null;
                  }             
                 
                  org_set[i].Org_Team_ID__c = Reachable_Team_ID;
                  if (!Schema.sObjectType.Reachable_Org_Setting__c.fields.Partner_admin_Username__c.isAccessible())
                  {
                   ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL,'Insufficient access'));
                     return null;
                  }
                  if (!Schema.sObjectType.Reachable_Org_Setting__c.fields.Partner_admin_Username__c.isUpdateable())
                  {
                     ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL,'Insufficient access to update status'));
                     return null;
                  }
                  
                  org_set[i].Partner_admin_Username__c = username;
                 }
             }
              if (!Schema.sObjectType.Reachable_Org_Setting__c.isAccessible())
              {
               ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL,'Insufficient access'));
                 return null;
              }
              if (!Schema.sObjectType.Reachable_Org_Setting__c.isUpdateable())
              {
                 ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL,'Insufficient access to update status'));
                 return null;
              }
             
             update org_set;
         }
       return Reachable_Team_ID;
    }
}