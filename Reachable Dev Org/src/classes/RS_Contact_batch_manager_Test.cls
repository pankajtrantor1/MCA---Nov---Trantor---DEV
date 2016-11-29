@isTest 
 class RS_Contact_batch_manager_Test 
 {  
   
   static testMethod void Accountbatchmanager()
   { 
     Test.startTest();
     String Accountbatch = 'BatchManager';
     System.assertEquals('BatchManager', Accountbatch); 
     SchedulableContext sc = null;
     RS_Contact_batch_manager.runbatch();
     RS_Contact_batch_manager ContacttBatch = new RS_Contact_batch_manager();
     ContacttBatch.execute(sc);
     Test.stopTest();
   
   }
 }