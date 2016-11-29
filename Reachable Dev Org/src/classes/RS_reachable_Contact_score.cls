public with sharing class RS_reachable_Contact_score
{
    public static List<Reachable_Scoring__c> getscore(List<Contact> recordlist)
    {
        Integer i;
        Integer b;
        Integer statusCode;
        Integer statusCode1;
        HTTPResponse res;
        String leadid;
        String score;
        String PeopleID;
        String peoplescore;
        String CompanyId;
        String CompanyID1;
  //    ID ownerid_rec = userid;

        List<String> ContactidList      = new List<String>();
        List<String> PeopleIDList       = new List<String>();
        List<String> peoplescoreList    = new List<String>();
        List<String> CompanyIdList      = new List<String>();
        ID ownerid_rec;
        String a_token;
        Map<ID, Reachable_User_Setting__c> ml = new Map<ID, Reachable_User_Setting__c>();
        List<Reachable_Scoring__c> reachscore = new List<Reachable_Scoring__c>();

             ml = new Map<ID, Reachable_User_Setting__c>([SELECT Id, SF_Username__c,Reachable_Access_Token__c,ownerId FROM Reachable_User_Setting__c]);

     if(recordlist.size() > 0)
    {
     for(ID idKey : ml.keyset())
      {
        Reachable_User_Setting__c a1 = ml.get(idKey);
        a_token = RS_encryption_handler.decrypt(a1.Reachable_Access_Token__c);
        ownerid_rec = a1.ownerid; 
              
        for (Integer m = 0; m < recordlist.size(); m++)
        {
            ContactidList.add(recordlist[m].id);
        }
        
        // JSON generator
 
        JSONGenerator gen = JSON.createGenerator(true);
        gen.writeStartObject();        
        gen.writeFieldName('people');
        gen.writeStartArray();
        for( i = 0; i < recordlist.size(); i++)
        {
            gen.writeStartObject();
            gen.writeStringField('first', recordlist[i].firstname );
            gen.writeStringField('last', recordlist[i].lastname );
            gen.writeStringField('company', recordlist[i].Account.Name);
            gen.writeStringField('email', recordlist[i].email);
            gen.writeStringField('partnerTargetId','');
            gen.writeEndObject();
        }
        gen.writeEndArray();
        gen.writeStringField('output','path'); 
        gen.writeStringField('pathsPerPage','10');
        gen.writeStringField('pathFilterExpression','');
        gen.writeStringField('pathCompression','false');
//        gen.writeStringField('options','');
 //       gen.writeStringField('partnerId','');
 //       gen.writeStringField('callSource','');
        gen.writeStringField('accessToken',a_token);
        gen.writeEndObject();
        String jsonString = gen.getAsString();
        system.debug(jsonString);
        
        // building http POST request
                
        Http h = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://api.reachable.com/RestAPI.svc/PersonDataPost');
        req.setMethod('POST');
        req.settimeout(120000); 
        req.setHeader('content-type', 'application/json');
        req.setBody(jsonString);
        
        // sending request

         if(Test.isRunningTest())
         {
            res = new HttpResponse();
            String fake_response = '{"peopleIds" : [123,323],"BestScore" : 12345,"companyIds" : [4232,23312]}';  
            res.setHeader('Content-Type', 'application/json');
            res.setBody(fake_response);
            res.setStatusCode(200);
         }
        else
        {            
            res = h.send(req);
        }
          System.debug(res.getBody());
        
        statusCode = res.getstatusCode();
        if(statusCode == 200)
        // res is response ans resp is response body
        {
        String resp=res.getBody();
        system.debug('resp'+resp);
        JSONParser parser = JSON.createParser(resp);
        
        while (parser.nextToken() != null) 
        {
            if (parser.getCurrentToken() == JSONToken.FIELD_NAME)
                {
                    String fieldName = parser.getText();
                    parser.nextToken();
                    if(fieldName == 'peopleIds')
                    {
                        for(Integer j = i; j>0; j--)
                        {
                        parser.nextToken();
                        PeopleID = parser.getText();
                        PeopleIDList.add(PeopleID);
                        system.debug('PeopleID:'+PeopleID);    
                        }
                    }
                    if(fieldName == 'BestScore')
                    {
                        peoplescore = parser.getText();
                        peoplescoreList.add(peoplescore);
                        system.debug('peoplescore:'+peoplescore);
                    }
                    if(fieldName == 'companyIds')
                    {
                        for(Integer l = i; l>0; l--)
                        {
                            parser.nextToken();
                            CompanyID = parser.getText();
                            if(CompanyID == '-1')
                            {
                            CompanyID = '0';
                            CompanyIDList.add(CompanyID);
                            }
                            else
                            {
                            CompanyIDList.add(CompanyID);
                            }
                            system.debug('companyIds:'+CompanyID);
                        }
                    } 
                 }         
            }

        
        system.debug('PeopleIDList:'+ PeopleIDList);
        system.debug('peoplescoreList'+ peoplescoreList);
        system.debug('CompanyIDList:'+ CompanyIDList);

        system.debug('recordlist.size()'+recordlist.size());

        for(Integer a = 0; a < recordlist.size(); a++)
        {
           String complete_name = recordlist[a].lastname + ' ' + recordlist[a].firstname;
           reachscore.add(new Reachable_Scoring__c(Name__c = complete_name,Company__c = recordlist[a].Account.Name, ContactID__c = ContactidList[a], Person_ID__c = PeopleIDList[a], Person_Score__c = peoplescoreList[a], Company_ID__c = CompanyIDList[a],UserID__c = ownerid_rec,ownerid = ownerid_rec));
        }        

        
        system.debug(reachscore);
        }
         ContactidList      = new List<String>();
         PeopleIDList       = new List<String>();
         peoplescoreList    = new List<String>();
         CompanyIdList      = new List<String>();   
        }
        }
        return reachscore; 
    }
}