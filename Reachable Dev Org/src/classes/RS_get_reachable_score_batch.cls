public with sharing class RS_get_reachable_score_batch implements Database.Batchable<sObject>, Database.AllowsCallouts, Database.Stateful
{
    Map<ID, Reachable_User_Setting__c> m ;
    string a_token;
    ID userid;
    List<Reachable_Scoring__c> r_score;
    List<Reachable_Scoring__c> r_update_Score = new List<Reachable_Scoring__c>();
    List<Reachable_Scoring__c> r_insert_Score = new List<Reachable_Scoring__c>();

////////////////////////////////
//   Batch Start  
////////////////////////////////

    public Database.QueryLocator start(Database.BatchableContext BC) 
    {
   //     m = new Map<ID, Reachable_User_Setting__c>([SELECT Id, SF_Username__c,Reachable_Access_Token__c,ownerId FROM Reachable_User_Setting__c]);
        String query = 'SELECT Id, LastName, FirstName, Company, Email FROM Lead where LastName != null and FirstName != null and company != null and email != null';
        return Database.getQueryLocator(query);
    }

////////////////////////////////
//   Batch Execute 
////////////////////////////////   
   
   
    public void execute(Database.BatchableContext BC, List<Lead> scope) 
    {
             for(Lead l : scope)
             {
               r_score = new List<Reachable_Scoring__c>();
               r_score = RS_reachable_lead_score.getscore(scope);             
               system.debug('scope'+scope);
               system.debug('inside for :'+r_score);
              
             
             system.debug('outside for :'+r_score);
         
        
                    Map<String,Id> currIntrcMap = new Map<String,Id>();
                    for(Reachable_Scoring__c rsc :[Select ID,LeadID__c,UserID__c,Person_ID__c,Person_Score__c from Reachable_Scoring__c])
                    {
                        String combId = ((String)rsc.LeadID__c) + ((String)rsc.UserID__c) + ((String)rsc.Person_ID__c) + ((String)rsc.Person_Score__c);
                        currIntrcMap.put(combId,rsc.Id);
                    }
            //  
                 
                   r_update_Score = new List<Reachable_Scoring__c>();
                   r_insert_Score = new List<Reachable_Scoring__c>();
             
                    for( Integer i = 0; i < r_score.size(); i++)
                    {
                    String newCombId = ((String)r_score[i].LeadID__c) + ((String)r_score[i].UserID__c) + ((String)r_score[i].Person_ID__c) + ((String)r_score[i].Person_Score__c);
                     if(currIntrcMap.containsKey(newCombId)) 
                     {
                        r_update_Score.add(r_score[i]);
                     }
                     else
                     {
                        r_insert_Score.add(r_score[i]);
                     }
             //       insert r_score;
                    }
             }
      
      
      
                    try
                    {
                        if(r_insert_Score[0].LeadID__c != '')
                            {
                                insert r_insert_Score;
                            }
                    }
                    catch(Exception e)
                    {
                        system.debug('Insert Exception is :'+e);
                    }
                    try
                    {
                        if(r_update_Score[0].LeadID__c != '')
                        {
                            update r_update_Score;
                        }
                    }
                    catch(Exception ee)
                    {
                        system.debug('Update Exception is :'+ee);
                    }    
           
    }   
    
    
////////////////////////////////
//    Batch Finish    
////////////////////////////////    
    
    public void finish(Database.BatchableContext BC) 
    {
      AsyncApexJob a = [SELECT Id, Status, NumberOfErrors, JobItemsProcessed,TotalJobItems,CreatedBy.Email FROM AsyncApexJob WHERE Id =:BC.getJobId()];
      try
      {
          Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
          String[] toAddresses = new String[] {a.CreatedBy.Email};
          mail.setToAddresses(toAddresses);
          mail.setSubject('Apex Sharing Recalculation ' + a.Status);
          mail.setPlainTextBody ('The batch Apex job processed ' + a.TotalJobItems + ' batches with '+ a.NumberOfErrors + ' failures.');
        //  Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
      }
      catch(Exception e)
      {
          system.debug('Exception :'+e);
      }
      if(a.Status == 'Completed')
      {
       RS_get_company_score_batch companyscore = new RS_get_company_score_batch();
       database.executeBatch(companyscore,1);
      }

    }
}