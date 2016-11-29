public with sharing class RS_admin_lead_enrich_controller 
{
    public Boolean Enrich_Contact { get; set; }
    public Boolean Enrich_Account { get; set; }
    public Boolean Enrich_Lead    { get; set; }
    
   public RS_admin_lead_enrich_controller()
   {   
        Reachable_Org_Setting__c orgDefaults = Reachable_Org_Setting__c.getInstance('Reachable Org Setting');
               
        system.debug('Enrich My Leads Checkbox has been Selected.');
        if(orgDefaults.Grant_Permission_To_Enrich_Leads__c)
        {
        Enrich_Lead =true;
        }
        if(orgDefaults.Grant_Permission_To_Enrich_Contacts__c){
        Enrich_Contact =true;
        }
        if(orgDefaults.Grant_Permission_To_Enrich_Accounts__c){
        Enrich_Account=true;
        }
         
   }
   
   public PageReference Finish()
    {
      if(Enrich_Lead)
      {
          Reachable_Org_Setting__c orgDefaults = Reachable_Org_Setting__c.getInstance('Reachable Org Setting');
               
          system.debug('Enrich My Leads Checkbox has been Selected.');
          if(Schema.sObjectType.Reachable_Org_Setting__c.fields.Grant_Permission_To_Enrich_Leads__c.isAccessible()) 
           {   
               if(Schema.sObjectType.Reachable_Org_Setting__c.fields.Grant_Permission_To_Enrich_Leads__c.isUpdateable()) 
               {
                 orgDefaults.Grant_Permission_To_Enrich_Leads__c= true;
                 update orgDefaults;
               }
           }        
          else
           {
             ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL,'Insufficient access to update status'));          
             return null;
           } 
          
          RS_lead_batch_manager.runbatch();
          ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO,'Lead Score Batch has started successfully.'));
          ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO,'Partner Onboarding Process Completed.'));
      }
      else{
         ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Info,'You have decided not to Score Leads at this time , you can revisit this page in future when you decide to score your leads'));
                 
      }
        return null;
    }
      
      
    public PageReference Finish_Contact()
    {   
       if(Enrich_Contact)
      {
          Reachable_Org_Setting__c orgDefaults = Reachable_Org_Setting__c.getInstance('Reachable Org Setting');
          
           if(Schema.sObjectType.Reachable_Org_Setting__c.fields.Grant_Permission_To_Enrich_Contacts__c .isAccessible()) 
           { 
              if(Schema.sObjectType.Reachable_Org_Setting__c.fields.Grant_Permission_To_Enrich_Contacts__c.isUpdateable()) 
               {  
                 system.debug('Enrich My Contacts Checkbox has been Selected.');
                 orgDefaults.Grant_Permission_To_Enrich_Contacts__c = true;
                 update orgDefaults;
               }
            }  
           else
           {
             ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL,'Insufficient access'));          
            return null;
           }
          RS_Contact_batch_manager.runbatch();
          ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO,'Contact Score Batch has started successfully.'));
      }
      else{
        
         ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Info,'You have decided not to Score Contacts at this time , you can revisit this page in future when you decide to score your Contacts'));
                 
      }
         return null;
    }
      
      
    public PageReference Finish_Account()
    {    
      if(Enrich_Account)
      {
           Reachable_Org_Setting__c orgDefaults = Reachable_Org_Setting__c.getInstance('Reachable Org Setting');
           
           if(Schema.sObjectType.Reachable_Org_Setting__c.fields.Grant_Permission_To_Enrich_Accounts__c.isAccessible()) 
           { 
              if(Schema.sObjectType.Reachable_Org_Setting__c.fields.Grant_Permission_To_Enrich_Accounts__c.isUpdateable()) 
              {  
                system.debug('Enrich My Accounts Checkbox has been Selected.');
                orgDefaults.Grant_Permission_To_Enrich_Accounts__c = true;
                update orgDefaults;
              }
            } 
          else
             {
               ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL,'Insufficient access'));          
               return null;
             } 
             RS_Account_batch_manager.runbatch();
             ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO,'Account Score Batch has started successfully.'));
      }
      else{
         ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Info,'You have decided not to Score Accounts at this time , you can revisit this page in future when you decide to score your Accounts'));
                 
         }
                return null;
     
    }       
    
      public PageReference scheduleDailyBatch()
    {
      
     PageReference pagref= new PageReference ('/ui/setup/apex/batch/ScheduleBatchApexPage');
     return pagref;
     
    }   
    
}