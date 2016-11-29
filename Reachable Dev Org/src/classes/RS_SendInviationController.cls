Public with sharing class RS_SendInviationController
{ 
  public String  displaymessage        { get; set; }
  Public string  selectedField         { get; set; }
  public String  size                  { get; set; }
  Public Integer noOfRecords           { get; set; }
  public Integer recNum                { get; set; }
  public Integer recLimit              { get; set; }
  public Integer reclmt                { get; set; }
  public Integer pages                 { get; set; }
  public Integer pages1                { get; set; }
  public integer valuechk              { get; set; }
  public boolean FirstPage             { get; set; }
  public boolean LastPrevious          { get; set; }  
  public boolean display               { get; set; }
  public boolean displayPopup          { get; set; } 
  public boolean bool                  { get; set; }
  public integer iscountpage = 2;
  public list<User> selectedList       { get; set; } 
  public list<WrapperUser> wrapperlist { get; set; }

   private List<User> Userssortvalues;

  String reachable_team_id;
  String accessToken;
  String Message;  
  String accesstokenval;
  boolean loginpagedirect = false;
  boolean createreachableteam = false;
  boolean inviteteam = false;
  PageReference pg;
  Exception excp;
  
  Set<String> EmailAdd =new Set<String>();
  Set<String> EmailAddress =new Set<String>();  
  Reachable_User_Setting__c user_record;
  Reachable_User_Setting__c user_Rec;
  
   private String sortDirection = 'ASC';
   private String sortExp = 'name';

  Map <id,User> SelectedcontactMap = new Map <id,User>();
  Reachable_Org_Setting__c orgDefaults = Reachable_Org_Setting__c.getInstance('Reachable Org Setting');
  
  Integer record_count = Integer.valueOf(orgDefaults.invite_user_page_size__c);
        
        public Boolean valuechk1
        {   
       get{if (pageNumber == 1) return true;  // true               
           if (pageNumber >= 2) return true; return false;} set;
        }  
 
  
  

  public ApexPages.StandardSetController Setcon
           {
            get
                {
                  if(Setcon == Null)
                    {
                      Setcon = new ApexPages.StandardSetController(Database.getQueryLocator([select Id,Email,UserName from User where IsActive=true AND Email != 'laurent@reachable.com' order by UserName ASC]));     
                      setCon.setpagesize(record_count);      
                      noOfRecords = setCon.getResultSize();      
                      system.debug('noOfRecords===' + noOfRecords);
                    }
                    return Setcon;
                }
            set;
           } 
           
        
           
// instantiate the StandardSetController from a query locator
  public RS_SendInviationController()
    {
         try
         {
             user_record = [Select ID,Reachable_Access_Token__c from Reachable_User_Setting__c where ownerID =:UserInfo.getUserId()];
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
     
    public PageReference redirect()
    {
            if(loginpagedirect)
            {
                PageReference pageRef = new PageReference('/apex/RS_ReachableLoginPage');
                return pageRef;
            }
            else
            {
                //get or create team      
                  
                    if(orgDefaults.Org_Team_ID__c == null)
                    {
                       createreachableteam  = true;     
                    }
                    system.debug('============================'+createreachableteam );
            }
            return null;
    }           
             
                 public void create_team()
                   {
                     user_Rec = [Select Reachable_Access_Token__c,Reachable_Username__c from Reachable_User_Setting__c where ownerID = :UserInfo.getUserId() limit 1];
                     accesstokenval = RS_encryption_handler.decrypt(user_Rec.Reachable_Access_Token__c);
                     reachable_team_id = RS_Reachable_Team_Create_API.getteamid(accesstokenval,user_Rec.Reachable_Username__c);
                     system.debug('reachable_team_id is :'+reachable_team_id);
                     if(reachable_team_id != 'null' || reachable_team_id != null)
                     {
                          if(!Schema.sObjectType.Reachable_Org_Setting__c.fields.Org_Team_ID__c.isAccessible())
                          {
                            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL,'Insufficient access'));
                          }   
                         if(!Schema.sObjectType.Reachable_Org_Setting__c.fields.Org_Team_ID__c.isUpdateable())
                          {
                             ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL,'Insufficient access to update status'));
                          }
                     orgDefaults.Org_Team_ID__c = reachable_team_id; 
                     system.debug(orgDefaults);
                     if(!Schema.sObjectType.Reachable_Org_Setting__c.isAccessible())
                      {
                       ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL,'Insufficient access'));
                      }   
                      if(!Schema.sObjectType.Reachable_Org_Setting__c.isUpdateable())
                      {
                         ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL,'Insufficient access to update status'));
                         
                      }
                         update orgDefaults;
                     }
               }
 
  
    Public List<WrapperUser> getUsers()
     {
          getSelectedUsers();
          wrapperlist = new List <WrapperUser>();
            
          for(User cc : (List<User>)Setcon.getRecords())
          {
           if( SelectedcontactMap .ContainsKey(cc.id))
            {
              wrapperlist.add (new WrapperUser(cc,true));
            }        
            else        
            {        
             wrapperlist.add(new WrapperUser(cc,false));
            }
           }
           return wrapperlist;
     }

      public void getSelectedUsers()
      {
       if(wrapperlist!=null)
       {        
        for(WrapperUser wr:wrapperlist)
        {
         if(wr.bool)
          {
             SelectedcontactMap.put(wr.con.id,wr.con); // Add the selected contact id in to the SelectedcontactMap.
             system.debug('Sel==='+ SelectedcontactMap);
          }
          else
          {
            SelectedcontactMap.remove(wr.con.id); // If you uncheck the contact, remove it from the selectedcontactMap
          }
         }
        }
      }
      
      ////////////////// Sorting Implementation
  
   public String sortExpression
   {
     get
     {
        return sortExp;
     }
     set
     {
       //if the column is clicked on then switch between Ascending and Descending modes
       if (value == sortExp)
         sortDirection = (sortDirection == 'ASC')? 'DESC' : 'ASC';
       else
         sortDirection = 'ASC';
       sortExp = value;
     }
   }
    public String getSortDirection()
 {
    //if not column is selected 
    if (sortExpression == null || sortExpression == '')
      return 'ASC';
    else
     return sortDirection;
 }
 public void setSortDirection(String value)
 {  
   sortDirection = value;
 }
  public List<User> getUser() {
       return Userssortvalues;
   }
  public PageReference ViewData() {
       //build the full sort expression
       string sortFullExp = sortExpression  + ' ' + sortDirection;
      
       //query the database based on the sort expression
       Userssortvalues = Database.query('Select id, UserName,Email from User order by ' + sortFullExp + ' limit 15');
       return null;
   }
  
  
  ///////////////////
      
      
      
       Public class WrapperUser
       {        
          Public User con{get;set;}        
          Public boolean bool{get;set;}        
          public WrapperUser(User c,boolean bool)        
          {
            this.con = c;        
            this.bool = bool;        
          }
       }
         public PageReference EnrichOrgLeads() {
          PageReference pageRef = new PageReference('/apex/ConfigureUser');
                return pageRef;
         }
         
         
         
        public PageReference SendInvitation()  //PageReference 
        { 
          if(createreachableteam)
          {
              create_team();
          }         
          getTotalPages();
          display = true;
          getSelectedUsers();
          selectedList = SelectedcontactMap.values();
          system.debug('select list:' + selectedList);
        
         try
        {
          if (selectedList.size() < 1)
          {
               ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Please select at least one user to send Team invitation.'));
          }
         
         for(integer i=0; i < selectedList.size(); i++)
         {
            system.debug('Total User== ' + selectedList.size());
            String emailaddress = selectedList[i].Email;
            EmailAdd.add(emailaddress);
            system.debug('Correct Email ==' + EmailAdd);
         }
       }
       catch(Exception e)
        {
          system.debug('Exception e:'+e);
          excp=e;
       }
              system.debug('excp:'+excp);            
               if(excp == null)
               {
               if(reachable_team_id != null || reachable_team_id!= 'null')
               {
                   inviteteam = true;
               }
          
                if(inviteteam)
                {      
                 reachable_team_id = orgDefaults.Org_Team_ID__c;        
                try
                {
                  system.debug('EmailAdd size nside try:'+EmailAdd.size());
                  if (EmailAdd.size() > 0)
                  {     
                   user_Rec = [Select Reachable_Access_Token__c,Reachable_Username__c from Reachable_User_Setting__c where ownerID = :UserInfo.getUserId()];
                   accesstokenval = RS_encryption_handler.decrypt(user_Rec.Reachable_Access_Token__c);
                  
                   system.debug('EmailAddress :'+EmailAdd);// EmailAddress);
                   system.debug('reachable_team_id :'+reachable_team_id);
                   system.debug('accesstokenval :'+accesstokenval);
                   Message = RS_reachableteaminvite.getteamemailid(EmailAdd,reachable_team_id,accesstokenval);
                   
                   if(Message != 'null')
                   {
                   
                   for(user u : SelectedcontactMap.values()){
                   
                    wrapperlist.add(new WrapperUser(u,false));
                   }
                  /*  for(User cc : (List<User>)Setcon.getRecords())
                        {
                           wrapperlist.add(new WrapperUser(cc,false));
                        }*/
                     EmailAdd =new Set<String>();
// add                     displaymessage = Message;
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,Message));

                   }
 
                   if(Message == 'null')
                   { 
                      // getUsers(); 
                       for(user u : SelectedcontactMap.values()){
                   
                    wrapperlist.add(new WrapperUser(u,false));
                   }
                     /*  for(User cc : (List<User>)Setcon.getRecords())
                        {
                           wrapperlist.add(new WrapperUser(cc,false));
                        }*/
                       EmailAdd =new Set<String>();
//                       wrapperlist = new List <WrapperUser>();
                       ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM,'Team invitation sent successfully.'));
                   }
                 }       
                }    
                 catch(Exception e)
                 {
                     system.debug('This is the exception:'+e);
                     ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'Please select at least one user to send Team invitation.'));                     
                 }
               }
             } 
                  return pg;  
       }

        public integer pageNumber
        {
            get
            {
              integer pagecount =  Setcon.getPageNumber(); 
              system.debug('pagecount==' + pagecount); 
              if(pagecount==1)
              {
                  FirstPage = true;
              }
              else
              {
                  FirstPage = false;
              }
              if(pagecount ==  pages)  //14
              {
                 LastPrevious = true;              
              }
              else
              {
               LastPrevious = false;
              }
              return pagecount ;        
            }        
            set;        
        }
        

        Public Integer getTotalPages()
        {
           recNum = noOfRecords;
           recLimit = record_count;
           Integer reminder = math.mod(recNum , recLimit);
           if(reminder == 0)
           {
             pages = recNum/recLimit;
           }
           else
           {
             pages = recNum/recLimit+1;
           }
         return pages; 
        }
}