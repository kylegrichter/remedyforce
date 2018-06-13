trigger Modify_QueueMember on BMCServiceDesk__Incident__c ( before update ) {

   for ( BMCServiceDesk__Incident__c IR : Trigger.new ){

       if ( IR.QueueMember_Request_Detail_Input__c != null ){
           
           // Get Queue ID from DevName Input
           String QueueDevName = IR.QueueMember_Request_Detail_Input__c;
           
           Group GroupRecord = [ SELECT Id, Name 
                                 FROM Group 
                                 WHERE DeveloperName = :QueueDevName ];

           //Create GroupMember record
           string UserID  = IR.BMCServiceDesk__FKClient__c;
           string GroupID = GroupRecord.ID;
                          
           if ( IR.Trigger_Create_QueueMember_Workflow__c == true ){
               

               
               Custom_GroupMember_Controller.CreateMemberRcd( UserID, GroupID );
               
               // Set the field on the IR to false
               IR.Trigger_Create_QueueMember_Workflow__c = false;
               
               // Update the resolution field
               IR.BMCServiceDesk__incidentResolution__c = 'Your ID was added to the ' + GroupRecord.Name + ' queue via an automated process. If you believe there was a mistake please contact DL-IT RemedyForce and provide this Record Number.';
               
           }
           else if( IR.Trigger_Remove_QueueMember_Workflow__c == true){

               //   Call the Remove Modify Queue method
               Custom_GroupMember_Controller.RemoveMemberRcd( UserID, GroupID );
               
               //   Set the field on the IR to false
               IR.Trigger_Remove_QueueMember_Workflow__c = false;

               // Update the resolution field
               IR.BMCServiceDesk__incidentResolution__c = 'Your ID was removed from the ' + GroupRecord.Name + ' queue via an automated process. If you believe there was a mistake please contact DL-IT RemedyForce and provide this Record Number.';
               
           }

 

       }


   }
    
      
}