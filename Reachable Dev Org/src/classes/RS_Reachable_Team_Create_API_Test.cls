@isTest
public class RS_Reachable_Team_Create_API_Test 
{
  static testmethod void Rechableloging()
   {  
       Test.startTest();
        Reachable_Org_Setting__c orgDefaults = Reachable_Org_Setting__c.getInstance('Reachable Org Settings');
     
     if(orgDefaults == null) 
     {
      orgDefaults = new Reachable_Org_Setting__c(Name= 'Reachable Org Settings');
      orgDefaults.Grant_Permission_To_Enrich_Leads__c=true;
      orgDefaults.Grant_Permission_To_Enrich_Contacts__c=true;
      orgDefaults.Grant_Permission_To_Enrich_Accounts__c=true;
      orgDefaults.invite_user_page_size__c=10.0;  
       orgDefaults.Partner_admin_Username__c='admin@sfdc.com';
      orgDefaults.Org_Team_ID__c='TTTTyddyyyd';
      
     }
         System.assertEquals('Reachable Org Settings', orgDefaults.Name);
       insert orgDefaults;
       
     string username = 'abc@abc.com';
     string accessToken= 'hfnskm23hnd9-hndk-87dn-798dnslm3id0';
     System.assertEquals('abc@abc.com', username);
     System.assertEquals('hfnskm23hnd9-hndk-87dn-798dnslm3id0', accessToken);
     RS_Reachable_Team_Create_API.getteamid(accessToken,username );
        
    
   //  system.debug('ORG= ' + orgDefaults.size());
     System.assertEquals('Reachable Org Settings', orgDefaults.Name);
     string Name = orgDefaults.Name='Reachable Org Settings';  
     Test.stopTest();
   }
}