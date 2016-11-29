public with sharing class RS_CalculateScore {
   Public List<Reachable_Scoring__c> reachscore {get;set;}
   public string PersonScore{get;set;}
  public string CompanyScore{get;set;}
 
  
    public RS_CalculateScore(ApexPages.StandardController controller) {
    string leadid =ApexPages.currentPage().getParameters().get('id');
    string newleadid= convertId(leadid);
    reachscore = [select ID,LeadID__c,USERID__c,Company_Score__c,Person_Score__c,Company_ID__c,Person_ID__c 
    from Reachable_Scoring__c
     where LeadID__c =:newleadid AND USERID__c =:UserInfo.getUserId() LIMIT 1];
     if(!reachscore.isempty()){
     if(reachscore[0].Person_Score__c!=null)
     PersonScore=reachscore[0].Person_Score__c; 
     if(reachscore[0].Company_Score__c!=null)
     CompanyScore=reachscore[0].Company_Score__c;
    }
 else{
 PersonScore='';
 CompanyScore='';
 }

}
public static String convertId(String inputId){
        string suffix = '';
        integer flags;
        try{
            for (integer i = 0; i < 3; i++) {
                flags = 0;
                for (integer j = 0; j < 5; j++) {
                    string c = inputId.substring(i * 5 + j,i * 5 + j + 1);
                    if (c.toUpperCase().equals(c) && c >= 'A' && c <= 'Z') {
                        flags = flags + (1 << j);
                    }
                }
                if (flags <= 25) {
                    suffix += 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'.substring(flags,flags+1);
                }else{
                    suffix += '012345'.substring(flags - 26, flags-25);
                }
            }
        }
        catch(Exception exc){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Please enter Valid 15 digit Id'));
        }
        String outputId = inputId+suffix;
        return outputId;
    }

}