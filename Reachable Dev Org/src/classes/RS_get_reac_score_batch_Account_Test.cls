@isTest 
 class RS_get_reac_score_batch_Account_Test 
 {
  List<Reachable_User_Setting__c> aa;
   
   static testMethod void testBatchClass() 
   {    
      Test.startTest();
      RS_get_reachable_score_batch_Accounts b = new RS_get_reachable_score_batch_Accounts(); 
     Database.BatchableContext BC;   
     
      Profile pr = [SELECT Id FROM Profile WHERE Name='Standard User'];
     
      User uidis = new User(Alias = 'ssasdndt', Email='sstandardusertesta1@testorg.com',EmailEncodingKey='UTF-8', 
               LastName='Tasding', LanguageLocaleKey='en_US',LocaleSidKey='en_US', ProfileId = pr.Id,
               TimeZoneSidKey='America/Los_Angeles', UserName='sstandardusertest2@testorg.com');
      System.assertEquals('Tasding', uidis.LastName);
      insert uidis;
     
      List<Reachable_User_Setting__c> rechuser = new List<Reachable_User_Setting__c>();
     
       Reachable_User_Setting__c insert_record = new Reachable_User_Setting__c();
       insert_record.Reachable_Access_Token__c = '5t5VJJXD2xQ6nIkKq9CmWN/v/gy1SHNVCqjd9Vv2JqIIkM37Givf3IGcMtTwP4yj';
       insert_record.Reachable_Username__c = 'amit.sharma112@trantorinc.com';
       insert_record.SF_Username__c = 'subha1sh.chand11@trantorinc.com';
       rechuser.add(insert_record);
       System.assertEquals('amit.sharma112@trantorinc.com', rechuser[0].Reachable_Username__c);
       insert rechuser;
       
      System.assertEquals('5t5VJJXD2xQ6nIkKq9CmWN/v/gy1SHNVCqjd9Vv2JqIIkM37Givf3IGcMtTwP4yj', rechuser[0].Reachable_Access_Token__c); 
      String a_token = RS_encryption_handler.decrypt(rechuser[0].Reachable_Access_Token__c);    
    
    
     Account a = new Account(Name='Acme',BillingCity='San Francisco');
     System.assertEquals('Acme', a.Name);
     insert a; 
//        insert leadrec2;
      
       List<Account> recordlist = [Select ID,Name from Account where Name!= null];
     
    // RS_get_company_score_batch companyscore = new RS_get_company_score_batch();
     
      Database.QueryLocator ql = b.start(BC);
      b.execute(BC,recordlist);
     // b.Finish(BC);
     // System.assert(wasMessageAdded(new ApexPages.Message('Test')));
     Test.stopTest();
    }
   
      static testmethod void batch_run_Method()
      {
         Test.startTest();
          Profile pr = [SELECT Id FROM Profile WHERE Name='Standard User'];
     
          User uidis = new User(Alias = 'ssasdndt', Email='sstandardusertesta1@testorg.com',EmailEncodingKey='UTF-8', 
               LastName='Tasding', LanguageLocaleKey='en_US',LocaleSidKey='en_US', ProfileId = pr.Id,
               TimeZoneSidKey='America/Los_Angeles', UserName='sstandardusertest2@testorg.com');
          System.assertEquals('Tasding', uidis.LastName);
          insert uidis;
          
          Lead leadrec1 = new Lead(firstname = 'firstname',lastname = 'lastname',company = 'company',email = 'email@test.com');
          System.assertEquals('firstname', leadrec1.firstname);
          insert leadrec1;
     
          Account a = new Account(Name='Acme',BillingCity='San Francisco');
          System.assertEquals('Acme', a.Name);
         insert a; 
         Id acctID = a.id;
          
         List<Account> AccList = [select id,Name from Account where Name != null];
          
         Contact con = new Contact(FirstName='Joe',LastName='Smith',email='test14@gmail.com', AccountId = acctID);
         System.assertEquals('Joe', con.FirstName);
         insert con;
          
          Reachable_Scoring__c Insert_Reach_Score =  new Reachable_Scoring__c();
          Insert_Reach_Score.Person_ID__c ='sdfsdf45';
          Insert_Reach_Score.ContactID__c =con.id;
          Insert_Reach_Score.AccountID__c=a.id;
          Insert_Reach_Score.Person_Score__c = '72';
          Insert_Reach_Score.UserID__c=uidis.id;
          
          System.assertEquals('sdfsdf45', Insert_Reach_Score.Person_ID__c);
          
          insert Insert_Reach_Score;
          
          RS_get_reachable_score_batch_Accounts b1 = new RS_get_reachable_score_batch_Accounts(); 
          Database.BatchableContext BC1; 
          
          b1.start(BC1);
          b1.execute(BC1,AccList);
          Test.stopTest();
        //  b1.Finish(BC1);
      }
     
   
    
}