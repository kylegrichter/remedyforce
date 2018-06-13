@isTest (SeeAllData = true)
public class ApprovalItemController_Test{
   static testMethod void test_getAllApprovalStep_UseCase1(){
    List<BMCServiceDesk__Change_Request__c> bmcservicedeskhange_request_Obj2  =  [SELECT BMCServiceDesk__Approved__c,BMCServiceDesk__Inactive__c,BMCServiceDesk__State__c,BMCServiceDesk__Dummy_Update__c,BMCServiceDesk__TemplateAlreadyApplied__c,BMCServiceDesk__AllTaskCloseController__c,AllAssessmentsClosedController__c,UpdateStatusToApproved__c,Approval_Workflow_In_Progress_Complete__c,Business_Approval__c,Auto_Submit_for_Approval__c,BMCServiceDesk__Scheduled_during_Blackout__c,Supervisor_Approved__c,VP_Approved__c,BMCRF_Assigned_by_EB__c,BMCRF_Everbridge_Auto_Assignment__c from BMCServiceDesk__Change_Request__c WHERE Approval_Workflow_In_Progress_Complete__c = True];
    BMCServiceDesk__Change_Request__c bmcservicedeskhange_request_Obj = new BMCServiceDesk__Change_Request__c();
    bmcservicedeskhange_request_Obj.Approval_Workflow_In_Progress_Complete__c = True;
    bmcservicedeskhange_request_Obj.OwnerId = '00GE0000000fOnc';
    bmcservicedeskhange_request_Obj.BMCServiceDesk__FKStaff__c = '005E00000026vpQ';
    bmcservicedeskhange_request_Obj.BMCServiceDesk__FKInitiator__c = '005E00000026vpQ';
    bmcservicedeskhange_request_Obj.BMCServiceDesk__FKCategory__c = 'a1DE0000000UYDL';
    bmcservicedeskhange_request_Obj.Title__c = 'Test Class';
    bmcservicedeskhange_request_Obj.BMCServiceDesk__Change_Description__c = 'Test Class';
    bmcservicedeskhange_request_Obj.BMCServiceDesk__Change_Type__c = 'Normal';
    bmcservicedeskhange_request_Obj.BMCServiceDesk__Change_Category__c = 'Minor';
    bmcservicedeskhange_request_Obj.Environment__c = 'Production';
    bmcservicedeskhange_request_Obj.Auto_Submit_for_Approval__c = True;
    bmcservicedeskhange_request_Obj.Affected_Systems_Applications__c = 'Test Class';
    bmcservicedeskhange_request_Obj.Validation_Steps__c = 'Test Class';
    bmcservicedeskhange_request_Obj.BMCServiceDesk__Back_out_Plan_Details__c = 'Test Class';
    bmcservicedeskhange_request_Obj.BMCServiceDesk__FKImpact__c = 'a1PE0000000D8Rl';
    bmcservicedeskhange_request_Obj.BMCServiceDesk__FKUrgency__c = 'a2GE0000000H9qT';
    bmcservicedeskhange_request_Obj.BMCServiceDesk__Scheduled_Start_Date__c = System.now()+1;
    bmcservicedeskhange_request_Obj.BMCServiceDesk__Scheduled_End_Date__c = System.now()+2;
      
    Insert bmcservicedeskhange_request_Obj; 
    ApprovalItemController obj01 = new ApprovalItemController();
    obj01.relatedRecordId = bmcservicedeskhange_request_Obj.id;
    obj01.getAllApprovalStep();
  }
}