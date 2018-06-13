global class EmailToIncidentNew implements Messaging.InboundEmailHandler {
    
    global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email, Messaging.InboundEnvelope envelope) {
        
        Messaging.InboundEmailResult result = new Messaging.InboundEmailresult();
        BMCServiceDesk__Incident__c incident = new BMCServiceDesk__Incident__c();
        
        String queueLookup = email.subject.substringAfter('=');
        String subject = email.subject;
        
        Integer startherei = subject.indexOf('[impact=')+7;
        Integer endherei = subject.indexOf(']',startherei);
        startherei ++;        
        String impact = subject.substring(startherei,endherei);
        System.debug('====> impact '+impact);
        
        Integer starthereu = subject.indexOf('[urgency=')+8;
        Integer endhereu = subject.indexOf(']',starthereu);
        starthereu ++;        
        String urgency = subject.substring(starthereu,endhereu);
        System.debug('====> urgency '+urgency);
        
        Integer starthereq = subject.indexOf('[queuename=')+10;
        Integer endhereq = subject.indexOf(']',starthereq);
        starthereq ++;        
        String queuename = subject.substring(starthereq,endhereq);
        System.debug('====> queuename '+queuename);
        
        Integer startherec = subject.indexOf('[category=')+9;
        Integer endherec = subject.indexOf(']',startherec);
        startherec ++;        
        String category = subject.substring(startherec,endherec);
        System.debug('====> category '+category);
        
        Integer starthereo = subject.indexOf('[opsmonitor=')+11;
        Integer endhereo = subject.indexOf(']',starthereo);
        starthereo ++;        
        String opsmonitor = subject.substring(starthereo,endhereo);
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
        
        return result;
        
    }
    
}