trigger Update_Status_with_Workflow on BMCServiceDesk__Change_Request__c ( before update ) {

  for ( BMCServiceDesk__Change_Request__c CR : Trigger.new){
  
       if ( CR.Set_Status_by_Workflow__c != null ){
          
          String SetStatus = CR.Set_Status_by_Workflow__c;
 
          BMCServiceDesk__Status__c UPDATE_STATUS = [SELECT Id 
                                                          FROM BMCServiceDesk__Status__c
                                                          WHERE Name = :SetStatus limit 1 ];

            CR.BMCServiceDesk__FKStatus__c = UPDATE_STATUS.Id;

       }

       CR.Set_Status_by_Workflow__c = null;

  }
  
}