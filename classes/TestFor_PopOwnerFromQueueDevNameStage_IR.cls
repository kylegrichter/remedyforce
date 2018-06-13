@isTest (SeeAllData = true)

public class TestFor_PopOwnerFromQueueDevNameStage_IR {

   public static testmethod void TestTriggers(){

   
      Group Queue  = [ SELECT DeveloperName FROM Group WHERE Type = 'Queue' Limit 1];    

         string QueueDevName = Queue.DeveloperName;

      // BMCServiceDesk__Category__c named TEST
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
                                               BMCServiceDesk__FKUrgency__c = URGENCY.Id,
                                               QueueDevName_Ownership_Stage__c = QueueDevName
                                              );
         Insert IR;
        }
  
    
  
}