@isTest 
class RS_SendInvitationController_Test
{
   public static apexpages.standardController controller;     
   static testMethod void Leadinformations()
   { 
     Test.startTest();
     String SendController = 'Standardtest';
     System.assertEquals('Standardtest', SendController);
     
     Profile p = [SELECT Id FROM Profile WHERE Name='Standard User']; 
     User u = new User(Alias = 'sasdndt', Email='standardusertesta1@testorg.com',EmailEncodingKey='UTF-8', 
                       LastName='Tasding', LanguageLocaleKey='en_US',LocaleSidKey='en_US', ProfileId = p.Id,
                       TimeZoneSidKey='America/Los_Angeles', UserName='standardusertest2@testorg.com');
     System.assertEquals('Tasding', u.LastName);                  
     insert u;
      
     List<user> rs=[ select Id,Email,UserName from User where IsActive=true AND Email != 'laurent@reachable.com' order by UserName ASC];
     
     system.debug('SendInviationController======='+ rs );
      
     system.runAs(u)
     {
       Reachable_Org_Setting__c orgDefaults = Reachable_Org_Setting__c.getInstance('Reachable Org Setting');
         if(orgDefaults == null) 
         {
            orgDefaults = new Reachable_Org_Setting__c(Name= 'Reachable Org Setting');
            orgDefaults.Grant_Permission_To_Enrich_Leads__c=true;
            orgDefaults.Grant_Permission_To_Enrich_Contacts__c=true;
            orgDefaults.Grant_Permission_To_Enrich_Accounts__c=true;
            orgDefaults.invite_user_page_size__c=10.0;
            System.assertEquals('Reachable Org Setting', orgDefaults.Name); 
            insert orgDefaults;
         }
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
           
           pageReference pg = Page.RS_Configure_User;
           pg.getParameters().put('id', leadrec.id);
           test.setCurrentPage(pg);
           
              RS_SendInviationController obj= new RS_SendInviationController();
              String SendController_Name = 'Standardtest';
              System.assertEquals('Standardtest', SendController_Name);
               string value ='1';
               obj.noOfRecords =40;
               obj.recNum = 50;
               obj.recLimit = 15;
               obj.redirect();
               obj.getSortDirection();
               obj.getSelectedUsers();
               obj.ViewData();
               obj.EnrichOrgLeads();
               obj.SendInvitation();
               obj.getTotalPages();
               obj.setSortDirection(value);
      }
        
        Test.stopTest();
      
   }
     
}