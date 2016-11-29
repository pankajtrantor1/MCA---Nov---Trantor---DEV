public with sharing class RS_Account_Batch_Manager implements Schedulable
{ 
    Public static void runbatch() 
    { 
            RS_get_reachable_score_batch_Accounts scorebatch = new RS_get_reachable_score_batch_Accounts();
            database.executeBatch(scorebatch,3);
    }
    
    public void execute(SchedulableContext sc){
      RS_get_reachable_score_batch_Accounts scorebatch = new RS_get_reachable_score_batch_Accounts();
            database.executeBatch(scorebatch,3);
    
    }

}