public with sharing class RS_ReachableTabController 
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
          List<Reachable_Scoring__c> allscorevalue {get;set;}
          //String accessToken;
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
          boolean recinsert = false;
          boolean teamcreate = false;
          boolean createteam = false;
          List<user> getallemailv {get;set;}
          public  boolean isIframe {get; set;}
          
          
          Reachable_User_Setting__c user_record;
          boolean loginpagedirect = false;
          PageReference pageRef;
         

        public RS_ReachableTabController()
        {
         //     UserNameID();

                  try
                     {
                         user_record = [Select ID,Reachable_Access_Token__c from Reachable_User_Setting__c where ownerID =:UserInfo.getUserId()];
                         system.debug('user_record '+user_record );
                         if(user_record.Reachable_Access_Token__c == null)
                         {
                           loginpagedirect = true; 
                         }
                     }
                     catch(Exception e)
                     {
                         system.debug('User record in reachable user setting is not defined:' + e);
                         system.debug(user_record);
                         loginpagedirect = true;
                     }
           
          }
          
         public PageReference redirectuser()
         {
            system.debug('loginpagedirect value in redirectuser method:'+loginpagedirect);
            if(loginpagedirect)
            {
                pageRef = Page.RS_ReachableTabLoginPage;
                return pageRef;
            }
            else
            {
                
                reachableDecryptedAccessToken= RS_encryption_handler.decrypt(user_record.Reachable_Access_Token__c);
                system.debug('reachableDecryptedAccessToken'+reachableDecryptedAccessToken); 
            }
            return null;
         }
          
                       
           public string CompnyProfile 
           {
           get
           {
             return CompnyProfile;              
           }
           set
           {
       //       CompnyProfile ='https://app3.reachable.com/#/results/company/' + reachscore.Company_ID__c;             
           }
          }
          
          public string PersnProfile {get;set;}
          public string CompnyPath {get;set;}
          public string PersnPath {get;set;}
          public Boolean showSection1 {get;set;}
          public Boolean showSection2 {get;set;}
          public Boolean showSection3 {get;set;}
          public Boolean showSection4 {get;set;}
          
          
          
         
 /*            public void UserNameID()
            {
       
                 
       
              string ntest=UserInfo.getUserName();
              system.debug('Nametest=='+ ntest);
             List<Reachable_User_Setting__c> rusList=[Select Reachable_Access_Token__c from Reachable_User_Setting__c where sf_username__c=:UserInfo.getUserName() LIMIT 1]; //Get User Reachable Access Token
             system.debug('ReachableAccessToken'+ReachableAccessToken); 
             if(!rusList.isempty()){
             if(rusList[0].Reachable_Access_Token__c != null)
                 {
                 
                 reachableDecryptedAccessToken= RS_encryption_handler.decrypt(rusList[0].Reachable_Access_Token__c);
                  token_exist=true;
                  
                 
                 }
                 
                 
             } 
             else token_exist =false;
          } */
          
          
      
         
         
         public String convertId(String inputId){
        string suffix = '';
        integer flags;
        try{
            for (integer i = 0; i < 3; i++) {
                flags = 0;
                for (integer j = 0; j < 5; j++) {
                    string c = inputId.substring(i * 5 + j,i * 5 + j + 1);
                    if (c.toUpperCase().equals(c) && c >= 'A' && c <= 'Z') {
                        flags = flags + (1 << j);
                    }
                }
                if (flags <= 25) {
                    suffix += 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'.substring(flags,flags+1);
                }else{
                    suffix += '012345'.substring(flags - 26, flags-25);
                }
            }
        }
        catch(Exception exc){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Please enter Valid 15 digit Id'));
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
         
        
}