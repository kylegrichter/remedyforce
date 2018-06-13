@isTest (seealldata = true)
public class TestFor_ChangeIncidentCount {
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
        
	// Next we need a CR Record
	BMCServiceDesk__Change_Request__c ChangeRequest = 
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
			Auto_Submit_for_Approval__c=false
			); 
	insert ChangeRequest;

	// Need an IR
	BMCServiceDesk__Incident__c IR = 
		new BMCServiceDesk__Incident__c( 
			BMCServiceDesk__FKCategory__c = CategoryID,
			BMCServiceDesk__FKImpact__c = ImpactID,
			BMCServiceDesk__FKUrgency__c = UrgencyID
		);
	Insert IR;                                                 

	// Next we create IncidentChangeLink
	BMCServiceDesk__Incident_Change_Link__c IncidentChangeLink = 
		new BMCServiceDesk__Incident_Change_Link__c(
			BMCServiceDesk__FKChange__c = ChangeRequest.Id, 
			BMCServiceDesk__FKClient__c = APIUser, 
			BMCServiceDesk__FKIncident__c = IR.Id
			);
	insert IncidentChangeLink;
	update IncidentChangeLink;
    }
}