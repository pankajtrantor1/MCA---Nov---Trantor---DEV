public with sharing class RS_Company_score
{
    public static List<Reachable_Scoring__c> getscore(List<Reachable_Scoring__c> score_Rec,String accessToken)
    {
        Integer statuscode;
        Integer b;
        HttpResponse res;
        String CompanyId;
        List<String> CompanyIDList = new List<String>();
        String Bestscore;
        List<String> BestscoreList = new List<String>();
        
        JSONGenerator gen = JSON.createGenerator(true);
        gen.writeStartObject();
        gen.writeFieldName('people');
        gen.writeStartArray();
        for(b = 0; b < score_Rec.size(); b++)
        {
            gen.writeStartObject();
            gen.writeStringField('personId', score_Rec[b].Company_ID__c);
            gen.writeEndObject();
        }
        gen.writeEndArray();
        gen.writeStringField('output','path');
        gen.writeNumberField('pathsPerPage',10);
        gen.writeBooleanField('pathCompression',true);
        gen.writeStringField('pathFilterExpression','require_current_at_company=0'); 
        gen.writeStringField('accessToken',accesstoken);
        gen.writeEndObject();
        
        String jsonString = gen.getAsString();
        system.debug(jsonString);
        
        Http h = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://api.reachable.com/RestAPI.svc/PersonDataPost');
        req.setMethod('POST');
        req.settimeout(120000); 
        req.setHeader('content-type', 'application/json');
        req.setBody(jsonString);
        
        
        if(Test.isRunningTest())
            {
                res = new HttpResponse();
                String fake_response = '{"peopleIds":["9561397"],"connectors":"null","paths":[{"EntityId":"9561397","BestScore":"84"}]}';  
                res.setHeader('Content-Type', 'application/json');
                res.setBody(fake_response);
                res.setStatusCode(200);
            }
        else
            {
                res = h.send(req);
                System.debug(res.getBody());
            }
        
        System.debug(res.getBody());
        String resp=res.getBody();
        system.debug('resp:'+resp);
        system.debug(res); 
        statusCode = res.getstatusCode();
        if(StatusCode == 200)
        {
            JSONParser parser = JSON.createParser(resp);
            while (parser.nextToken() != null) 
            {
                if (parser.getCurrentToken() == JSONToken.FIELD_NAME)
                {
                    String fieldName = parser.getText();
                    parser.nextToken();
                    if(fieldName == 'peopleIds')
                        {
                          for (Integer j = b ; j >0 ; j--)
                              {
                                  parser.nextToken();
                                  CompanyId = parser.getText();
                                  CompanyIDList.add(CompanyId);
                                  system.debug('CompanyId:'+CompanyId);
                              }
                        } 
                    if(fieldName == 'BestScore')
                        {
                            Bestscore= parser.getText();
                            BestscoreList.add(Bestscore);
                            system.debug('Bestscore:'+Bestscore);                    
                        }
                }
            }
        }
        
         system.debug('CompanyID List:'+CompanyIDList);
         system.debug('score List:' + BestscoreList);

        for(Integer i = 0; i < BestscoreList.size(); i++)
        {
            if(Schema.sObjectType.Reachable_Scoring__c.isAccessible()) 
           {   
               if(Schema.sObjectType.Reachable_Scoring__c.isUpdateable())  
               {  
                  if(Schema.sObjectType.Reachable_Scoring__c.fields.Company_Score__c.isAccessible()) 
                       {   
                           if(Schema.sObjectType.Reachable_Scoring__c.fields.Company_Score__c.isUpdateable())  
                               {  
                                 score_Rec[i].Company_Score__c = BestscoreList[i];
                               }
                       }
               }
           }
          
        }     
        system.debug('score_Rec'+score_Rec);
        if(Schema.sObjectType.Reachable_Scoring__c.isAccessible()) 
          {
              if(Schema.sObjectType.Reachable_Scoring__c.isUpdateable())  
              {  
               update score_Rec;
              }
          }

        return score_Rec;   
    }
}