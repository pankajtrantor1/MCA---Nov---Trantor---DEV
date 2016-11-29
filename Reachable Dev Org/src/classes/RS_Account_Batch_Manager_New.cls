//Comitted vfbcds vcbv dfsghfsg vcxbxc
public with sharing class RS_Account_Batch_Manager_New implements Schedulable
{ 
    Public static void runbatch() 
    { 
            RS_Reachable_Score_Batch_Accounts scorebatch = new RS_Reachable_Score_Batch_Accounts();
            database.executeBatch(scorebatch,3);
    }
    
    public void execute(SchedulableContext sc){
      RS_Reachable_Score_Batch_Accounts scorebatch = new RS_Reachable_Score_Batch_Accounts();
            database.executeBatch(scorebatch,3);
    
    }

}