public with sharing class RS_Leadinformation
{
    Public Reachable_Scoring__c reachscore {get;set;}
    public List<Reachable_Scoring__c> reachscore1{get;set;}
    public List<Reachable_Scoring__c> ReachableEnrichedScore{get;set;}
    public string ReachableEnrichedPersonID{get;set;}
    public string ReachableEnrichedCompanyID{get;set;}
    public string reachableDecryptedAccessToken{get;set;}
    Public Reachable_User_Setting__c ReachableAccessToken {get;set;}
    public boolean token_exist {get;set;}
    Public List<Lead> leadval{get;set;}
    public List<Reachable_Scoring__c> allscorevalue {get;set;}
    public boolean validatepersoncompanyscore {get;set;}
    
    ID Leadid;
    ID Userid;
    User reachableUsername;
    public string getidofthecurrent{get;set;}
    public String password { get; set; }
    public String username { get; set; }
    String accessToken;
    String error;
    String reachable_team_id;
    PageReference pf;
    Id currentid; 
   public boolean recinsert = false;
    boolean teamcreate = false;
    boolean createteam = false;
    List<user> getallemailv {get;set;}
    public  boolean isIframe {get; set;}
    
    public boolean showpanel {get;set;}
         
    public   RS_Leadinformation()
    {
     currentid = ApexPages.currentPage().getParameters().get('id');
     system.debug('cid='+ currentid);
    }
                       
    public string CompnyProfile 
    {
     get{return CompnyProfile;}
       set{}
    }
          
    public string PersnProfile {get;set;}
    public string CompnyPath {get;set;}
    public string PersnPath {get;set;}
    public Boolean showSection1 {get;set;}
    public Boolean showSection2 {get;set;}
    public Boolean showSection3 {get;set;}
    public Boolean showSection4 {get;set;}
    
    Public RS_Leadinformation (ApexPages.StandardController controller) 
    {
        showSection1= true;
        showSection2= false;
        showSection3 = false;
        showSection4 = false;
        string leadid;          
        
        leadid = ApexPages.currentPage().getParameters().get('id');
        system.debug('=='+leadid);
        getidofthecurrent = leadid; 
        system.debug('++++' + reachscore);  
        UserNameID();
    }
          
    public PageReference refreshpage()
    {     
      PageReference pageRef = new PageReference('/' + getidofthecurrent);
      system.debug(pageRef);
       return pageRef;
    }  
          
    public void UserNameID()
    {
        string ntest=UserInfo.getUserName();
        system.debug('Nametest=='+ ntest);
        List<Reachable_User_Setting__c> rusList=[Select Reachable_Access_Token__c from Reachable_User_Setting__c where sf_username__c=:UserInfo.getUserName() LIMIT 1]; //Get User Reachable Access Token
        system.debug('ReachableAccessToken'+ReachableAccessToken); 
        if(!rusList.isempty())
        {
            if(rusList[0].Reachable_Access_Token__c != null)
                {
                 
                    reachableDecryptedAccessToken= RS_encryption_handler.decrypt(rusList[0].Reachable_Access_Token__c);
                    token_exist=true;
                    string UnEnrichedleadid =ApexPages.currentPage().getParameters().get('id');
                    string Enrichedleadid= convertId(UnEnrichedleadid);
                 
                    ReachableEnrichedScore = [select ID,LeadID__c,Company_Score__c,
                    Person_Score__c,Company_ID__c,Person_ID__c from Reachable_Scoring__c where LeadID__c = :Enrichedleadid];
                    if(!ReachableEnrichedScore.isempty())
                    {
                        validatepersoncompanyscore =false;
                        
                        if(ReachableEnrichedScore[0].Person_ID__c!= null)
                        {
                            showpanel = true;
                            ReachableEnrichedPersonID=ReachableEnrichedScore[0].Person_ID__c;
                        }
                        if(ReachableEnrichedScore[0].Company_ID__c!= null)
                        {
                            showpanel = true;
                            ReachableEnrichedCompanyID=ReachableEnrichedScore[0].Company_ID__c;
                        }
                        
                        if(ReachableEnrichedCompanyID=='0' && ReachableEnrichedPersonID=='0')
                        {
                         showpanel = false;
                         ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO,'Could not match to a person or a company in Reachable.'));
                        }
                        
                    }
                    else
                    {
                     validatepersoncompanyscore = true;
                     ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Warning,'This record has not been processed by Reachable.'));
                    }
                 
                }
                     
                     
        } 
        else 
        {
            token_exist =false;
        }
    }
         
         
         
    public String convertId(String inputId)
    {
        string suffix = '';
        integer flags;
        try
        {
            for (integer i = 0; i < 3; i++) 
            {
                flags = 0;
                for (integer j = 0; j < 5; j++) 
                {
                    string c = inputId.substring(i * 5 + j,i * 5 + j + 1);
                    if (c.toUpperCase().equals(c) && c >= 'A' && c <= 'Z') 
                    {
                        flags = flags + (1 << j);
                    }
                }
                if (flags <= 25) 
                {
                    suffix += 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'.substring(flags,flags+1);
                }
                else
                {
                    suffix += '012345'.substring(flags - 26, flags-25);
                }
            }
        }
        catch(Exception exc)
        {
            // ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Please enter Valid 15 digit Id'));
        }
        String outputId = inputId+suffix;
        return outputId;
    }
     
    public PageReference Companyprofile() 
    {
       showSection1= true;
       showSection2= false;
       showSection3 = false;
       showSection4 = false;
       return null;
    }
            
    public PageReference Personprofile() 
    {
       showSection1= false;
       showSection2= true;
       showSection3 = false;
       showSection4 = false;
       return null;
    }
    
    public PageReference Comapanypath() 
    {
       showSection1= false;
       showSection2= false;
       showSection3 = true;
       showSection4 = false;
       return null;
    }

    public PageReference Personpath() 
    {
       showSection1= false;
       showSection2= false;
       showSection3 = false;
       showSection4 = true;
       return null;
    }
     
    ID CurrentUserId= UserInfo.getUserId();
    USER usr = [SELECT ID,username FROM User WHERE Id = :UserInfo.getUserId()];
    
     
    public PageReference Login() 
    {
        if(username == '' || password == '')
        {
         ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Username or password is empty, Please enter your credentials to login.'));
        }    

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

           if(accessToken == 'null' || accessToken == '' || accessToken == null)
           {
               system.debug('Access token is null or empty.');
               pf = null;
               ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Username or password is incorrect, Please try again to login.'));   
           }

           if (accessToken != 'null')
            {
                try
                {
                    Reachable_User_Setting__c reachset = [Select ID,Reachable_Username__c,SF_Username__c,Reachable_Access_Token__c from Reachable_User_Setting__c limit 1];
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
                         Reachable_User_Setting__c newreachset = new Reachable_User_Setting__c();
                         newreachset.Reachable_Username__c = username;
                         newreachset.SF_Username__c = usr.username;
                         String accessTokenvalue = RS_encryption_handler.encrypt(accessToken);
                         newreachset.Reachable_Access_Token__c = accessTokenvalue;
                         newreachset.OwnerID = UserInfo.getUserId();
                        try
                        {
                            insert newreachset;
                            system.debug('newreachset:'+newreachset);
                            pf =  new PageReference('/'+currentid);
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
                        String accessTokenvalue = RS_encryption_handler.encrypt(accessToken);
                        updaterec.Reachable_Access_Token__c= accessTokenvalue;
                        try
                        {
                            update updaterec;
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