@isTest (SeeAllData = true)
public class SRDDetailsList_Test {
    
    public static testmethod void SRDDetailsList() {
        
        user u=[select id from User where IsActive = true limit 1];
        Id incidentID = [SELECT Id FROM BMCServiceDesk__Incident__c WHERE BMCServiceDesk__Type__c = 'Service Request' LIMIT 1].Id;
        
        System.runAs(u) {
            SRDDetailsList controller = new SRDDetailsList();
            controller.serviceRequestId = incidentID;
            controller.getrequestdetailinputsbyir();
        }
    }
}