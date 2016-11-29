@isTest 
 class RS_get_reac_score_batch_Contact_Test 
 {
 
  List<Reachable_User_Setting__c> aa;
   
  
   static testMethod void testBatchClass() 
   {    
     Test.startTest();
     RS_get_reachable_score_batch_Contacts b = new RS_get_reachable_score_batch_Contacts(); 
     Database.BatchableContext BC;   
     
      Profile pr = [SELECT Id FROM Profile WHERE Name='Standard User'];
     
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
       insert_record.Reachable_Username__c = 'amit.sharma1121@trantorinc.com';
       insert_record.SF_Username__c = 'subha1sh.chand11@trantorinc.com';
       rechuser.add(insert_record);
      // count a++;
     }
      System.assertEquals('amit.sharma1121@trantorinc.com', rechuser[0].Reachable_Username__c);
     insert rechuser;
     
     system.debug('Rech_User_Setting : ' + rechuser);
     
     System.assertEquals('5t5VJJXD2xQ6nIkKq9CmWN/v/gy1SHNVCqjd9Vv2JqIIkM37Givf3IGcMtTwP4yj', rechuser[0].Reachable_Access_Token__c);
     
     String a_token = RS_encryption_handler.decrypt(rechuser[0].Reachable_Access_Token__c);
     Reachable_Scoring__c ScoringObject = new Reachable_Scoring__c();
     ScoringObject.Company_ID__c = 'f1sdfsd7844df';
     ScoringObject.UserID__c = uidis.id;
     
     System.assertEquals('f1sdfsd7844df', ScoringObject.Company_ID__c);
     
     insert ScoringObject;       
     
      Account acct = new Account(Name='SFDC Account');
      System.assertEquals('SFDC Account', acct.Name);
      insert acct;
      ID acctID = acct.ID;
      String AcName = acct.name;
          
      List<Reachable_Scoring__c> r_score;
      string accessToken = 'fasdfedr41dse4ft';
      Contact con = new Contact(FirstName='Joe',LastName='Smith',email='test14@gmail.com', AccountId = acctID);
      System.assertEquals('Joe', con.FirstName);
      insert con;  
//        insert leadrec2;
      
      List<Contact> recordlist = [Select ID,Account.Name,FirstName,LastName,Email from Contact where FirstName!= null and LastName !=null and email != null];
     
     RS_get_company_score_batch companyscore = new RS_get_company_score_batch();
     
      Database.QueryLocator ql = b.start(BC);
      b.execute(BC,recordlist);
      Test.stopTest();
  //    b.Finish(BC);
     // System.assert(wasMessageAdded(new ApexPages.Message('Test')));
    }
     Static testmethod void batch_second_Method()
     {
       Test.startTest();
       Account acct1 = new Account(Name='SFDC Account');
       System.assertEquals('SFDC Account', acct1.Name);
      insert acct1;
      ID acctID = acct1.ID; 
         
       Contact con1 = new Contact(FirstName='Joe1',LastName='Smith1',email='test114@gmail.com', AccountId = acctID);
       System.assertEquals('Joe1', con1.FirstName);
       insert con1;  
      
       List<Contact> recordlist = [Select ID,Account.Name,FirstName,LastName,Email from Contact where FirstName!= null and LastName !=null and email != null];
       
       RS_get_reachable_score_batch_Contacts bt = new RS_get_reachable_score_batch_Contacts(); 
       Database.BatchableContext BCt;  
     
       Database.QueryLocator ql = bt.start(BCt);
       bt.execute(BCt,recordlist);
       Test.stopTest();
      // bt.Finish(BCt); 
     }
   
    
}