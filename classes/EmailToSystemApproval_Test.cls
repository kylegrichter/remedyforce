@isTest (SeeAllData = true)

public class EmailToSystemApproval_Test  {
    
    static testMethod void EmailToSystemApproval_Test() {
        
        // create a new email and envelope object
        Messaging.InboundEmail email = new Messaging.InboundEmail() ;
        Messaging.InboundEnvelope env = new Messaging.InboundEnvelope();
        
        // setup the data for the email
        email.subject = 'Test Job Applicant';
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
                EmailToSystemApproval emailProcess = new EmailToSystemApproval();
        emailProcess.handleInboundEmail(email, env);

    }
}