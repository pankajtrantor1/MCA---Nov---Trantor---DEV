public with sharing class RS_get_Company_Account_score_batch implements Database.Batchable<sObject>, Database.AllowsCallouts, Database.Stateful
{
    List<Reachable_Scoring__c> r_score;
    String accessToken;
    Map<ID,String> aamap = new Map<ID,String>();
    List<Reachable_User_Setting__c> aa;
    public Database.QueryLocator start(Database.BatchableContext BC)
    {
        aa = [Select ID,Reachable_Access_Token__c,ownerid from Reachable_User_Setting__c LIMIT 50000];
        for(Integer i = 0; i < aa.size(); i++)
        {
            String a_token = RS_encryption_handler.decrypt(aa[i].Reachable_Access_Token__c);
            aamap.put(aa[i].ownerid,a_token);
        }
        String query = 'Select id,LeadId__c,AccountId__c,ContactId__c,Company_ID__c,UserID__c from Reachable_Scoring__c  where AccountId__c != null';
        
        system.debug('Query Result: ' +query);
        // 'Select id,ContactId__c,AccountId__c,Company_ID__c,UserID__c from Reachable_Scoring__c where AccountId__c = '/' And Company_ID__c != null';
        return Database.getQueryLocator(query);
    }
    public void execute(Database.BatchableContext BC, List<Reachable_Scoring__c> scope)
    { 
         for(Reachable_Scoring__c rs : scope)
         {
           accessToken = aamap.get(rs.UserID__c);
              if(!Schema.sObjectType.Reachable_Scoring__c.isAccessible()) 
             {
                 ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, 'Insufficient access'));   
             }
             if(!Schema.sObjectType.Reachable_Scoring__c.isUpdateable()) 
             {
               ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, 'Insufficient access to update status'));
             }
           
           r_score = RS_Company_score.getscore(scope,accessToken);
         }
        
            if(!Schema.sObjectType.Reachable_Scoring__c.isAccessible()) 
             {
                 ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, 'Insufficient access'));   
             }
             if(!Schema.sObjectType.Reachable_Scoring__c.isUpdateable()) 
             {
               ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, 'Insufficient access to update status'));
             }
             
       update r_score;
    }
    public void finish(Database.BatchableContext BC)
    {
     AsyncApexJob a = [SELECT Id, Status, NumberOfErrors, JobItemsProcessed,TotalJobItems,CreatedBy.Email FROM AsyncApexJob WHERE Id =:BC.getJobId()];
     system.debug('Job Status :'+ a.Status);
    }
}