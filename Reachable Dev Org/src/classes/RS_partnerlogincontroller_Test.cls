@isTest
public class RS_partnerlogincontroller_Test 
{
  static testMethod void testlogin()
  {
      Test.startTest();
      string name = 'partnerlogin';
      System.assertEquals('partnerlogin', name); 
      rs_partnerlogincontroller obj = new rs_partnerlogincontroller();
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
      string name_p_log = 'partnerlogin';
      System.assertEquals('partnerlogin', name_p_log); 
 //     Reachable_User_Setting__c rus = new Reachable_User_Setting__c(Reachable_Username__c = 'abc@reach.com',SF_Username__c = 'abc@sf.com',Reachable_Access_Token__c = 'qwerty');
 //     insert rus;
      rs_partnerlogincontroller obj = new rs_partnerlogincontroller();      
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
      string name_partner = 'partnerlogin';
      System.assertEquals('partnerlogin', name_partner); 
      Reachable_User_Setting__c rus = new Reachable_User_Setting__c(Reachable_Username__c = 'abc@reach.com',SF_Username__c = 'abc@sf.com',Reachable_Access_Token__c = 'qwerty');     
      System.assertEquals('abc@reach.com', rus.Reachable_Username__c);
      insert rus;
      rs_partnerlogincontroller obj = new rs_partnerlogincontroller();
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
      rs_partnerlogincontroller obj = new rs_partnerlogincontroller();
      string name_partner_log = 'partnerlogin';
      System.assertEquals('partnerlogin', name_partner_log); 
      obj.username = 'abc@test.com';
      obj.password = '';
      obj.accessToken = 'null';
      obj.login();    
      Test.stopTest();  
  }
  static testMethod void testlogin4()
  {
      Test.startTest(); 
      string name_log = 'partnerlogin';
      System.assertEquals('partnerlogin', name_log); 
      rs_partnerlogincontroller obj = new rs_partnerlogincontroller();
      obj.username = '';
      obj.password = 'password';
      obj.accessToken = 'null';
      obj.login();   
      Test.stopTest();   
  }
  static testMethod void testlogin5()
  {
      Test.startTest();
      string Test_name_log = 'partnerlogin';
      System.assertEquals('partnerlogin', Test_name_log);
      rs_partnerlogincontroller obj = new rs_partnerlogincontroller();
      obj.username = 'adcfv';
      obj.password = 'password';
      obj.accessToken = 'null';
      obj.login();     
       Test.stopTest(); 
  }    
}