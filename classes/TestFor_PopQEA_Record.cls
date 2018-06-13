@isTest (SeeAllData = true)

public class TestFor_PopQEA_Record {

  public static testmethod void TestTriggers(){
   
   // BMCServiceDesk__Category__c named TEST
      BMCServiceDesk__Category__c CATEGORY = 
          new BMCServiceDesk__Category__c ( Name = 'PopQEA_Record',
                                           BMCServiceDesk__AvailableForIncidents__c = true
                                           );
      Insert CATEGORY;
   // BMCServiceDesk__Impact__c named TEST
      BMCServiceDesk__Impact__c IMPACT = 
          new BMCServiceDesk__Impact__c ( Name = 'PopQEA_Record' );                                           
     Insert IMPACT;

   // BMCServiceDesk__Impact__c named TEST
      BMCServiceDesk__Urgency__c URGENCY = 
          new BMCServiceDesk__Urgency__c ( Name = 'PopQEA_Record' );                                           
      INSERT URGENCY;     
   // BMCServiceDesk__Status__c 
      BMCServiceDesk__Status__c STATUS =
          new BMCServiceDesk__Status__c ( Name = 'PopQEA_Record',
                                          BMCServiceDesk__appliesToIncident__c = true
                                         );
      INSERT STATUS;  
   
   // Create an IR for If Update
      BMCServiceDesk__Incident__c IR = 
          new BMCServiceDesk__Incident__c ( BMCServiceDesk__FKCategory__c = CATEGORY.Id,
                                            BMCServiceDesk__FKImpact__c = IMPACT.Id,
                                            BMCServiceDesk__FKUrgency__c = URGENCY.Id
                                           );
      Insert IR;

      
      //Get any queue name
      Group Queue = [ SELECT Id 
                      FROM Group
                      WHERE Type = 'Queue'
                      limit 1 ];
      
      IR.OwnerID = Queue.Id; 
      Update IR;
 
   // Create an IR for If Insert
      BMCServiceDesk__Incident__c IR2 = 
          new BMCServiceDesk__Incident__c ( BMCServiceDesk__FKCategory__c = CATEGORY.Id,
                                            BMCServiceDesk__FKImpact__c = IMPACT.Id,
                                            BMCServiceDesk__FKUrgency__c = URGENCY.Id,
                                            OwnerID = Queue.Id 
                                           );
      Insert IR2;

 
 
 
        
  }
  
}