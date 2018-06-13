trigger PopulateClientIfOnBehalf on BMCServiceDesk__Incident__c (before insert) {
    System.Debug('START PopulateClientIfOnBehalf');
    for (BMCServiceDesk__Incident__c IR : Trigger.new){
        if(IR.On_Behalf_Of_Client__c != null){
            IR.BMCServiceDesk__FKClient__c = IR.On_Behalf_Of_Client__r.Id;
            IR.On_Behalf_Of_Client__c = null;
        }
    }
    System.Debug('END PopulateClientIfOnBehalf');
}