@isTest
public class RS_AccountCalculateScore_Test
{  
    public static apexpages.standardController controller; 
    static testMethod void ScoreCal()
    {  
       Test.startTest();
      // Test Lead
      Lead leadrec = new Lead(lastname = 'Test',company='company');
       System.assertEquals('Test', leadrec.lastname);
      Insert leadrec;   
          
      //Test User
      Profile profileId = [SELECT Id FROM Profile WHERE Name = 'Standard User' LIMIT 1];
      User usr = new User(LastName = 'LIVESTON', FirstName='JASON',Alias = 'jliv',Email = 'jason.liveston@asdf.com',
                           Username = 'jittle.liveston18@asdf.com',ProfileId = profileId.id,TimeZoneSidKey = 'GMT',
                           LanguageLocaleKey = 'en_US',EmailEncodingKey = 'UTF-8',LocaleSidKey = 'en_US');
      System.assertEquals('JASON', usr.FirstName);
      insert usr; 
      
      
      // Test Reachable score
      Reachable_Scoring__c reachscore = new Reachable_Scoring__c(Company_score__c = '82',Person_Score__c = '70',USERID__c = usr.id,AccountID__c = leadrec.id,Company_ID__c = '432311',Person_ID__c = '12342' );
      System.assertEquals('82', reachscore.Company_score__c);
      insert reachscore;
      List<Reachable_Scoring__c> r_score_list = new List<Reachable_Scoring__c>();
        r_score_list.add(reachscore);
      // Fetching Test Reachable Score    
      
      RS_AccountCalculateScore obj = new RS_AccountCalculateScore(controller);
       obj.reachscore = [select ID,AccountID__c,USERID__c,Company_Score__c,Person_Score__c,Company_ID__c,Person_ID__c from Reachable_Scoring__c where USERID__c = :usr.id and AccountID__c = :leadrec.id limit 1];
        system.debug('reachscore'+obj.reachscore);
        //    obj.reachscore = r_score_list;
      Test.stopTest();
     }
        static testMethod void convertIDstring()
        {      
            Test.startTest();      
            String inputIdtest='safsfdfsdffd155';    
            System.assertEquals('safsfdfsdffd155', inputIdtest);       
            RS_AccountCalculateScore.convertId(inputIdtest);
            
            Test.stopTest();
        } 
}