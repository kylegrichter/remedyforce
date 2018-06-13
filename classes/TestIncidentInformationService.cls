/******************************************************************************
Name:  TestIncidentInformationService
Copyright © 2013  DexMedia Inc. 
==============================================================================
Purpose:                                                            
This is the Test Class which covers IncidentInformation class with
all the Positive & Negative scenarios
==============================================================================
History                                                            
-------                                                            
VERSION     AUTHOR              DATE           DETAIL           FEATURES/CSR/TTP
------      ------              -----         ---------         -----------------
1.0     Guru R. Vattam    05/08/2013    Initial Development 
2.0     Jason D. Boyer    5/12/2013      Raised test coverage to 100% and included coverage for List in List loop by using fixedSearchResults test method.
*****************************************************************************/
@isTest(SeeAllData=true)

private class TestIncidentInformationService {
    
   static testMethod void TestIncidentInformationService(){

      Group QueueGroup = new Group ( Name = 'TIBTEST_QUEUE',
                                     Type = 'Queue'
                                    );
      INSERT QueueGroup;
      
      QueueSobject Qobject = new QueueSobject(QueueId = QueueGroup.Id, SobjectType = 'BMCServiceDesk__Incident__c');
      System.runAs(new User(Id = UserInfo.getUserId())){
        insert Qobject;
      }
   
        BMCServiceDesk__Incident__c AnyExistingIR = [SELECT Name,  BMCServiceDesk__Status_ID__c, BMCServiceDesk__contactType__c
                                                     FROM BMCServiceDesk__Incident__c
                                                     WHERE BMCServiceDesk__state__c = true
                                                     LIMIT 1];
        IncidentInformation.IncidentDescriptionList IncList = 
              new IncidentInformation.IncidentDescriptionList( AnyExistingIR.Name , 'Laptop', 
                                                               AnyExistingIR.BMCServiceDesk__Status_ID__c,
                                                               AnyExistingIR.BMCServiceDesk__contactType__c );
        
        Profile p = [select id from profile where name='API'];
        User newuser = [SELECT id,Name,lastname,V_Z_ID_del__c 
                                       From User
                                       WHERE ProfileID = :p.Id 
                                       limit 1];
        newUser.lastname = 'Test User';
        newUser.V_Z_ID_del__c = 'vTIBTEST';
        newUser.IsActive=true;

        update newUser; 
        System.runAs(newuser)
        {

      BMCServiceDesk__Category__c cat = 
          new BMCServiceDesk__Category__c ( Name = 'TIB_TEST_CATEGORY',
                                            BMCServiceDesk__AvailableForIncidents__c = true
                                           );
      Insert cat;

      BMCServiceDesk__BMC_BaseElement__c ConfigurationItem = 
        new BMCServiceDesk__BMC_BaseElement__c ( Name = 'TibcoApexTestClass',
                                                 BMCServiceDesk__Name__c = 'TibcoApexTestClass' );
  
      Insert ConfigurationItem;

 
      BMCServiceDesk__Impact__c impt  = 
          new BMCServiceDesk__Impact__c ( Name = 'TIB_TEST_IMPACT' );                                           
      Insert impt;

      BMCServiceDesk__Urgency__c urgy = 
          new BMCServiceDesk__Urgency__c ( Name = 'TIB_TEST_URGENCY' );                                           
      INSERT urgy;     
       
        BMCServiceDesk__Incident__c bmc = new BMCServiceDesk__Incident__c();
        
        bmc.BMCServiceDesk__FKCategory__c          = cat.Id;
        bmc.BMCServiceDesk__FKImpact__c            = impt.Id;
        bmc.BMCServiceDesk__FKUrgency__c           = urgy.Id;
        bmc.OwnerId                                = newUser.Id;
        bmc.BMCServiceDesk__FKClient__c            = newUser.Id;
        bmc.BMCServiceDesk__incidentDescription__c = 'Laptop Problem';
        
        
        insert bmc;
        //bmc.Name
        BMCServiceDesk__Incident__c inc = [select name from BMCServiceDesk__Incident__c where Id=:bmc.Id];

        IncidentInformation.IncidentInfoFields incInfo = new IncidentInformation.IncidentInfoFields();
        incInfo.Category         = 'Application'; 
        incInfo.Impact           = 'TIB_TEST_IMPACT';
        incInfo.Urgency          = 'TIB_TEST_URGENCY';
        incInfo.IncidentSource   = 'ServiceCloud';
        incInfo.OwnerId          = 'Remedyforce Support';
        incInfo.FedID            = 'vTIBTEST';
        incInfo.Description      = 'Test';
        incInfo.CustomerId       = '';
        incInfo.IncidentTitle    = '';
        incInfo.IR_Code_Group    = '';    
        incInfo.IR_Support_Group = '';
        incInfo.IR_CI            = 'TibcoApexTestClass';
                       
        Id [] fixedSearchResults= new Id[1];
        fixedSearchResults[0] = bmc.Id;
        Test.setFixedSearchResults(fixedSearchResults);        
    
        
        Test.StartTest();
        IncidentInformation.searchByNumber(inc.Name);
        IncidentInformation.searchByDescription('Laptop');
        IncidentInformation.InsertNewIncident(incInfo);
        Test.StopTest(); 



   }
   } 
 
}