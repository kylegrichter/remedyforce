trigger PopulateQueueExtendedAttr on BMCServiceDesk__Incident__c (before insert, before update) {
    System.Debug('START PopulateQueueExtendedAttr'); 
    Map<Id, String> GROUP_MAP = new Map<Id, String>();
    List<Group> Glist =[SELECT DeveloperName, Id FROM Group];
    for ( Group Q : Glist ){
        GROUP_MAP.put( Q.Id, Q.DeveloperName );
    }
    Map<String, Queue_Extended_Attributes__c> qeamap = new Map<String, Queue_Extended_Attributes__c>();
    List<Queue_Extended_Attributes__c> li = [SELECT Queue_Name__c, Id, Name, Queue_group__c FROM Queue_Extended_Attributes__c];
    for(Queue_Extended_Attributes__c qealst: li){
        qeamap.put(qealst.Queue_Name__c,qealst);
    }
    
    for ( BMCServiceDesk__Incident__c IR : Trigger.new){
        string OwnerIR = IR.OwnerID;
        string QueueDevName = GROUP_MAP.get(OwnerIR);
        if ( OwnerIR.startsWith('00G') ){
            if(Trigger.isInsert && Trigger.isBefore){
                if ( qeamap.containsKey(QueueDevName) ){
                    IR.Queue_Extended_Attributes__c = qeamap.get(QueueDevName).Id;
                    if(qeamap.get(QueueDevName) != null){
                        IR.Queue_Group__c=qeamap.get(QueueDevName).Queue_group__c;
                    }
                }
            } else {
                if ( trigger.newMap.get(IR.id).OwnerID != trigger.oldMap.get(IR.id).OwnerID ){                   
                    if ( qeamap.containsKey(QueueDevName) ){
                        IR.Queue_Extended_Attributes__c = qeamap.get(QueueDevName).Id;
                        if(qeamap.get(QueueDevName) != null){
                            IR.Queue_Group__c=qeamap.get(QueueDevName).Queue_group__c;
                        }
                    }
                }
            }
        }
    }
    System.Debug('END PopulateQueueExtendedAttr');
}