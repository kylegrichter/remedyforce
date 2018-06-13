@ isTest(SeeAllData=true)

public class TestFor_PopulateQueueExtendedAttr {
    
    public static testmethod void testTriggers()
    {
           BMCServiceDesk__Category__c CATEGORY = 
             new BMCServiceDesk__Category__c ( Name = 'UserProfileTestTEST',
                                               BMCServiceDesk__AvailableForIncidents__c = true
                                              );
         Insert CATEGORY;
      
      // BMCServiceDesk__Impact__c named TEST
         BMCServiceDesk__Impact__c IMPACT = 
             new BMCServiceDesk__Impact__c ( Name = 'UserProfileTestTEST' );                                           
         Insert IMPACT;
   
      // BMCServiceDesk__Impact__c named TEST
         BMCServiceDesk__Urgency__c URGENCY = 
             new BMCServiceDesk__Urgency__c ( Name = 'UserProfileTestTEST' );                                           
         Insert URGENCY;  
      
      // Create an IR
         BMCServiceDesk__Incident__c IR = 
             new BMCServiceDesk__Incident__c ( BMCServiceDesk__FKCategory__c = CATEGORY.Id,
                                               BMCServiceDesk__FKImpact__c = IMPACT.Id,
                                               BMCServiceDesk__FKUrgency__c = URGENCY.Id
                                              );
         Insert IR;
        
        IR.OwnerId='00GE0000000fOnc';
        update IR;
        
        Test.StartTest();
        
        BMCServiceDesk__Incident__c IR1 = 
             new BMCServiceDesk__Incident__c ( BMCServiceDesk__FKCategory__c = CATEGORY.Id,
                                               BMCServiceDesk__FKImpact__c = IMPACT.Id,
                                               BMCServiceDesk__FKUrgency__c = URGENCY.Id
                                              );
         IR1.ownerId='00GE0000000fOnc' ;                                   
         Insert IR1;
         
         Test.StopTest();
        
        
    }

}