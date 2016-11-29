@isTest
public class RS_Reachable_Org_Setting_Test
{   
    static testMethod void ScoreCal()
    {  
       Test.startTest();
       RS_Reachable_Org_Setting reachobj = new RS_Reachable_Org_Setting();
       InstallContext context;
       reachobj.onInstall(context);
       Reachable_Org_Setting__c orgDefaults = Reachable_Org_Setting__c.getInstance('Reachable Org Setting');
       System.assertEquals(25,orgDefaults.invite_user_page_size__c);
       Test.stopTest();
     } 
      
    
}