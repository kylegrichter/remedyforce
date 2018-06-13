trigger SendUpdatetoServiceCloud on BMCServiceDesk__Incident__c (after update) {
   
   for (BMCServiceDesk__Incident__c IR : Trigger.new ){
       if( IR.BMCServiceDesk__state__c == false &&
           IR.BMCServiceDesk__contactType__c == 'Service Cloud' ){
           
           updateStatusController.updateStatus( ir.name, ir.BMCServiceDesk__Status_ID__c, ir.Id );    
         

       }

    }
    
}