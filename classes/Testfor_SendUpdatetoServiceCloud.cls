@isTest (SeeAllData = true)

public class Testfor_SendUpdatetoServiceCloud  {

     public static testmethod void TestTriggers(){
            
            Profile p = [select id from profile where name='API'];
            
            User APIuser = [SELECT id
                            From User
                            WHERE ProfileID = :p.Id 
                            AND IsActive = true limit 1];
                            
            BMCServiceDesk__Category__c cat = new BMCServiceDesk__Category__c ( Name = 'TIB_TEST_CATEGORY_UpdateTrigger',
                                                                                                                                                         BMCServiceDesk__AvailableForIncidents__c = true
                                                                                                                                                     );
            Insert cat;   
      
            BMCServiceDesk__Impact__c impt  = new BMCServiceDesk__Impact__c ( Name = 'TIB_TEST_IMPACT_UpdateTrigger' );                                           
            Insert impt;

            BMCServiceDesk__Urgency__c urgy = new BMCServiceDesk__Urgency__c ( Name = 'TIB_TEST_URGENCY_UpdateTrigger' );                                           
            Insert urgy;

            BMCServiceDesk__BMC_BaseElement__c CI = [ Select Name
                                                                                                     FROM BMCServiceDesk__BMC_BaseElement__c
                                                                                                     LIMIT 1];

            BMCServiceDesk__Incident__c IR = new BMCServiceDesk__Incident__c( BMCServiceDesk__FKCategory__c = cat.Id,
                                                                              BMCServiceDesk__FKImpact__c = impt.Id,
                                                                              BMCServiceDesk__FKUrgency__c =urgy.Id,
                                                                              BMCServiceDesk__contactType__c = 'ServiceCloud',
                                                                              BMCServiceDesk__FKBMC_BaseElement__c = CI.Id,
                                                                              Cause_Code__c = 'TIBCO',
                                                                              Resolution_Code__c = 'TIBCO',
                                                                              BMCServiceDesk__incidentResolution__c = 'TIBCO Re',
                                                                              BMCServiceDesk__FKOpenBy__c = APIuser.Id
                                                                             );
            Insert IR;

            String q = [SELECT id
                       From Group
                       WHERE Type = 'Queue' and DeveloperName != null limit 1].Id;
            IR.OwnerID = q;
            GroupMember s = [Select UserOrGroupId From GroupMember where GroupId =:IR.OwnerID LIMIT 1];
            IR.BMCServiceDesk__FKOpenBy__c = s.UserOrGroupId;
            
            //Need any status code that is State of False
            BMCServiceDesk__Status__c AnyClosedStat = [ SELECT Name
                                                                                                    FROM BMCServiceDesk__Status__c
                                                                                                    WHERE IsDeleted = false
                                                                                                    AND BMCServiceDesk__appliesToIncident__c = true
                                                                                                    AND BMCServiceDesk__state__c = false
                                                                                                    LIMIT 1 ];
            IR.BMCServiceDesk__FKStatus__c = AnyClosedStat.Id;
          
          Test.setMock(WebServiceMock.class, new UpdateWebserviceMockImpl());
          Test.startTest();
          Update IR;
          Test.stopTest();
 
    }

}