@isTest 
 class RS_get_reachable_score_batch_Test 
 {
 
  List<Reachable_User_Setting__c> aa;
   
  
   static testMethod void testBatchClass() 
   {    
     Test.startTest(); 
     RS_get_reachable_score_batch b = new RS_get_reachable_score_batch(); 
     Database.BatchableContext BC;   
     
      Profile pr = [SELECT Id FROM Profile WHERE Name='System Administrator'];
     
      User uidis = new User(Alias = 'ssasdndt', Email='sstandardusertesta1@testorg.com',EmailEncodingKey='UTF-8', 
               LastName='Tasding', LanguageLocaleKey='en_US',LocaleSidKey='en_US', ProfileId = pr.Id,
               TimeZoneSidKey='America/Los_Angeles', UserName='sstandardusertest2@testorg.com');
      System.assertEquals('Tasding', uidis.LastName);
      insert uidis;
     
     List<Reachable_User_Setting__c> rechuser = new List<Reachable_User_Setting__c>();
     //count a=0;
     //for(integer i=0;i<=5;i++)
     {
       Reachable_User_Setting__c insert_record = new Reachable_User_Setting__c();
       insert_record.Reachable_Access_Token__c = '5t5VJJXD2xQ6nIkKq9CmWN/v/gy1SHNVCqjd9Vv2JqIIkM37Givf3IGcMtTwP4yj';
       insert_record.Reachable_Username__c = 'amit.sharma111@trantorinc.com';
       insert_record.SF_Username__c = 'subha1sh.chand111@trantorinc.com';
       rechuser.add(insert_record);
       
      // count a++;
     }
      System.assertEquals('amit.sharma111@trantorinc.com', rechuser[0].Reachable_Username__c);
     insert rechuser;
     
     system.debug('Rech_User_Setting : ' + rechuser);
     System.assertEquals('5t5VJJXD2xQ6nIkKq9CmWN/v/gy1SHNVCqjd9Vv2JqIIkM37Givf3IGcMtTwP4yj', rechuser[0].Reachable_Access_Token__c);
     String a_token = RS_encryption_handler.decrypt(rechuser[0].Reachable_Access_Token__c);
    
     /*Reachable_Scoring__c ScoringObject = new Reachable_Scoring__c();
     ScoringObject.Company_ID__c = 'f1sdfsd7844df';
     ScoringObject.UserID__c = uidis.id;
     insert ScoringObject;    */   
          
      List<Reachable_Scoring__c> r_score;
      string accessToken = 'fasdfedr41dse4ft';
        Lead leadrec1 = new Lead(firstname = 'firstname',lastname = 'lastname',company = 'company',email = 'email@test.com');
        System.assertEquals('firstname', leadrec1.firstname);
        insert leadrec1;
//        insert leadrec2;
      
      List<Lead> leadrecord = [Select id,firstname,lastname,company,email from Lead where firstname != null];
     
     RS_get_company_score_batch companyscore = new RS_get_company_score_batch();
     
      Database.QueryLocator ql = b.start(BC);
      b.execute(BC,leadrecord);
     // b.Finish(BC);
     // System.assert(wasMessageAdded(new ApexPages.Message('Test')));
     Test.stopTest();
    }
   
    
}