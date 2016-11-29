@isTest 
 class RS_Account_batch_manager_Test 
 {
   public static apexpages.standardController controller;     
   
   static testMethod void Accountbatchmanager()
   { 
     Test.startTest();
     string Name = 'AccountManagerTest';
     System.assertEquals('AccountManagerTest', Name);
     SchedulableContext sc = null;
     RS_Account_batch_manager.runbatch();
     RS_Account_batch_manager AccountBatch = new RS_Account_batch_manager();
     AccountBatch.execute(sc); 
     Test.stopTest(); 
   }
 }