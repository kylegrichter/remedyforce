trigger Status_Workflow_Task on BMCServiceDesk__Task__c (before insert, before update) {
    for ( BMCServiceDesk__Task__c TK : Trigger.new){
        if ( TK.Custom_Workflow_Controller__c != null ){
            if ( TK.Custom_Workflow_Controller__c.contains('StatusUpdate') ){
                List<string> StatusUpdate = TK.Custom_Workflow_Controller__c.Split(':'); 
                String SetStatus = StatusUpdate.get(1);
                BMCServiceDesk__Status__c UPDATE_STATUS = [SELECT Id FROM BMCServiceDesk__Status__c WHERE Name = :SetStatus limit 1 ];
                TK.BMCServiceDesk__FKStatus__c = UPDATE_STATUS.Id;
            }
            TK.Custom_Workflow_Controller__c = null;
        }
    } 
}