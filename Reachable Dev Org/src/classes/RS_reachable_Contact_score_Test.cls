@isTest
public class RS_reachable_Contact_score_Test 
{
  static testmethod void testleadscore()
    {
        Test.startTest();
        Profile p = [SELECT Id FROM Profile WHERE Name='Standard User']; 
        User usr1 = new User(Alias = 'sasdndt', Email='standardusertesta1@testorg.com',EmailEncodingKey='UTF-8', 
                            LastName='Tasding', LanguageLocaleKey='en_US',LocaleSidKey='en_US', ProfileId = p.Id, 
                            TimeZoneSidKey='America/Los_Angeles', UserName='standardusertest2@testorg.com');
         System.assertEquals('Tasding', usr1.LastName);                    
        User usr2 = new User(Alias = 'sasdndt1', Email='standardusertesta11@testorg.com',EmailEncodingKey='UTF-8', 
                            LastName='Tasding1', LanguageLocaleKey='en_US',LocaleSidKey='en_US', ProfileId = p.Id, 
                            TimeZoneSidKey='America/Los_Angeles', UserName='standardusertest21@testorg.com');
       System.assertEquals('Tasding1', usr2.LastName); 
        insert usr1;
        insert usr2;        
         
       Reachable_User_Setting__c rus_rec1= new Reachable_User_Setting__c(Reachable_Access_Token__c = '5t5VJJXD2xQ6nIkKq9CmWN/v/gy1SHNVCqjd9Vv2JqIIkM37Givf3IGcMtTwP4yj',Reachable_Username__c = 'test1@reachable.com',SF_Username__c = 'abc1@sfdc.com',ownerid = usr1.id);
       System.assertEquals('test1@reachable.com', rus_rec1.Reachable_Username__c); 
       Reachable_User_Setting__c rus_rec2= new Reachable_User_Setting__c(Reachable_Access_Token__c = 'vKB4pGEhidf0FsyKhb8KjHM2xcuq7vvaszkn1nY88C1enmP/XNLdTNhmMyBQeDGK',Reachable_Username__c = 'test2@reachable.com',SF_Username__c = 'abc2@sfdc.com',ownerid = usr2.id);
       System.assertEquals('test2@reachable.com', rus_rec2.Reachable_Username__c); 
        insert rus_rec1;
        insert rus_rec2;
        
        Account acct = new Account(Name='SFDC Account');
        System.assertEquals('SFDC Account', acct.Name); 
        insert acct;
        ID acctID = acct.ID;
        String AcName = acct.name;
        
         Contact con = new Contact(FirstName='Joe',LastName='Smith',email='test14@gmail.com', AccountId = acctID);
         System.assertEquals('Joe', con.FirstName); 
         insert con;        

        List<Contact> recordlist = [Select ID,Account.Name,FirstName,LastName,Email from Contact where FirstName!= null and LastName !=null and email != null];
        System.assertEquals('Smith', recordlist[0].LastName); 
        RS_reachable_Contact_score.getscore(recordlist);
        Test.stopTest();
    }
}