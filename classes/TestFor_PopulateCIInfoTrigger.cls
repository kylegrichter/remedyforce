@isTest (SeeAllData = true) 
public class TestFor_PopulateCIInfoTrigger {
    public static testmethod void TestTriggers(){
        // UserID
        Id APIUser = [SELECT Id FROM USER WHERE Name = 'RemForce API'].Id;
        
        // Find ASA Template
        Id Template = [SELECT Id FROM BMCServiceDesk__SYSTemplate__c WHERE Name LIKE 'ASA-%' LIMIT 1].Id;
        
        // BMCServiceDesk__BMC_BaseElement__c named Database
        BMCServiceDesk__BMC_BaseElement__c BaseElement = 
            new BMCServiceDesk__BMC_BaseElement__c ( 
                Name = 'TEST APPLICATION',
                BMCServiceDesk__InstanceID__c = 'INST-1',
                BMCServiceDesk__Name__c = 'TEST APPLICATION',
                FKTrustee_ID_1__c = APIUser,
                FKTrustee_ID_2__c = APIUser,
                Post_Approval_Queue_Assignment__c = 'Pending Approval',
                Post_Approval_Email_Notification__c = 'test@example.com'
            ); 
        Insert BaseElement;
        
        // BMCServiceDesk__Category__c named TEST
        BMCServiceDesk__Category__c CATEGORY = 
            new BMCServiceDesk__Category__c ( 
                Name = 'TEST',
                BMCServiceDesk__AvailableForIncidents__c = true
            );
        Insert CATEGORY;
        
        // BMCServiceDesk__Impact__c named TEST
        BMCServiceDesk__Impact__c IMPACT = 
            new BMCServiceDesk__Impact__c ( 
                Name = 'TEST' 
            );                                           
        Insert IMPACT;
        
        // BMCServiceDesk__Urgency__c named TEST
        BMCServiceDesk__Urgency__c URGENCY = 
            new BMCServiceDesk__Urgency__c ( 
                Name = 'TEST' 
            );                                           
        INSERT URGENCY;                                     
        
        // Create an IR
        BMCServiceDesk__Task__c TK = 
            new BMCServiceDesk__Task__c ( 
                BMCServiceDesk__FKClient__c = APIUser,
                BMCServiceDesk__taskDescription__c = 'Testing',
                BMCServiceDesk__FKCategory__c = CATEGORY.Id,
                BMCServiceDesk__FKImpact__c = IMPACT.Id,
                BMCServiceDesk__FKUrgency__c = URGENCY.Id,
                Configuration_Item__c = BaseElement.Id,
                BMCServiceDesk__FKTemplate__c = Template
            );
        Insert TK;
    }
}