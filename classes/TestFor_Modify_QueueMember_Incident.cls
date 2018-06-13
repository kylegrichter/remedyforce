@isTest (SeeAllData = true)

public class TestFor_Modify_QueueMember_Incident {

   public static testmethod void TestTriggers(){

       // Do this to avoid MIXED_DML_OPERATION error
       User thisUser = [ select Id from User where Id = :UserInfo.getUserId() ];
       System.runAs ( thisUser ) {
      
           // Need to create a queue   
           Group TestQueue = new Group ( Name = 'TESTModify QueueMember',
                                         DeveloperName = 'TESTModify_QueueMember',
                                         Type = 'Queue' );
           Insert TestQueue;

        

       // Any Category available for an IR 
       BMCServiceDesk__Category__c CATEGORY = [ SELECT Id FROM 
                                                BMCServiceDesk__Category__c 
                                                WHERE BMCServiceDesk__AvailableForIncidents__c = true LIMIT 1 ];
 
       // Any Impact Value
       BMCServiceDesk__Impact__c IMPACT = [ SELECT Id 
                                            FROM BMCServiceDesk__Impact__c 
                                            WHERE BMCServiceDesk__inactive__c = false LIMIT 1 ];     
                                         
       // Any Urgency Value
       BMCServiceDesk__Urgency__c URGENCY = [ SELECT Id 
                                              FROM BMCServiceDesk__Urgency__c 
                                              WHERE BMCServiceDesk__inactive__c = false LIMIT 1 ];
                                              
       // Any Staff User                                                  
       User AnyStaffUser = [ SELECT Id
                             FROM User
                             WHERE BMCServiceDesk__IsStaffUser__c = True LIMIT 1 ];
       
       // Create an IR to Insert Queue Member
       BMCServiceDesk__Incident__c IR_1 = 
          new BMCServiceDesk__Incident__c ( BMCServiceDesk__FKCategory__c          = CATEGORY.Id,
                                            BMCServiceDesk__FKImpact__c            = IMPACT.Id,
                                            BMCServiceDesk__FKUrgency__c           = URGENCY.Id,
                                            QueueMember_Request_Detail_Input__c    = 'TESTModify_QueueMember',
                                            Trigger_Create_QueueMember_Workflow__c = true,                                            
                                            BMCServiceDesk__FKClient__c            = AnyStaffUser.Id 
                                           );
                                           
       // Create an IR to Remove Queue Member
       BMCServiceDesk__Incident__c IR_2 = 
          new BMCServiceDesk__Incident__c ( BMCServiceDesk__FKCategory__c          = CATEGORY.Id,
                                            BMCServiceDesk__FKImpact__c            = IMPACT.Id,
                                            BMCServiceDesk__FKUrgency__c           = URGENCY.Id,
                                            QueueMember_Request_Detail_Input__c    = 'TESTModify_QueueMember',
                                            Trigger_Remove_QueueMember_Workflow__c = true,                                            
                                            BMCServiceDesk__FKClient__c            = AnyStaffUser.Id 
                                           );



       Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator_200());
       Test.startTest();                      
    
       Insert IR_1;
       
       Insert IR_2;
       
       Test.stopTest();
       
       }
  
  
   }
  
}