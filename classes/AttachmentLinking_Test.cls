@isTest (SeeAllData = true)
public class AttachmentLinking_Test {
    
    public static testmethod void AttachmentLinking() {
        
        Id p=[SELECT ActorId FROM ProcessInstanceWorkitem LIMIT 1].ActorId;
        user u=[select id from User where Id = :p limit 1];
        Id incidentID = [Select Id From BMCServiceDesk__Incident__c Limit 1].Id;
        
        System.runAs(u) {
            //Instantiate and construct the controller class.   
            AttachmentLinking controller = new AttachmentLinking();
            controller.parentId = incidentID;
            controller.getattachmentsbyir();
        }
    }
}