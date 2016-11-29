public with sharing class RS_Reachable_Org_Setting implements InstallHandler
 {
  public void onInstall(InstallContext context)
  {
   List<Reachable_Org_Setting__c> reachscor = new List<Reachable_Org_Setting__c>();   
   Reachable_Org_Setting__c addreachscore = new Reachable_Org_Setting__c();
   {   
     if(Schema.sObjectType.Reachable_Org_Setting__c.fields.Name.isAccessible() && Schema.sObjectType.Reachable_Org_Setting__c.fields.Name.isCreateable())
     {
       addreachscore.Name = 'Reachable Org Setting';
     }
     
     if(Schema.sObjectType.Reachable_Org_Setting__c.fields.invite_user_page_size__c.isAccessible() && Schema.sObjectType.Reachable_Org_Setting__c.fields.invite_user_page_size__c.isCreateable())
     {
       addreachscore.invite_user_page_size__c = 25;
     }
      
      reachscor.add(addreachscore);
 
  insert reachscor; 
   }
   }
  }