trigger CopyAttachmentFromIncident on BMCServiceDesk__Task__c (after insert) {
    List<BMCServiceDesk__Task__c> TaskList = new List<BMCServiceDesk__Task__c>();
    List<Id> IncList = new List<Id>();
    for ( BMCServiceDesk__Task__c TK : Trigger.new ){
        if ( TK.BMCServiceDesk__FKIncident__c != null ){
            TaskList.add(TK);
            IncList.add(TK.BMCServiceDesk__FKIncident__c);
        }
    }
    
    if ( TaskList.size() > 0 ) {
        Map<String, BMCServiceDesk__Incident__c> irmap = new Map<String, BMCServiceDesk__Incident__c>();
        List<BMCServiceDesk__Incident__c> li = [SELECT Id, Name, BMCServiceDesk__Type__c FROM BMCServiceDesk__Incident__c WHERE Id IN :IncList];
        List<Id> IncAttachList = new List<Id>();
        for(BMCServiceDesk__Incident__c irlst: li){
            irmap.put(irlst.Id,irlst);   
            IncAttachList.add(irlst.Id);
        }
        
        List<Attachment> at = [SELECT Id, Body, Description, Name, OwnerID, ParentId FROM Attachment WHERE ParentId IN :IncAttachList];
        
        for (BMCServiceDesk__Task__c TK : TaskList){
            if(TK.BMCServiceDesk__FKIncident__c != null){
                if( irmap.get(TK.BMCServiceDesk__FKIncident__c).BMCServiceDesk__Type__c == 'Service Request'){
                    List<Attachment> attachments = new List<Attachment>();
                    for(Attachment file : at) {
                        if ( file.ParentId == TK.BMCServiceDesk__FKIncident__c ){
                            Attachment newFile = file.clone();
                            newFile.ParentId = TK.Id;
                            attachments.add(newFile);
                        }
                    }
                    insert attachments;
                }
            }
        }
    }
}