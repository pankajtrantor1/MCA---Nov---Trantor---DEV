@isTest
public class RS_ReachableTaLoginPageController_Test 
{
  static testMethod void testlogin()
  {   
      Test.startTest();
      RS_ReachableTabLoginPageController obj = new RS_ReachableTabLoginPageController();
      String Reach_User ='AdminTest';
      System.assertEquals('AdminTest', Reach_User);
      obj.username = '';
      obj.password = '';
      obj.isIframe = true;
      obj.error = 'no error';
      obj.forgeturllink = 'test';
      obj.accessToken = 'null';
      obj.login();
      Test.stopTest();
  }
  static testMethod void testlogin1()
  {
      Test.startTest();
 //     Reachable_User_Setting__c rus = new Reachable_User_Setting__c(Reachable_Username__c = 'abc@reach.com',SF_Username__c = 'abc@sf.com',Reachable_Access_Token__c = 'qwerty');
 //     insert rus;
      RS_ReachableTabLoginPageController obj = new RS_ReachableTabLoginPageController();     
      String Reach_User_Name ='AdminTest';
      System.assertEquals('AdminTest', Reach_User_Name); 
      obj.recinsert = true;
      obj.username = 'abc@test.com';
      obj.password = 'password';
      obj.accessToken = 'null';
      obj.login();
      Test.stopTest();
       
  }
    
  static testMethod void testlogin2()
  {
      Test.startTest();
      Reachable_User_Setting__c rus = new Reachable_User_Setting__c(Reachable_Username__c = 'abc@reach.com',SF_Username__c = 'abc@sf.com',Reachable_Access_Token__c = 'qwerty'); 
      System.assertEquals('abc@reach.com', rus.Reachable_Username__c);
      insert rus;
      RS_ReachableTabLoginPageController obj = new RS_ReachableTabLoginPageController();
      obj.recinsert = false;      
      obj.username = 'abc@test.com';
      obj.password = 'password';
      obj.accessToken = 'null';
      obj.login();
      Test.stopTest();
       
  }
    
  static testMethod void testlogin3()
  {
      Test.startTest();
      RS_ReachableTabLoginPageController obj = new RS_ReachableTabLoginPageController();
      String Reach_UserName ='AdminTest';
      System.assertEquals('AdminTest', Reach_UserName);
      obj.username = 'abc@test.com';
      obj.password = '';
      obj.accessToken = 'null';
      obj.login();     
      Test.stopTest(); 
  }
  static testMethod void testlogin4()
  {
      Test.startTest();
      RS_ReachableTabLoginPageController obj = new RS_ReachableTabLoginPageController();
      String Reach_Log_Name ='AdminTest';
      System.assertEquals('AdminTest', Reach_Log_Name);
      obj.username = '';
      obj.password = 'password';
      obj.accessToken = 'null';
      obj.login();     
      Test.stopTest(); 
  }
  static testMethod void testlogin5()
  {
      Test.startTest();
      RS_ReachableTabLoginPageController obj = new RS_ReachableTabLoginPageController();
      String Reachable_Log_Name ='AdminTest';
      System.assertEquals('AdminTest', Reachable_Log_Name);
      obj.username = 'adcfv';
      obj.password = 'password';
      obj.accessToken = 'null';
      obj.login();      
      Test.stopTest();
  }    
}