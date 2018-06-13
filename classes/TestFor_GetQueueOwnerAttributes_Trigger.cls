@isTest (SeeAllData = true)
public class TestFor_GetQueueOwnerAttributes_Trigger {

  public static testmethod void TestTriggers(){
   // UserID
   Id APIUser = [SELECT Id
                 FROM USER
                 WHERE Name = 'RemForce API'].Id;
 
   // BMCServiceDesk__Category__c named TEST
      BMCServiceDesk__Category__c CATEGORY = 
          new BMCServiceDesk__Category__c ( Name = 'TEST_QEA',
                                           BMCServiceDesk__AvailableForIncidents__c = true
                                           );
      Insert CATEGORY;
   // BMCServiceDesk__Impact__c named TEST
      BMCServiceDesk__Impact__c IMPACT = 
          new BMCServiceDesk__Impact__c ( Name = 'TEST_QEA' );                                           
      Insert IMPACT;

   // BMCServiceDesk__Urgency__c named TEST
      BMCServiceDesk__Urgency__c URGENCY = 
          new BMCServiceDesk__Urgency__c ( Name = 'TEST_QEA' );                                           
      Insert URGENCY;                                     

   //---------------------------------------------------------
   // To Cover Queue Extended Attribute Record with 0 contacts 
   //---------------------------------------------------------

      Queue_Extended_Attributes__c QEA_0 = 
          new Queue_Extended_Attributes__c ( Queue_Name__c = 'TEST_QEA_0' );

      Insert QEA_0;
  
      //Create an IR 
      BMCServiceDesk__Incident__c IR_0 = 
          new BMCServiceDesk__Incident__c ( BMCServiceDesk__FKCategory__c = CATEGORY.Id,
                                            BMCServiceDesk__FKImpact__c   = IMPACT.Id,
                                            BMCServiceDesk__FKUrgency__c  = URGENCY.Id,
                                            BMCServiceDesk__FKClient__c   = APIUser,
                                            Queue_Owner_Controller__c     = 'TEST_QEA_0' 
                                           );
      Insert IR_0;

   //--------------------------------------------------------
   // To Cover Queue Extended Attribute Record with 1 contact 
   //--------------------------------------------------------

      Queue_Extended_Attributes__c QEA_1 = 
          new Queue_Extended_Attributes__c ( Queue_Name__c        = 'TEST_QEA_1',
                                             Primary_Contact__c   = APIUser );
      Insert QEA_1;

  
      //Create an IR 
      BMCServiceDesk__Incident__c IR_1 = 
          new BMCServiceDesk__Incident__c ( BMCServiceDesk__FKCategory__c = CATEGORY.Id,
                                            BMCServiceDesk__FKImpact__c   = IMPACT.Id,
                                            BMCServiceDesk__FKUrgency__c  = URGENCY.Id,
                                            BMCServiceDesk__FKClient__c   = APIUser,
                                            Queue_Owner_Controller__c     = 'TEST_QEA_1' 
                                           );
      Insert IR_1;

   //---------------------------------------------------------
   // To Cover Queue Extended Attribute Record with 2 contacts 
   //---------------------------------------------------------

      Queue_Extended_Attributes__c QEA_2 = 
          new Queue_Extended_Attributes__c ( Queue_Name__c        = 'TEST_QEA_2',
                                             Primary_Contact__c   = APIUser,
                                             Secondary_Contact__c = APIUser );
      Insert QEA_2;

  
      //Create an IR 
      BMCServiceDesk__Incident__c IR_2 = 
          new BMCServiceDesk__Incident__c ( BMCServiceDesk__FKCategory__c = CATEGORY.Id,
                                            BMCServiceDesk__FKImpact__c   = IMPACT.Id,
                                            BMCServiceDesk__FKUrgency__c  = URGENCY.Id,
                                            BMCServiceDesk__FKClient__c   = APIUser,
                                            Queue_Owner_Controller__c     = 'TEST_QEA_2' 
                                           );
      Insert IR_2;



  }

  
}