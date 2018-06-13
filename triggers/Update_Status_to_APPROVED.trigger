trigger Update_Status_to_APPROVED on BMCServiceDesk__Change_Request__c ( before update ) {

  for ( BMCServiceDesk__Change_Request__c CR : Trigger.new){
  
       if ( CR.UpdateStatusToApproved__c ){
          BMCServiceDesk__Status__c APPROVED_STATUS = [SELECT Id 
                                                          FROM BMCServiceDesk__Status__c
                                                          WHERE Name = 'APPROVED' limit 1 ];

            CR.BMCServiceDesk__FKStatus__c = APPROVED_STATUS.Id;

       }

       CR.UpdateStatusToApproved__c = false;

  }
  
}