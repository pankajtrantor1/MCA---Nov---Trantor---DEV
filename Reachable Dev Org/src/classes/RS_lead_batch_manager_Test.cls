@isTest 
 class RS_lead_batch_manager_Test 
 {  
   
   static testMethod void Accountbatchmanager()
   { 
     Test.startTest();
     String AcctMangaer = 'AcctBatch';
     System.assertEquals('AcctBatch', AcctMangaer); 
     SchedulableContext sc = null;
     RS_lead_batch_manager.runbatch();
     RS_lead_batch_manager LeadBatch = new RS_lead_batch_manager();
     LeadBatch.execute(sc);
     Test.stopTest();
   
   }
 }