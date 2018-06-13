@isTest (SeeAllData = true)

public class EmailToIncidentNew_Test  {
    
    static testMethod void EmailToIncidentNew_Test() {
        
        // create a new email and envelope object
        Messaging.InboundEmail email = new Messaging.InboundEmail() ;
        Messaging.InboundEnvelope env = new Messaging.InboundEnvelope();
        
        // setup the data for the email
        email.subject = 'Test Job Applicant [impact=LOW][urgency=LOW][queuename=RemedyForce_Support][category=Application][opsmonitor=true]';
        email.fromname = 'FirstName LastName';
        env.fromAddress = 'someaddress@email.com';
        
        // add an attachment
        Messaging.InboundEmail.BinaryAttachment attachment = new Messaging.InboundEmail.BinaryAttachment();
        attachment.body = blob.valueOf('my attachment text');
        attachment.fileName = 'textfile.txt';
        attachment.mimeTypeSubType = 'text/plain';
        
        email.binaryAttachments =
            new Messaging.inboundEmail.BinaryAttachment[] { attachment };
                
                // call the email service class and test it with the data in the testMethod
                EmailToIncidentNew emailProcess = new EmailToIncidentNew();
        emailProcess.handleInboundEmail(email, env);
        
        // query for the incident the email service created
        BMCServiceDesk__Incident__c incident = [select id, Incident_Title__c, BMCServiceDesk__incidentDescription__c from BMCServiceDesk__Incident__c
                           where Incident_Title__c = 'Test Job Applicant'];
        
        System.assertEquals(incident.Incident_Title__c,'Test Job Applicant');
        
        // find the attachment
        Attachment a = [select name from attachment where parentId = :incident.id];
        
        System.assertEquals(a.name,'textfile.txt');
        
    }
}