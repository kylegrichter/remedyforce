trigger updateFulfillmentInput on BMCServiceDesk__SRM_FulfillmentInputs__c (before update) {

  for (BMCServiceDesk__SRM_FulfillmentInputs__c FI : Trigger.new){

      if ( FI.Update_Picklist__c && FI.BMCServiceDesk__ResponseType__c == 'Picklist' ){      
    string input = FI.InputValue_Staging__c;
      
        input = input.replace('||', 'ф');
        input = input.replace('{}', 'П');
      
        FI.BMCServiceDesk__InputValues__c = input;
        FI.InputValue_Staging__c = ''; 
      }
      
      FI.Update_Picklist__c = false;    

  }


}