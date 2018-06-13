@isTest (SeeAllData = true)

public class TestFor_Cust_Workflow_Controller_IR {

  public static testmethod void TestTriggers(){
   // BMCServiceDesk__Category__c named TEST
      BMCServiceDesk__Category__c CATEGORY = 
          new BMCServiceDesk__Category__c ( Name = 'TEST',
                                           BMCServiceDesk__AvailableForIncidents__c = true
                                           );
      Insert CATEGORY;
   // BMCServiceDesk__Impact__c named TEST
      BMCServiceDesk__Impact__c IMPACT = 
          new BMCServiceDesk__Impact__c ( Name = 'TEST' );                                           
     Insert IMPACT;

   // BMCServiceDesk__Impact__c named TEST
      BMCServiceDesk__Urgency__c URGENCY = 
          new BMCServiceDesk__Urgency__c ( Name = 'TEST' );                                           
      INSERT URGENCY;     
   // BMCServiceDesk__Status__c 
      BMCServiceDesk__Status__c STATUS =
          new BMCServiceDesk__Status__c ( Name = 'TEST1',
                                          BMCServiceDesk__appliesToIncident__c = true
                                         );
      INSERT STATUS;  
   
   // Create an IR
      BMCServiceDesk__Incident__c IR = 
          new BMCServiceDesk__Incident__c ( BMCServiceDesk__FKCategory__c = CATEGORY.Id,
                                            BMCServiceDesk__FKImpact__c = IMPACT.Id,
                                            BMCServiceDesk__FKUrgency__c = URGENCY.Id,
                                            Custom_Workflow_Controller__c = 'StatusUpdate:TEST1'
                                           );
      Insert IR;
      Update IR;
  
  }
}