public class TestFor_updateCItoPR_Links {
@isTest (SeeAllData = true)   
    public static void TestTriggers(){
    
    //We need a Configuration Item
      BMCServiceDesk__BMC_BaseElement__c BaseElement1 = 
          new BMCServiceDesk__BMC_BaseElement__c ( Name='TestForTrigger1',
                                                  BMCServiceDesk__Name__c = 'TestForTrigger Name1'); 
      insert BaseElement1;
      
    //We need a Configuration Item
      BMCServiceDesk__BMC_BaseElement__c BaseElement2 = 
          new BMCServiceDesk__BMC_BaseElement__c ( Name='TestForTrigger2',
                                                  BMCServiceDesk__Name__c = 'TestForTrigger Name2'); 
      insert BaseElement2;

    //We need a problem record
      BMCServiceDesk__Problem__c ProblemRecord = 
      new BMCServiceDesk__Problem__c ( BMCServiceDesk__Problem_Description__c = 'test',
                                       FKBMC_BaseElement__c = BaseElement1.Id,
                                       OwnerId = [select id from group where type = 'queue' and (not name like 'Do Not Use%') limit 1].id
                                      );
      Insert ProblemRecord;  

    //At this piont we achieve 100% on createNewCItoPR_Link
    //Now we need to update with new CI
      
      ProblemRecord.FKBMC_BaseElement__c = BaseElement2.Id;
      Update ProblemRecord;        
    
    
    
    
    
    

    }

}