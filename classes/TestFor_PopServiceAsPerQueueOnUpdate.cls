@isTest (SeeAllData = true)

public class TestFor_PopServiceAsPerQueueOnUpdate {

  public static testmethod void TestTriggers(){

    //Get BusinessService Class ID           
    BMCServiceDesk__CMDB_Class__c BS_Class = [SELECT Id 
                                             FROM BMCServiceDesk__CMDB_Class__c
                                             WHERE BMCServiceDesk__ClassID__c = 'BMC_BUSINESSSERVICE'
                                             limit 1 ];               
    //Create Business Service
    BMCServiceDesk__BMC_BaseElement__c BE_BusinessService = 
        new BMCServiceDesk__BMC_BaseElement__c ( Name = 'PopServiceAsPerQueueOnUpdate',
                                                 BMCServiceDesk__Name__c = 'PopServiceAsPerQueueOnUpdate',
                                                 BMCServiceDesk__CMDB_Class__c =  BS_CLass.Id  );
    Insert BE_BusinessService;

    //Create an entry for Queue_Extended_Attributes__c
    Queue_Extended_Attributes__c QEA = 
         new Queue_Extended_Attributes__c ( Queue_Name__c = 'ServiceAsPerQueueOnUpdate',
                                          SLA_Service_Name__c = BE_BusinessService.Id 
                                         );
    Insert QEA;
    
   
   // BMCServiceDesk__Category__c named TEST
      BMCServiceDesk__Category__c CATEGORY = 
          new BMCServiceDesk__Category__c ( Name = 'TESTServiceAsPerQueueOnUpdate',
                                           BMCServiceDesk__AvailableForIncidents__c = true
                                           );
      Insert CATEGORY;
   // BMCServiceDesk__Impact__c named TEST
      BMCServiceDesk__Impact__c IMPACT = 
          new BMCServiceDesk__Impact__c ( Name = 'TESTServiceAsPerQueueOnUpdate' );                                           
     Insert IMPACT;

   // BMCServiceDesk__Impact__c named TEST
      BMCServiceDesk__Urgency__c URGENCY = 
          new BMCServiceDesk__Urgency__c ( Name = 'TESTServiceAsPerQueueOnUpdate' );                                           
      INSERT URGENCY;     
   // BMCServiceDesk__Status__c 
      BMCServiceDesk__Status__c STATUS =
          new BMCServiceDesk__Status__c ( Name = 'TESTServiceAsPerQueueOnUpdate',
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

      
      //Get a queue name that will allways exists and have SLA
      Group Queue = [SELECT Id 
                     FROM Group
                     WHERE Name = 'RemedyForce Support'
                     limit 1];
      
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