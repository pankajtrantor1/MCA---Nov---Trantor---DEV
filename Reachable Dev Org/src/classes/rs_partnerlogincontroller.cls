public with sharing class rs_partnerlogincontroller 
{

     public  boolean isIframe {get;set;} 
     


    public String password      { get; set; }
    public String username      { get; set; }
    public String forgeturllink { get; set; }
    
    public String accessToken;
    public String error;
    String reachable_team_id;
    PageReference pf;
    public boolean recinsert = false;
    
    public PageReference Login() 
    {
      //pf = Page.RS_Configure_User;
        system.debug('username :'+username);

// ************** Input Validations ******************************

//    Check if username & password are not empty - working fine   
        
        if(username == '' || password == '')
        {
         ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Username or password is empty, Please enter your credentials to login.'));
        }    
        
//    If username and password are not empty then call the class to get accessToken        
        
        if(username!= '' && password != '')
        {
           try
           {
                accessToken = rs_reachablelogin.gettoken(username,password);
                system.debug(accessToken);
           }
           catch(Exception e) 
           {
                error = e.getMessage();
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Unable to login, Please contact administrator:'+ error));            
           }

// ************** Class return Validations ******************************
           
//    Check if the returned accessToken is empty then show incorrect credentials 
 
           if(accessToken == 'null' || accessToken == '' || accessToken == null)
           {
               system.debug('Access token is null or empty.');
               pf = null;
               ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Username or password is incorrect, Please try again to login.'));   
           }
                  

//    If accessToken is not null then store the accessToken in custom settings.

           if (accessToken != 'null')
           {
             try
             {
                 Reachable_User_Setting__c reachset = [Select ID,Reachable_Username__c,SF_Username__c,Reachable_Access_Token__c from Reachable_User_Setting__c where ownerid = :UserInfo.getUserID()];
                 if(reachset.id != null || reachset.id != 'null')
                 {
                   system.debug('Already exist.');
                   recinsert = false;
                 }
             }
             catch(DmlException e)
             { 
                system.debug('DmlException :'+e);
                recinsert = true;
             }
             catch(Exception ee)
             {
                system.debug('Exception:' + ee);
                 recinsert = true;
             }
             finally
             {
               if(recinsert)
               {  
                    if(!Schema.sObjectType.Reachable_User_Setting__c.fields.Reachable_Username__c.isAccessible()) 
                  {
                     ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, 'Insufficient access'));
                        return null;
                        
                   }     
                    if (!Schema.sObjectType.Reachable_User_Setting__c.fields.Reachable_Username__c.isCreateable()) 
                     {
                        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, 'Insufficient access to update status'));
                        return null;
                     }
                 Reachable_User_Setting__c newreachset = new Reachable_User_Setting__c();
                 newreachset.Reachable_Username__c = username;
                   if(!Schema.sObjectType.Reachable_User_Setting__c.fields.SF_Username__c.isAccessible()) 
                  {
                   ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, 'Insufficient access'));
                        return null;
                   }     
                    if (!Schema.sObjectType.Reachable_User_Setting__c.fields.SF_Username__c.isCreateable()) 
                     {
                        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, 'Insufficient access to update status'));
                        return null;
                     }
                 newreachset.SF_Username__c = UserInfo.getUsername();
                 String accessTokenvalue = RS_encryption_handler.encrypt(accessToken);
                   if (!Schema.sObjectType.Reachable_User_Setting__c.fields.Reachable_Access_Token__c.isAccessible()) 
                  {
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, 'Insufficient access'));
                        return null;
                   }     
                    if (!Schema.sObjectType.Reachable_User_Setting__c.fields.Reachable_Access_Token__c.isCreateable()) 
                     {
                        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, 'Insufficient access to update status'));
                        return null;
                     }
                 
                 newreachset.Reachable_Access_Token__c = accessTokenvalue;
                   if (!Schema.sObjectType.Reachable_User_Setting__c.fields.OwnerID.isAccessible()) 
                  {
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, 'Insufficient access'));
                        return null;
                  }      
                    if (!Schema.sObjectType.Reachable_User_Setting__c.fields.OwnerID.isCreateable()) 
                     {
                        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, 'Insufficient access to update status'));
                        return null;
                     }
                 
                 newreachset.OwnerID = UserInfo.getUserId();
                 try
                 {
                     insert newreachset;
                     system.debug('newreachset:'+ newreachset);
                     pf = Page.RS_Configure_User;
                 }
                 catch(DmlException insertexp)
                 {
                     system.debug('This is the exception happened while inserting new record:' + insertexp);
                 }
                }
                if(!recinsert && accessToken != 'null')
                {
                  Reachable_User_Setting__c updaterec;
                try
                 {
                  updaterec = [Select ID,Reachable_Username__c,SF_Username__c,Reachable_Access_Token__c from Reachable_User_Setting__c where ownerID = :UserInfo.getUserId() limit 1];
                  system.debug('------accessToken------'+accessToken);
                 String accessTokenvalue = RS_encryption_handler.encrypt(accessToken);
                if(!Schema.sObjectType.Reachable_User_Setting__c.fields.Reachable_Access_Token__c.isAccessible())
                    {
                       ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL,'Insufficient access'));
                        return null;
                    }
                     if(!Schema.sObjectType.Reachable_User_Setting__c.fields.Reachable_Access_Token__c.isUpdateable())
                     {
                        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL,'Insufficient access to update status'));
                        return null;
                     }
                     updaterec.Reachable_Access_Token__c= accessTokenvalue;

                    if (!Schema.sObjectType.Reachable_User_Setting__c.fields.User_Access_Token__c.isUpdateable())
                    {
                        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL,'Insufficient access to update status'));
                        return null;
                    }
                     update updaterec;
                  //   pf = Page.RS_Configure_User;
                 }
                 catch(DmlException updateexp)
                 {
                     system.debug('This is the exception happened while updating the record:' +updateexp+ 'record id:'+updaterec.ID);
                 }
                }
               }              
           }
        }
        return pf;
      }
      
}