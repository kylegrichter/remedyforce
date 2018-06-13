global class EmailToIncidentLegalHold implements Messaging.InboundEmailHandler {
    
    global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email, Messaging.InboundEnvelope envelope) {
        
        Messaging.InboundEmailResult result = new Messaging.InboundEmailresult();
        BMCServiceDesk__Incident__c incident = new BMCServiceDesk__Incident__c();
        
        String queueLookup = email.subject.substringAfter('=');
        String subject = email.subject;

        String impact = 'MEDIUM';
        System.debug('====> impact '+impact);
        
        String urgency = 'MEDIUM';
        System.debug('====> urgency '+urgency);
        
        String queuename = 'Legal_Hold';
        System.debug('====> queuename '+queuename);
        
        String category = 'Security';
        System.debug('====> category '+category);
        
        String opsmonitor = 'false';
        System.debug('====> opsmonitor '+opsmonitor);
                
        BMCServiceDesk__Impact__c ir_impact = [ SELECT id, Name FROM BMCServiceDesk__Impact__c WHERE Name = :impact ];
        BMCServiceDesk__Urgency__c ir_urgency = [ SELECT id, Name FROM BMCServiceDesk__Urgency__c WHERE Name = :urgency ];
        User APIUser = [SELECT id, Name FROM USER WHERE Name = 'RemForce API'];
        GROUP ir_queue = [SELECT id, Name, DeveloperName FROM GROUP WHERE DeveloperName = :queuename];
        BMCServiceDesk__Category__c ir_category = [SELECT id, Name FROM BMCServiceDesk__Category__c WHERE Name = :category];
        
        incident.Incident_Title__c = email.subject.substringBefore('[');
        incident.BMCServiceDesk__incidentDescription__c = email.plainTextBody;
        incident.BMCServiceDesk__FKCategory__c = ir_category.id;
        incident.BMCServiceDesk__FKImpact__c = ir_impact.id;
        incident.BMCServiceDesk__FKUrgency__c = ir_urgency.id;
        incident.OwnerID = ir_queue.id;
        incident.BMCServiceDesk__contactType__c = 'Email';
        incident.Ops_Monitor__c = Boolean.valueOf(opsmonitor);
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
        
        if (email.textAttachments != null && email.textAttachments.size() > 0) {
            for (integer i = 0 ; i < email.textAttachments.size() ; i++) {
                Attachment attachment = new Attachment();
                // attach to the newly created incident record
                attachment.ParentId = incident.id;
                attachment.Name = email.textAttachments[i].filename;
                attachment.Body = Blob.valueOf(email.textAttachments[i].body);
                insert attachment;
            }
        }
        
        return result;
        
    }
    
}