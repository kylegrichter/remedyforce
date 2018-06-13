@istest

public class TestFor_ChangeAssessController_Trigger {

  public static testmethod void TestTriggers(){
  
  // // We meed to create a Change Record
  // BMCServiceDesk__Change_Request__c ChangeRecord = 
    // new BMCServiceDesk__Change_Request__c (  BMCServiceDesk__Scheduled_Start_Date__c = System.today(),
                                             // BMCServiceDesk__Scheduled_End_Date__c = System.today()+1);
  
  // Insert ChangeRecord;
  
  // // Need to create a Change Assessment Record and tie it back to Change Record
  // BMCServiceDesk__Change_Assessment__c AssessmentRecord =
    // new BMCServiceDesk__Change_Assessment__c ( BMCServiceDesk__FKChange__c = ChangeRecord.Id );
  
  // Insert AssessmentRecord; 
  // Update AssessmentRecord;
  // AssessmentRecord.BMCServiceDesk__Assessment_Completed__c = true;
  // Update AssessmentRecord;
  }

}