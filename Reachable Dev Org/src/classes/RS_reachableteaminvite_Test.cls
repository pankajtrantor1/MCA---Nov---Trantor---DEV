@isTest
public class RS_reachableteaminvite_Test 
{
  static testmethod void mockteaminvite()
    {
        Test.startTest();
        string accessToken= 'vnslkmndkls-jk2k-sxnj-dcpoacml3';
        string team_id = '123456890mnxmzx';
        Set<String> testinviteemaillist = new Set<String>();
        testinviteemaillist.add('abc@abc.com');
        System.assertEquals('vnslkmndkls-jk2k-sxnj-dcpoacml3', accessToken);
        System.assertEquals('123456890mnxmzx', team_id);
        System.assertEquals(testinviteemaillist, testinviteemaillist);
        rs_reachableteaminvite.getteamemailid(testinviteemaillist,team_id,accessToken);
        Test.stopTest();
    }
}