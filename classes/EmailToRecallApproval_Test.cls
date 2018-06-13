@isTest (SeeAllData = true)

public class EmailToRecallApproval_Test  {
    
    static testMethod void EmailToRecallApproval_Test() {
        
        // create a new email and envelope object
        Messaging.InboundEmail email = new Messaging.InboundEmail() ;
        Messaging.InboundEnvelope env = new Messaging.InboundEnvelope();
        
        BMCServiceDesk__Incident__c incident = [select id from BMCServiceDesk__Incident__c where BMCServiceDesk__Status_ID__c = 'PENDING APPROVAL' limit 1];
                
        // setup the data for the email
        email.subject = incident.id;
        email.plainTextBody = 'Test Comments';
        email.fromname = 'FirstName LastName';
        env.fromAddress = 'someaddress@email.com';
        
        // call the email service class and test it with the data in the testMethod
        EmailToRecallApproval emailProcess = new EmailToRecallApproval();
        emailProcess.handleInboundEmail(email, env);
        
    }
}