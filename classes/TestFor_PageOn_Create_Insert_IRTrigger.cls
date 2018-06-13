@isTest (SeeAllData = true)

public class TestFor_PageOn_Create_Insert_IRTrigger {

  public static testmethod void TestTriggers(){  
  
     //BMCServiceDesk__Category__c named XMATTERS
     BMCServiceDesk__Category__c CATEGORY = 
          new BMCServiceDesk__Category__c ( Name = 'XMATTERS',
                                           BMCServiceDesk__AvailableForIncidents__c = true
                                           );
     Insert CATEGORY;
      
     BMCServiceDesk__Impact__c H_IMPACT = [ SELECT Id, Name
                                            FROM BMCServiceDesk__Impact__c 
                                            WHERE Name = 'HIGH' ];

     BMCServiceDesk__Impact__c L_IMPACT = [ SELECT Id, Name
                                            FROM BMCServiceDesk__Impact__c 
                                            WHERE Name = 'LOW' ];

     BMCServiceDesk__Urgency__c H_URGENCY = [ SELECT Id, Name
                                              FROM BMCServiceDesk__Urgency__c 
                                              WHERE Name = 'HIGH' ];

      //Get any queue name
     Group AnyQueue = [SELECT Id 
                       FROM Group
                       WHERE Type = 'Queue'
                       limit 1];
     

      // Create a P1 IR for PageOnCreate
     BMCServiceDesk__Incident__c IR_P1 = 
          new BMCServiceDesk__Incident__c ( BMCServiceDesk__FKCategory__c  = CATEGORY.Id,
                                            BMCServiceDesk__contactType__c = 'Spectrum',
                                            BMCServiceDesk__FKImpact__c    = H_IMPACT.Id,
                                            BMCServiceDesk__FKUrgency__c   = H_URGENCY.Id,
                                            OwnerID                        = AnyQueue.Id
                                           );

      // Create a P1 IR for PageOnCreate
     BMCServiceDesk__Incident__c IR_NotifyGroup = 
          new BMCServiceDesk__Incident__c ( BMCServiceDesk__FKCategory__c   = CATEGORY.Id,
                                            BMCServiceDesk__contactType__c  = 'Spectrum',
                                            BMCServiceDesk__FKImpact__c    = L_IMPACT.Id,
                                            BMCServiceDesk__FKUrgency__c   = H_URGENCY.Id,
                                            X_Matters_Notification_Group__c = 'Anyone',
                                            OwnerID                         = AnyQueue.Id
                                           );


     Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator_200());
     Test.startTest();
     Insert IR_P1;
     Insert IR_NotifyGroup;
     Test.stopTest();


  }
  
}