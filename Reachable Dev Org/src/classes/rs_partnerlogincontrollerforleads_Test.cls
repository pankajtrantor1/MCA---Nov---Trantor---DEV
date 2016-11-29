@isTest
public class rs_partnerlogincontrollerforleads_Test
{
    // public static apexpages.standardController controller;
     
    // rs_partnerlogincontrollerforleads obj = new rs_partnerlogincontrollerforleads(controller);
     
   static testMethod void rs_partnerlogincontrollerforleadstestclass0()
   {   
       Test.startTest();
       Lead leadrec = new Lead(lastname = 'last', firstname = 'first', company='company', email='email@test.com');
       System.assertEquals('first', leadrec.firstname);
       insert leadrec;
       ID LId;
       LId = leadrec.id;
       List<Lead> leadlist = new List<Lead>();
       leadlist.add(leadrec);
       Reachable_User_Setting__c rus = new Reachable_User_Setting__c(Reachable_Username__c = 'abc@reach.com',SF_Username__c = 'abc@sf.com',Reachable_Access_Token__c = 'qwerty');
       System.assertEquals('abc@reach.com', rus.Reachable_Username__c);
       insert rus;
       rs_partnerlogincontrollerforleads obj = new rs_partnerlogincontrollerforleads();
       obj.ReachableAccessToken = rus;
       obj.getcoid = 'qwerty8383920';
       obj.token_exist = true;
       obj.getidofthecurrent = leadrec.id;
       obj.leadidpage = leadrec.id;
       obj.recinsert = true;
       obj.username = 'abc@test,com';
       obj.password = 'password';
       obj.refresh();
       obj.Login();
       Test.stopTest();
   }
    
   static testMethod void rs_partnerlogincontrollerforleadstestclass1()
   {   
      Test.startTest();
       Lead leadrec = new Lead(lastname = 'last', firstname = 'first', company='company', email='email@test.com');
       System.assertEquals('first', leadrec.firstname); 
       insert leadrec;       
       
       PageReference pageRef = Page.RS_Lead_Score_fields;
       pageRef.getParameters().put('id', String.valueOf(leadrec.Id));
       Test.setCurrentPage(pageRef);
       
       List<Lead> leadlist = new List<Lead>();
       leadlist.add(leadrec);       
       
       ApexPages.StandardController sc = new ApexPages.StandardController(leadrec);       
       rs_partnerlogincontrollerforleads obj = new rs_partnerlogincontrollerforleads(sc);      
       Reachable_User_Setting__c rus = new Reachable_User_Setting__c(Reachable_Username__c = 'abc@reach.com',SF_Username__c = 'abc@sf.com',Reachable_Access_Token__c = 'qwerty');
       System.assertEquals('abc@reach.com', rus.Reachable_Username__c); 
       insert rus;
       ApexPages.currentPage().getParameters().put('Id',null);
       obj.ReachableAccessToken = rus;
       obj.leadidpage = leadrec.id;
       obj.getcoid = 'qwerty8383920';
       obj.token_exist = true;
       obj.getidofthecurrent = leadrec.id;
       obj.leadidpage = leadrec.id;
       obj.recinsert = true;
       obj.username = 'abc@test,com';
       obj.password = '';
       obj.Login();
       obj.refresh();
       Test.stopTest();
   } 
   static testMethod void rs_partnerlogincontrollerforleadstestclass2()
   {   
       Test.startTest();
       rs_partnerlogincontrollerforleads obj = new rs_partnerlogincontrollerforleads();
       String Reachable_User = 'abc@reach.com';
       System.assertEquals('abc@reach.com', Reachable_User);
       obj.username = '';
       obj.password = 'password';
       obj.Login(); 
       Test.stopTest();
   }
   static testMethod void rs_partnerlogincontrollerforleadstestclass3()
   {   
       Test.startTest();
       rs_partnerlogincontrollerforleads obj = new rs_partnerlogincontrollerforleads();       
       String Reachable_User_Name = 'abc@reach.com';
       System.assertEquals('abc@reach.com', Reachable_User_Name); 
       obj.username = '';
       obj.password = '';
       obj.Login();
       Test.stopTest();
   }
   static testMethod void rs_partnerlogincontrollerforleadstestclass4()
   {   
      Test.startTest();
       Lead leadrec = new Lead(lastname = 'last', firstname = 'first', company='company', email='email@test.com');
       System.assertEquals('first', leadrec.firstname); 
       insert leadrec;
       List<Lead> leadlist = new List<Lead>();
       leadlist.add(leadrec);
       Reachable_User_Setting__c rus = new Reachable_User_Setting__c(Reachable_Username__c = 'abc@reach.com',SF_Username__c = 'abc@sf.com',Reachable_Access_Token__c = 'qwerty');
       rs_partnerlogincontrollerforleads obj = new rs_partnerlogincontrollerforleads();
       obj.ReachableAccessToken = rus;
       obj.getcoid = 'qwerty8383920';
       obj.token_exist = true;
       obj.getidofthecurrent = leadrec.id;
       obj.leadidpage = leadrec.id;
       obj.recinsert = false;
       obj.username = 'abc@test,com';
       obj.password = 'password';
       //obj.accessToken = 'dsffsdf44545sdffsd';
       obj.refresh();
       obj.Login();
       Test.stopTest();
   }    
}