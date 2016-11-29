@isTest
public class RS_reachablelogin_test 
{
  static testmethod void testlogin()
    {
         Test.startTest();
         String username = 'abc@test.com';
         String password = 'kjdhjkdhakjn3';
         System.assertEquals('abc@test.com', username);
         System.assertEquals('kjdhjkdhakjn3', password);
         rs_reachablelogin.gettoken(username,password);
         Test.stopTest();
    }
}