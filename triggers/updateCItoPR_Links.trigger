trigger updateCItoPR_Links on BMCServiceDesk__Problem__c ( after Update ) {

  for (BMCServiceDesk__Problem__c PR : Trigger.new){
     
       ID oldCI = trigger.oldMap.get(PR.id).FKBMC_BaseElement__c;
       ID newCI = trigger.newMap.get(PR.id).FKBMC_BaseElement__c;  
       ID PRID = PR.ID;
       // if the field value has changed in CI
     if ( oldCI != newCI ){
        if ( oldCI != null ){
           // delete the relationship to old CI value
           // PR.addError('Delete Releationship to ' + oldCI );
           // get the BMCServiceDesk__Problem_CI_Link__c record and delete it
           BMCServiceDesk__Problem_CI_Link__c[] OldLink = [ SELECT id
                                                            FROM BMCServiceDesk__Problem_CI_Link__c
                                                            WHERE BMCServiceDesk__FKProblem__c = :PRID   
                                                            AND BMCServiceDesk__FKConfiguration_Item__c = :oldCI 
                                                          ];
            delete OldLink;
        }
        if ( newCI != null ){
           
           // create new releationship of new value
           BMCServiceDesk__Problem_CI_Link__c ProblemCILinkRecord = 
           new BMCServiceDesk__Problem_CI_Link__c ( BMCServiceDesk__FKConfiguration_Item__c = newCI,
                                                    BMCServiceDesk__FKProblem__c = PrID);
  
           Insert ProblemCILinkRecord ;
 
        }
      
     }
  
  }

}