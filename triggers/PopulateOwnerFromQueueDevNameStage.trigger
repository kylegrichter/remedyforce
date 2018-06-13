trigger PopulateOwnerFromQueueDevNameStage on BMCServiceDesk__Incident__c ( before insert, before update ) {
   
   for ( BMCServiceDesk__Incident__c IR : Trigger.new ){
         String IrNum = IR.Name;
      
         if ( IR.QueueDevName_Ownership_Stage__c != null ){
  
             string QStageName = IR.QueueDevName_Ownership_Stage__c;
   
             string UserQueueID = [ SELECT Id 
                                    FROM Group 
                                    WHERE Type = 'Queue' 
                                    AND DeveloperName = :QStageName limit 1].Id;
   
             IR.OwnerID = UserQueueID;
             IR.QueueDevName_Ownership_Stage__c = '';
   
   
         }
  
  
   }   
   
   
}