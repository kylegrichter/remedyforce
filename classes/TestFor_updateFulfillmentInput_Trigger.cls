@isTest (SeeAllData = true)   
public class TestFor_updateFulfillmentInput_Trigger {

  public static testmethod void TestTriggers(){
  
  // First we need a RequestDefinition__c
  string RD = [SELECT Id FROM BMCServiceDesk__SRM_RequestDefinition__c limit 1 ].Id;
  
  
  // We need to create a fullfillment input record
  BMCServiceDesk__SRM_FulfillmentInputs__c FI = 
     new BMCServiceDesk__SRM_FulfillmentInputs__c (Update_Picklist__c = true, 
                                BMCServiceDesk__ResponseType__c = 'Picklist',
                            BMCServiceDesk__FKRequestDefinition__c = RD,
                            InputValue_Staging__c = 'YesфYesфfalseПNoфNoфfalse' );
  
  Insert FI;
  Update FI;
  
  }


}