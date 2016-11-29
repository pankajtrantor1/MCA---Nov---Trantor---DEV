@isTest
public class RS_Company_score_Test
{
   static testMethod void ScoreCal()
   {   
    Test.startTest();
     String accessToken = 'TK345CFGG687-9gbc-ghgj-87hgbnfgg4d5';
   
     Lead leadrec = new Lead(LastName ='Test1',Company = 'Comp');
     System.assertEquals('Test1', leadrec.LastName);
     Insert leadrec;             
       
    
     Profile profileId = [SELECT Id FROM Profile WHERE Name = 'Standard User' LIMIT 1];
      
     User testuser = new User(LastName = 'LIVESTON', FirstName='JASON',Alias = 'jliv',Email = 'jason.liveston@asdf.com',
                         Username = 'jillete.liveston78@asdf.com',ProfileId = profileId.id,TimeZoneSidKey = 'GMT',
                         LanguageLocaleKey = 'en_US',EmailEncodingKey = 'UTF-8',LocaleSidKey = 'en_US');
                         
     System.assertEquals('JASON', testuser.FirstName);                       
     insert testuser; 
 
        
       
     Reachable_Scoring__c reachscore = new Reachable_Scoring__c(Company_ID__c = '1425', Company_score__c = '82',Person_Score__c = '70',USERID__c = testuser.id ,LeadID__c = leadrec.id );
     System.assertEquals('1425', reachscore.Company_ID__c);
     insert reachscore;       
     
     
       
       RS_Company_score tokentest = new RS_Company_score();
        
        List<Reachable_Scoring__c> reachscorelst = [select ID,LeadID__c,USERID__c,Company_Score__c,Person_Score__c,Company_ID__c,Person_ID__c from Reachable_Scoring__c where id = :reachscore.id];
        
        System.assertEquals('82', reachscorelst[0].Company_score__c);
        System.assertEquals('TK345CFGG687-9gbc-ghgj-87hgbnfgg4d5', accessToken);
        
        RS_Company_score.getscore(reachscorelst,accessToken);      

        
        //String resp = '{"peopleIds":["9561397"],"connectors":"null","paths":[{"EntityId":"9561397","BestScore":"84"}]}';
       
       Test.stopTest();
   }
}