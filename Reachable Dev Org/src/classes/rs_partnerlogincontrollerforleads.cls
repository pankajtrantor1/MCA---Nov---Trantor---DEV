public with sharing class rs_partnerlogincontrollerforleads 
{

          public List<Lead> currentleadid;
          public ID leadidpage{get;set;}
          public ApexPages.StandardController controller {get; set;}
          public lead l;
         // Public Reachable_Scoring__c reachscore {get;set;}
          Public Reachable_User_Setting__c ReachableAccessToken {get;set;}
          public boolean token_exist {get;set;}
       //   Public List<Lead> leadval{get;set;}
          List<Reachable_Scoring__c> allscorevalue {get;set;}
          //String accessToken;
         // ID Leadid;
         // ID Userid;
         // User reachableUsername;
          public string getidofthecurrent{get;set;}
          public string getcoid{get;set;}
          public String password { get; set; }
          public String username { get; set; }
          String accessToken;
          String error;
       //   String reachable_team_id;
          PageReference pf;
          Id currentid; 
         public boolean recinsert = false;
         public boolean teamcreate = false;
          boolean createteam = false;
          List<user> getallemailv {get;set;}
          

           public rs_partnerlogincontrollerforleads(ApexPages.StandardController controller) 
           {
             
           //   this.controller = controller;
          //    this.l = (Lead)controller.getRecord();
          //   system.debug('@@@lead==' +l.id);
              leadidpage= (ID) controller.getRecord().get('id');
             
              if(ApexPages.currentPage().getParameters().get('id') == null) 
              { 
              
                 currentleadid = [select id from Lead where id = :ApexPages.currentPage().getParameters().get('id')];      
                 system.debug('currentleadid=='+ currentleadid);
              
              }
            }



           public  rs_partnerlogincontrollerforleads()
           {              
              try
              {
                 getidofthecurrent = ApexPages.currentPage().getParameters().get('id');
                 system.debug('cid1='+ getidofthecurrent);
              }
             catch(Exception e)
              {
                 system.debug('User record in reachable user setting is not defined:' + e);
              }
           }
                   
                   

          ID CurrentUserId= UserInfo.getUserId();
          USER usr = [SELECT ID,username FROM User WHERE Id = :UserInfo.getUserId()];
    
            public PageReference refresh()
            {
                if(getidofthecurrent==null)
                {                          
                 getcoid = ApexPages.currentPage().getParameters().get('id');
                  system.debug('this is id ==' +getcoid);
                }
                else
                {
                  system.debug('id is already get ==' + getidofthecurrent);
                }
                 return null;
            }      
            
            
     
        public PageReference Login() 
        { 
              

// ************** Input Validations ******************************

//    Check if username & password are not empty - working fine   
        
        if(username == '' && password == '')
        {
         ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Username or password is empty, Please enter your credentials to login.'));
        }   
        
      if(username != '' && password == '')
        {
         ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Password is empty, Please enter your credentials to login.'));
        }    
        
        if(username == '' && password != '')
        {
         ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Username is empty, Please enter your credentials to login.'));
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
            //   pf = null;
               ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Username or password is incorrect, Please try again to login.'));   
           }
                  

//    If accessToken is not null then store the accessToken in custom settings.

           if (accessToken != 'null')
           {
             try
             {
                 Reachable_User_Setting__c reachset = [Select ID,Reachable_Username__c,SF_Username__c,Reachable_Access_Token__c from Reachable_User_Setting__c where ownerid = :UserInfo.getUserID() limit 1];
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
               if(recinsert == true)
               {  
                   if(!Schema.sObjectType.Reachable_User_Setting__c.fields.Reachable_Username__c.isAccessible()) 
                  {
                   ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, 'Insufficient access'));
                        return null;
                   }     
                    if(!Schema.sObjectType.Reachable_User_Setting__c.fields.Reachable_Username__c.isCreateable()) 
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
                    if(!Schema.sObjectType.Reachable_User_Setting__c.fields.SF_Username__c.isCreateable()) 
                     {
                        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, 'Insufficient access to update status'));
                        return null;
                     }
                 newreachset.SF_Username__c = usr.username;
                 String accessTokenvalue = RS_encryption_handler.encrypt(accessToken);
                  if(!Schema.sObjectType.Reachable_User_Setting__c.fields.Reachable_Access_Token__c.isAccessible()) 
                  {
                   ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, 'Insufficient access'));
                        return null;
                   }    
                        
                    if(!Schema.sObjectType.Reachable_User_Setting__c.fields.Reachable_Access_Token__c.isCreateable()) 
                     {
                        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, 'Insufficient access to update status'));
                        return null;
                     }
                 
                   newreachset.Reachable_Access_Token__c = accessTokenvalue;
                    if(!Schema.sObjectType.Reachable_User_Setting__c.fields.OwnerID.isAccessible()) 
                  {
                     ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, 'Insufficient access'));
                        return null;
                    }    
                    if(!Schema.sObjectType.Reachable_User_Setting__c.fields.OwnerID.isCreateable()) 
                     {
                        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, 'Insufficient access to update status'));
                        return null;
                     }
                 
                 newreachset.OwnerID = UserInfo.getUserId();
                 try
                 {
                     if(!Schema.sObjectType.Reachable_User_Setting__c.isAccessible()) 
                  {
                   ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, 'Insufficient access'));
                        return null;
                   }     
                    if(!Schema.sObjectType.Reachable_User_Setting__c.isCreateable()) 
                     {
                        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, 'Insufficient access to update status'));
                        return null;
                     }
                     insert newreachset;
                     
                     
                     system.debug('leadidpage:'+ leadidpage);
                    // pf = Page.RS_Configure_User;
                     pf =  new PageReference('/'+leadidpage);
                     system.debug('pf='+ pf);
                 }
                 catch(DmlException insertexp)
                 {
                     system.debug('This is the exception happened while inserting new record:' + insertexp);
                 }
                }
                if(recinsert == false && accessToken != 'null')
                {
                 Reachable_User_Setting__c updaterec = [Select ID,Reachable_Username__c,SF_Username__c,Reachable_Access_Token__c from Reachable_User_Setting__c where ownerID = :UserInfo.getUserId() limit 1];
                 String accessTokenvalue =RS_encryption_handler.encrypt(accessToken);
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
                 try
                 {
                     if(!Schema.sObjectType.Reachable_User_Setting__c.isAccessible())
                       {
                         ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL,'Insufficient access'));
                         return null;  
                       }
                       if(!Schema.sObjectType.Reachable_User_Setting__c.isUpdateable())
                       {
                         ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL,'Insufficient access to update status'));
                         return null;
                       }
                   
                     update updaterec;
              //  pf = ('https://ap2.salesforce.com/'+ currentid);
                     teamcreate = false;
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