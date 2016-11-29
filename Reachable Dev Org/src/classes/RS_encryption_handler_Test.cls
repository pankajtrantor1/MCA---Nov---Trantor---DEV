@isTest
public class RS_encryption_handler_Test
{
   static testMethod void ScoreCal()
   {  
      Test.startTest(); 
     String accesstoken = 'ClKpBBPQtegw-xCyj-9pu8-jfhn-MkVTiEoiC1gD';
     String return1     = RS_encryption_handler.encrypt(accesstoken);  
     String return2     = RS_encryption_handler.decrypt(return1);
      System.assertEquals(return2,accesstoken);
      Test.stopTest();
   // system.debug(return2);       
   }
}