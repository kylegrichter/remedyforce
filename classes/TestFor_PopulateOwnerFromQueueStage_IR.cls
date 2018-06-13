@isTest (SeeAllData = true)

public class TestFor_PopulateOwnerFromQueueStage_IR {

   public static testmethod void TestTriggers(){

    
      Group Queue  = [ SELECT Name FROM Group WHERE Type = 'Queue' Limit 1];    
      Profile p    = [ SELECT Id from profile where name='SDS-ITInfrastructure' Limit 1];
      User newuser = [ SELECT Id, Name
                       FROM User
                       WHERE ProfileID = :p.Id 
                       AND IsActive = True
                       Limit 1];
                       
      newUser.Primary_Queue_Assignment__c = Queue.Name;
      newUser.IsActive=true;

      update newUser; 
      System.runAs(newuser){  
          
 
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
                                               BMCServiceDesk__FKUrgency__c = URGENCY.Id
                                              );
         Insert IR;
        }
  
    }
  
}