trigger createNewCItoPR_Link on BMCServiceDesk__Problem__c ( after Insert ) {

  for (BMCServiceDesk__Problem__c PR : Trigger.new){
    ID PrID = PR.Id;
    ID CiID = PR.FKBMC_BaseElement__c;
    
    //See if CI is populated
    if ( PR.FKBMC_BaseElement__c != null ){ 
       //create record
        BMCServiceDesk__Problem_CI_Link__c ProblemCILinkRecord = 
        new BMCServiceDesk__Problem_CI_Link__c ( BMCServiceDesk__FKConfiguration_Item__c = CiID,
                                                 BMCServiceDesk__FKProblem__c = PrID);
  
        Insert ProblemCILinkRecord ;
        
    
    }

  }

}