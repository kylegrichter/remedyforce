trigger Ops_Monitor_Notify on BMCServiceDesk__Incident__c ( before update ) {
    for (BMCServiceDesk__Incident__c IR : Trigger.new){
        
     IF ( IR.Ops_Monitor__c == true && IR.BMCServiceDesk__state__c == false ||
     IR.Ops_Monitor__c == true && IR.BMCServiceDesk__Status_ID__c == 'CLOSED' ||
     IR.Ops_Monitor__c == true && IR.BMCServiceDesk__Status_ID__c == 'NO CONTACT/CLOSED' ||
     IR.Ops_Monitor__c == true && IR.BMCServiceDesk__Status_ID__c == 'COMPLETED' ||
     IR.Ops_Monitor__c == true && IR.BMCServiceDesk__Status_ID__c == 'REJECTED'
        ){
     
         IR.Ops_Monitor__c = false;

     }
     
    }
    
}