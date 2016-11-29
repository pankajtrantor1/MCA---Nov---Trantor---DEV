@isTest
public class RS_Admin_Lead_Enrich_Controller_test 
{
  static testMethod void testcontroller()
  {
     Test.startTest();
     Reachable_Org_Setting__c orgDefaults = Reachable_Org_Setting__c.getInstance('Reachable Org Setting');
     if(orgDefaults == null) 
     {
        orgDefaults = new Reachable_Org_Setting__c(Name= 'Reachable Org Setting');
        orgDefaults.Grant_Permission_To_Enrich_Leads__c=true;
        orgDefaults.Grant_Permission_To_Enrich_Contacts__c=true;
        orgDefaults.Grant_Permission_To_Enrich_Accounts__c=true;
        System.assertEquals('Reachable Org Setting', orgDefaults.Name); 
        insert orgDefaults;
    }
      RS_admin_lead_enrich_controller obj = new RS_admin_lead_enrich_controller();

      obj.Finish();
      obj.Finish_Contact();
      obj.Finish_Account();
      obj.scheduleDailyBatch();
      Test.stopTest();
  }
  
}