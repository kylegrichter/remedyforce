trigger Cust_Workflow_Controller on BMCServiceDesk__Incident__c ( before update ) {

  for ( BMCServiceDesk__Incident__c IR : Trigger.new){
   if ( IR.Custom_Workflow_Controller__c != null ){
       if ( IR.Custom_Workflow_Controller__c.contains('StatusUpdate') ){
           List<string> StatusUpdate = IR.Custom_Workflow_Controller__c.Split(':'); 
          
          String SetStatus = StatusUpdate.get(1);
 
          BMCServiceDesk__Status__c UPDATE_STATUS = [SELECT Id 
                                                     FROM BMCServiceDesk__Status__c
                                                     WHERE Name = :SetStatus limit 1 ];

            IR.BMCServiceDesk__FKStatus__c = UPDATE_STATUS.Id;

       }

       IR.Custom_Workflow_Controller__c = null;

  }
 } 
}