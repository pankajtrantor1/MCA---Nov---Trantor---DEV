@isTest 
class RS_ReachableTabController_Test
{
   public static apexpages.standardController controller;     
   static testMethod void Leadinformations()
   { 
     Test.startTest();
      //Profile p = [SELECT Id FROM Profile WHERE Name='Standard User']; 
     Profile p = [SELECT Id FROM Profile WHERE Name='System Administrator']; 
      User u = new User(Alias = 'sasdndt', Email='standardusertesta1@testorg.com',EmailEncodingKey='UTF-8', 
                        LastName='Tasding', LanguageLocaleKey='en_US',LocaleSidKey='en_US', ProfileId = p.Id,
                        TimeZoneSidKey='America/Los_Angeles', UserName='standardusertest2@testorg.com');
     System.assertEquals('Tasding', u.LastName);
      insert u;
      system.runAs(u)
       {
          Lead leadrec= new Lead(FirstName='smith',LastName='jhon',Company='trantor',Status ='Open');
          System.assertEquals('smith', leadrec.FirstName);
          Insert leadrec;
           
          List<Reachable_User_Setting__c> lstLead = new List<Reachable_User_Setting__c>();
          lstLead.add(new Reachable_User_Setting__c(Reachable_Username__c = 'standardusertest2@testorg.com',Reachable_Access_Token__c = '89GUiH7Fhbi3A7cAbslWyFwx43Rfk9FA8Gy4S5Ddu3bQbkDD7yxs4nqaRFtmfe6A',sf_username__c = 'standardusertest2@testorg.com', ownerid= u.id));
          System.assertEquals('standardusertest2@testorg.com', lstLead[0].Reachable_Username__c);
          insert lstLead;
           
          List<Reachable_Scoring__c> RScoring = new  List<Reachable_Scoring__c>();
          RScoring.add(new Reachable_Scoring__c(LeadID__c = leadrec.id ,Company_Score__c = '34', Person_Score__c = '35',Company_ID__c = '3cx1435xz',Person_ID__c = '2xc1c1c351x'));  
          System.assertEquals('34', RScoring[0].Company_Score__c);
          insert RScoring;
           
           pageReference pg = Page.RS_ReachableTab;
           pg.getParameters().put('id', leadrec.id);
           test.setCurrentPage(pg);
           
           RS_ReachableTabController obj = new RS_ReachableTabController();
           obj.CompnyProfile = '';
           obj.reachscore1 = new List<Reachable_Scoring__c>();
           obj.ReachableEnrichedPersonID = '';
           obj.ReachableEnrichedCompanyID = '';
           obj.leadval = new List<Lead>();
          // obj.allscorevalue = new List<Reachable_Scoring__c>();
           obj.Companyprofile();
           obj.Comapanypath();
           obj.Personpath();
           obj.Personprofile();
           //obj.refreshpage();
           obj.username = 'abc@test.com';
           obj.password = 'password';
           obj.PersnProfile = 'ABC';
           obj.CompnyPath = 'ABC';
           obj.PersnPath = 'ABC';
           obj.isIframe = true;
//           obj.Login();
           RS_ReachableTabController obj1 = new RS_ReachableTabController(); 
           
//           obj1.UserNameID();
           obj1.convertId('4fdf45d');

           
 //          obj1.Login();
           
           RS_ReachableTabController obj2 = new RS_ReachableTabController();       
//           obj2.UserNameID();
           obj2.convertId('4fdf45d');
           obj2.username = '';
           obj2.password = 'password';
           
//           obj2.Login();
           
           RS_ReachableTabController obj3 = new RS_ReachableTabController();       
//           obj3.UserNameID();
           obj3.convertId('4fdf45d');
           obj3.username = '';
           obj3.password = '';
           
            Profile p1 = [SELECT Id FROM Profile WHERE Name='Standard User']; 
        User usr1 = new User(Alias = 'sasdndt', Email='standardusertesta1@testorg.com',EmailEncodingKey='UTF-8', 
                            LastName='Tasding', LanguageLocaleKey='en_US',LocaleSidKey='en_US', ProfileId = p.Id, 
                            TimeZoneSidKey='America/Los_Angeles', UserName='standardusertest22@testorg.com');
        System.assertEquals('Tasding', usr1.LastName);
        User usr2 = new User(Alias = 'sasdndt1', Email='standardusertesta11@testorg.com',EmailEncodingKey='UTF-8', 
                            LastName='Tasding1', LanguageLocaleKey='en_US',LocaleSidKey='en_US', ProfileId = p1.Id, 
                            TimeZoneSidKey='America/Los_Angeles', UserName='standardusertest21@testorg.com');
        System.assertEquals('Tasding1', usr2.LastName);                    
                            
        insert usr1;
        insert usr2;        
         
       Reachable_User_Setting__c rus_rec1= new Reachable_User_Setting__c(Reachable_Access_Token__c = '5t5VJJXD2xQ6nIkKq9CmWN/v/gy1SHNVCqjd9Vv2JqIIkM37Givf3IGcMtTwP4yj',Reachable_Username__c = 'test1@reachable.com',SF_Username__c = 'abc1@sfdc.com',ownerid = usr1.id);
       System.assertEquals('test1@reachable.com', rus_rec1.Reachable_Username__c);  
       Reachable_User_Setting__c rus_rec2= new Reachable_User_Setting__c(Reachable_Access_Token__c = 'vKB4pGEhidf0FsyKhb8KjHM2xcuq7vvaszkn1nY88C1enmP/XNLdTNhmMyBQeDGK',Reachable_Username__c = 'test2@reachable.com',SF_Username__c = 'abc2@sfdc.com',ownerid = usr2.id);
       System.assertEquals('test2@reachable.com', rus_rec2.Reachable_Username__c); 
        insert rus_rec1;
        insert rus_rec2;
           
//           obj3.Login();             
      }
          Test.stopTest();
   }
}