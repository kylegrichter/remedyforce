trigger PopulateServiceAsPerQueueOnUpdate on BMCServiceDesk__Incident__c (before insert, before update) {
    System.Debug('START PopulateServiceAsPerQueueOnUpdate'); 
    List<BMCServiceDesk__Incident__c> IncidentList = new List<BMCServiceDesk__Incident__c>();
    for ( BMCServiceDesk__Incident__c IR : Trigger.new ){
        String Owner = IR.OwnerID;
        if ( IR.BMCServiceDesk__FKRequestDefinition__c == null && Owner.startsWith('00G') ){
            IncidentList.add(IR);
        }
    }
    
    if ( IncidentList.size() > 0 ) {
        Map<String, Id> SLAConf = new Map<String, Id>();
        List<Queue_Extended_Attributes__c>Qlist =  [SELECT Queue_Name__c, SLA_Service_Name__c FROM Queue_Extended_Attributes__c];
        for ( Queue_Extended_Attributes__c QEA : Qlist ){
            SLAConf.put( QEA.Queue_Name__c, QEA.SLA_Service_Name__c);
        }
        Map<Id, String> queueDevName = new Map<Id, String>();
        List<Group>Glist =  [SELECT Id, DeveloperName FROM Group];
        for ( Group groupName : Glist ){
            queueDevName.put( groupName.Id, groupName.DeveloperName);
        }
        for ( BMCServiceDesk__Incident__c IR : IncidentList ){
            string QueueName = queueDevName.get(IR.OwnerID);
            if(Trigger.isInsert && Trigger.isBefore && SLAConf.containsKey(QueueName)){
                IR.BMCServiceDesk__FKBusinessService__c = SLAConf.get(QueueName);
            } else if ( trigger.newMap.get(IR.id).OwnerID != trigger.oldMap.get(IR.id).OwnerID && SLAConf.containsKey(QueueName)){
                IR.BMCServiceDesk__FKBusinessService__c = SLAConf.get(QueueName);
            }
        }
    }   
    System.Debug('END PopulateServiceAsPerQueueOnUpdate');
}