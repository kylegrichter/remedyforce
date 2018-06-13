@isTest (SeeAllData = true)

public class TestFor_Change_UpdateStatusWorkflow {
    
    public static testmethod void TestTriggers(){
        
        // UserID
        Id APIUser = [SELECT Id FROM USER WHERE Name = 'RemForce API' LIMIT 1].Id;
        // CategoryID
        Id CategoryID = [SELECT Id FROM BMCServiceDesk__Category__c LIMIT 1].Id;
        // Urgency
        Id UrgencyID = [SELECT Id FROM BMCServiceDesk__Urgency__c WHERE Name = 'LOW' LIMIT 1].Id;
        // Impact
        Id ImpactID = [SELECT Id FROM BMCServiceDesk__Impact__c LIMIT 1].Id;
        
        Id queue = [select Id from Group where DeveloperName = 'Remedyforce_Support'].id;
        Id user = [select UserOrGroupId from GroupMember where GroupId = '00GE0000000fOncMAE'].UserOrGroupId;
        
        // We meed to create a Change Record
        BMCServiceDesk__Change_Request__c ChangeRecord = 
            new BMCServiceDesk__Change_Request__c(
                BMCServiceDesk__FKInitiator__c=APIUser,
                BMCServiceDesk__FKCategory__c=CategoryID,
                BMCServiceDesk__Change_Description__c='For Test',
                BMCServiceDesk__Back_out_Plan_Details__c='For Test',
                BMCServiceDesk__Change_Type__c='Normal',
                BMCServiceDesk__Change_Category__c='Minor',
                BMCServiceDesk__FKImpact__c=ImpactID,
                BMCServiceDesk__FKUrgency__c=UrgencyID,
                BMCServiceDesk__Scheduled_Start_Date__c=date.today(),
                BMCServiceDesk__Scheduled_End_Date__c=date.today()+1,
                ownerID=queue,
                BMCServiceDesk__FKStaff__c=user,
                Auto_Submit_for_Approval__c=false,
                UpdateStatusToApproved__c = true,
                Set_Status_by_Workflow__c = 'PENDING APPROVAL'
            ); 
        
        Insert ChangeRecord;
        
        Update ChangeRecord;
        
    }
    
}