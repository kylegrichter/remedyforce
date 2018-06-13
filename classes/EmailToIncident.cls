global class EmailToIncident implements Messaging.InboundEmailHandler {
    
    global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email, Messaging.InboundEnvelope envelope) {
        
        Messaging.InboundEmailResult result = new Messaging.InboundEmailresult();
        BMCServiceDesk__Incident__c incident = new BMCServiceDesk__Incident__c();
        
        String queueLookup = email.subject.substringAfter('=');
        BMCServiceDesk__Impact__c H_IMPACT = [ SELECT id, Name FROM BMCServiceDesk__Impact__c WHERE Name = 'HIGH' ];
		BMCServiceDesk__Urgency__c H_URGENCY = [ SELECT id, Name FROM BMCServiceDesk__Urgency__c WHERE Name = 'HIGH' ];
        User APIUser = [SELECT id, Name FROM USER WHERE Name = 'RemForce API'];
        GROUP Queue = [SELECT id, Name, DeveloperName FROM GROUP WHERE DeveloperName = :queueLookup];
        
        incident.Incident_Title__c = email.subject;
        incident.BMCServiceDesk__incidentDescription__c = email.plainTextBody;
        incident.BMCServiceDesk__FKCategory__c = 'a1DE0000000UYDL';
        incident.BMCServiceDesk__FKImpact__c = H_IMPACT.id;
        incident.BMCServiceDesk__FKUrgency__c = H_URGENCY.id;
        incident.OwnerID = Queue.id;
        incident.BMCServiceDesk__contactType__c = 'Email';
        incident.Ops_Monitor__c = true;
        incident.BMCServiceDesk__FKClient__c = APIUser.id;
        
        insert incident;
        
        System.debug('====> Created incident '+incident.id);
        
        if (email.binaryAttachments != null && email.binaryAttachments.size() > 0) {
            for (integer i = 0 ; i < email.binaryAttachments.size() ; i++) {
                Attachment attachment = new Attachment();
                // attach to the newly created incident record
                attachment.ParentId = incident.id;
                attachment.Name = email.binaryAttachments[i].filename;
                attachment.Body = email.binaryAttachments[i].body;
                insert attachment;
            }
        }
        
        return result;
        
    }
    
}