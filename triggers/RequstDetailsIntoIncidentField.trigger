trigger RequstDetailsIntoIncidentField on BMCServiceDesk__Incident__c ( before update ) {
  
  for (BMCServiceDesk__Incident__c IR : Trigger.new){
      if ( IR.BMCServiceDesk__ServiceRequest__c == 'Yes' &&
           IR.BMCServiceDesk__FKRequestDetail__c != null && 
           IR.Request_Detail_Inputs__c == null ) {
          
          ID RequestDetailID = IR.BMCServiceDesk__FKRequestDetail__c;
                    
          //Query RequestDetailInputs for FKRequestDetail_c
          List<BMCServiceDesk__SRM_RequestDetailInputs__c> srminput 
              = [SELECT BMCServiceDesk__Input__c, BMCServiceDesk__Response__c
                 FROM BMCServiceDesk__SRM_RequestDetailInputs__c
                 WHERE  BMCServiceDesk__FKRequestDetail__c = :RequestDetailID];                                                           
          
          String RequestInputs = '';
          
          for (BMCServiceDesk__SRM_RequestDetailInputs__c input : srminput ){
               RequestInputs = RequestInputs + input.BMCServiceDesk__Input__c 
                             + ': ' 
                             + input.BMCServiceDesk__Response__c 
                             + '\n';
                            
          }

          IR.Request_Detail_Inputs__c = RequestInputs;
          
          
      } 
  
  }
  
}