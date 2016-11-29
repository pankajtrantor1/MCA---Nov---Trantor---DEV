@isTest 
class RS_Leadinformation_Test
{
   public static apexpages.standardController controller;     
   static testMethod void Leadinformations()
   { 
      Test.startTest();
      Profile p = [SELECT Id FROM Profile WHERE Name='Standard User']; 
     // Profile p = [SELECT Id FROM Profile WHERE Name='System Administrator']; 
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
           
           pageReference pg = Page.RS_Lead_Score_fields;
           pg.getParameters().put('id', leadrec.id);
           test.setCurrentPage(pg);
           
           RS_Leadinformation obj = new RS_Leadinformation();
           obj.CompnyProfile = '';
           obj.reachscore1 = new List<Reachable_Scoring__c>();
           obj.ReachableEnrichedPersonID = '';
           obj.ReachableEnrichedCompanyID = '';
           obj.leadval = new List<Lead>();
           obj.allscorevalue = new List<Reachable_Scoring__c>();
           obj.Companyprofile();
           obj.Comapanypath();
           obj.Personpath();
           obj.Personprofile();
           obj.refreshpage();
           obj.username = 'abc@test.com';
           obj.password = 'password';
           obj.PersnProfile = 'ABC';
           obj.CompnyPath = 'ABC';
           obj.PersnPath = 'ABC';
           obj.isIframe = true;
           obj.Login();
           RS_Leadinformation obj1 = new RS_Leadinformation(controller); 
           
           obj1.UserNameID();
           obj1.convertId('4fdf45d');
           obj1.username = 'abc@test.com';
           obj1.password = '';
           
           obj1.Login();
           
           RS_Leadinformation obj2 = new RS_Leadinformation(controller);       
           obj2.UserNameID();
           obj2.convertId('4fdf45d');
           obj2.username = '';
           obj2.password = 'password';
           
           obj2.Login();
           
           RS_Leadinformation obj3 = new RS_Leadinformation(controller);       
           obj3.UserNameID();
           obj3.convertId('4fdf45d');
           obj3.username = '';
           obj3.password = '';
           
           obj3.Login();             
      }
         Test.stopTest();
   }
}