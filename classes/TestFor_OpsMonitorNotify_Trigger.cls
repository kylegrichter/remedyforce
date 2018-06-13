public class TestFor_OpsMonitorNotify_Trigger {
@isTest (SeeAllData = true)   
    public static void TestTriggers(){
    // First, we find the running user ID, it will be the client Id on the Incident we are preparing to generate, for line 
    ID userId = userinfo.getUserId();    
    
    // Need an Assigned Owner
    Profile p = [select id from profile where name='API'];
    string APIuser = [SELECT id
                            From User
                            WHERE ProfileID = :p.Id
                            AND Name = 'RemForce API'
                            AND IsActive = true limit 1].Id;
    string APIqueue = [SELECT id
                            From Group
                            WHERE Name = 'Pending Approval' limit 1].Id;
    
    // We need a category record, so we create one 
    BMCServiceDesk__Category__c sdc = new BMCServiceDesk__Category__c(name= 'cat', BMCServiceDesk__AvailableForIncidents__c = true );
    insert sdc;
    
    // We need Impact ID 
    string Impact  = [SELECT Id FROM BMCServiceDesk__Impact__c where Name = 'LOW' limit 1 ].Id;

    // We need Urgency ID
    string Urgency = [SELECT Id FROM BMCServiceDesk__Urgency__c where Name = 'LOW' limit 1 ].Id;
    
    // We need a CI
    string ConfigItem = [SELECT Id FROM BMCServiceDesk__BMC_BaseElement__c limit 1 ].Id;
    
     // We create the incident using the userId, and the category.
    BMCServiceDesk__Incident__c sdi = new BMCServiceDesk__Incident__c (BMCServiceDesk__FKClient__c= userId,
                                                                       BMCServiceDesk__FKCategory__c = sdc.id,
                                                                       Ops_Monitor__c = true,
                                                                       BMCServiceDesk__FKBMC_BaseElement__c = ConfigItem,
                                                                       BMCServiceDesk__state__c = false,
                                                                       BMCServiceDesk__incidentResolution__c = 'Resolved',
                                                                       BMCServiceDesk__FKImpact__c = Impact,
                                                                       BMCServiceDesk__FKUrgency__c = Urgency,
                                                                       OwnerId = APIqueue,
                                                                       BMCServiceDesk__FKOpenBy__c = APIuser,
                                                                       BMCServiceDesk__queueName__c = 'RemedyForce Support',
                                                                       Cause_Code__c = 'Autosys',
                                                                       Resolution_Code__c = 'Autosys',
                                                                       Code_Group__c = 'Application Support'
                                                                      );
    // Insert creates the record and that will fire off the UpdateCreatedByUserProfile Trigger before insert.                                                                        
    insert sdi;
    
    // We need a Closed Status ID 
    string Status  = [SELECT Id FROM BMCServiceDesk__Status__c where BMCServiceDesk__appliesToIncident__c = true and Name = 'CLOSED' limit 1 ].Id;
    sdi.BMCServiceDesk__FKStatus__c = Status;
    update sdi;
    
    }

}