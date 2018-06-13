trigger ChangeAssessmentControllerUpdate on BMCServiceDesk__Change_Assessment__c (after update) {

  // ID ChangeID;
  // Integer TotalAssessments = 0;
  // Integer CompleteAssessments = 0;
  
  // for (BMCServiceDesk__Change_Assessment__c CA : Trigger.new){
      // ChangeID = CA.BMCServiceDesk__FKChange__c;
      
      // TotalAssessments = [SELECT COUNT() FROM BMCServiceDesk__Change_Assessment__c where BMCServiceDesk__FKChange__c = :ChangeID ALL ROWS];
      // CompleteAssessments = [SELECT COUNT() FROM BMCServiceDesk__Change_Assessment__c where BMCServiceDesk__FKChange__c = :ChangeID AND  BMCServiceDesk__Assessment_Completed__c = true ALL ROWS];
  
      // if ( TotalAssessments == CompleteAssessments ) {
         
         // System.debug('Updating Controller to TRUE' );
         // BMCServiceDesk__Change_Request__c CR = [SELECT AllAssessmentsClosedController__c FROM BMCServiceDesk__Change_Request__c WHERE Id = :ChangeID LIMIT 1]; 
         // CR.AllAssessmentsClosedController__c = true;
         // update CR;
      // }
      // else{
         
         // System.debug( 'Updating Controller to FALSE' );
         // BMCServiceDesk__Change_Request__c CR = [SELECT AllAssessmentsClosedController__c FROM BMCServiceDesk__Change_Request__c WHERE Id = :ChangeID LIMIT 1];
         // CR.AllAssessmentsClosedController__c = false;
         // update CR;      
      // }
  
    
  // }
}