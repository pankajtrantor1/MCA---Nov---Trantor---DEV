public with sharing class RS_Lead_Batch_Manager implements Schedulable
{ 
    Public static void runbatch() 
    { 
            RS_get_reachable_score_batch scorebatch = new RS_get_reachable_score_batch();
            database.executeBatch(scorebatch,3);
    }
    
    public void execute(SchedulableContext sc){
      RS_get_reachable_score_batch scorebatch = new RS_get_reachable_score_batch();
            database.executeBatch(scorebatch,3);
    
    }

}