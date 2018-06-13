/******************************************************************************
Name:  UpdatePRThroughWebServiceTest
Copyright © 2014  DexMedia Inc. 
==============================================================================
Purpose:                                                            
This is the Test Class which covers UpdatePRThroughWebService class with
all the Positive & Negative scenarios
==============================================================================
History                                                            
-------                                                            
VERSION     AUTHOR              DATE           DETAIL           FEATURES/CSR/TTP
------      ------              -----         ---------         -----------------
1.0       Guru Vattam          06/16/2014     Initial Development      
*****************************************************************************/
@isTest
private class UpdatePRThroughWebServiceTest {

    static testMethod void UpdatePRThroughWebServiceTest() {
       Group QueueGroup = new Group ( Name = 'TIBTEST_QUEUE',
                                     Type = 'Queue'
                                    );
        INSERT QueueGroup;
        
        QueueSobject Qobject = new QueueSobject(QueueId = QueueGroup.Id, SobjectType = 'BMCServiceDesk__Problem__c');
        System.runAs(new User(Id = UserInfo.getUserId())){
        insert Qobject;
        
        Profile p = [select id from profile where name='API'];
        User newuser = [SELECT id,Name,lastname,V_Z_ID_del__c 
                                       From User
                                       WHERE ProfileID = :p.Id 
                                       limit 1];
        newUser.lastname = 'Test User';
        newUser.V_Z_ID_del__c = 'vTIBTEST';
        newUser.IsActive=true;

        update newUser; 
        system.debug(':::::::::::'+newUser);
        System.runAs(newuser)
        {
        BMCServiceDesk__Category__c cat = new BMCServiceDesk__Category__c ( Name = 'TIB_TEST_CATEGORY');
        Insert cat;
        BMCServiceDesk__Impact__c impt  = 
          new BMCServiceDesk__Impact__c ( Name = 'TIB_TEST_IMPACT' );                                           
        Insert impt;
        BMCServiceDesk__Urgency__c urgy = 
          new BMCServiceDesk__Urgency__c ( Name = 'TIB_TEST_URGENCY' );                                           
        INSERT urgy; 

        BMCServiceDesk__BMC_BaseElement__c ConfigurationItem = 
        new BMCServiceDesk__BMC_BaseElement__c ( Name = 'TibcoApexTestClass',
                                                 BMCServiceDesk__Name__c = 'TibcoApexTestClass' );
  
        Insert ConfigurationItem;
        BMCServiceDesk__Status__c statusObj = new BMCServiceDesk__Status__c();
        statusObj.Name = 'TestOpened';
        statusObj.BMCServiceDesk__appliesToProblem__c = true;
        statusObj.BMCServiceDesk__inactive__c = false;
        insert statusObj;
        BMCServiceDesk__Priority__c priority = new BMCServiceDesk__Priority__c();
        priority.Name = '1'; 
        priority.BMCServiceDesk__FKImpact__c = impt.Id;
        priority.BMCServiceDesk__FKUrgency__c = urgy.Id;
        priority.BMCServiceDesk__description__c = 'Test';
        insert priority;  
        
        

            
        
        BMCServiceDesk__Problem__c PRObj = new BMCServiceDesk__Problem__c();
        PRObj.FKBMC_BaseElement__c = ConfigurationItem.id;
        PRObj.BMCServiceDesk__FKCategory__c = cat.id;
        PRObj.BMCServiceDesk__FKImpact__c = impt.id;
        PRObj.BMCServiceDesk__FKUrgency__c = urgy.id;
        PRObj.BMCServiceDesk__FKPriority__c = priority.Id;
        PRObj.BMCServiceDesk__FKStatus__c = statusObj.Id;
        PRObj.BMCServiceDesk__Problem_Description__c = 'Test';
        PRObj.BMCServiceDesk__shortDescription__c = 'Test';
        PRObj.OwnerId = [select id from group where type = 'queue' and (not name like 'Do Not Use%') limit 1].id;
        PRObj.BMCServiceDesk__Problem_Resolution__c = 'Test Resolution';
        insert PRObj;
        
        BMCServiceDesk__Problem__c ProblemObj = [select Id,Name from BMCServiceDesk__Problem__c where Id=:PRObj.id];
        
        
        update ProblemObj;
        
        UpdatePRThroughWebService.UpdatePRInfo UpdatePR = new UpdatePRThroughWebService.UpdatePRInfo();
          UpdatePR.PRNumber = ProblemObj.Name;
          UpdatePR.Description = 'Test Problem';
          UpdatePR.Resolution = 'Test Resolution';
          UpdatePR.ScrumTeam = 'Sales';
          UpdatePR.ConfigurationItem = 'TibcoApexTestClass';
          UpdatePR.Status = 'TestOpened';
          UpdatePR.Impact = 'TIB_TEST_IMPACT';
          UpdatePR.Urgency = 'TIB_TEST_URGENCY';
          UpdatePR.FalloutIndicator = True;
          UpdatePR.ChangeRecord = '';
          UpdatePR.MigratedBy = '';
          UpdatePR.ReleaseManagerNotes = '';
          UpdatePR.Checkoutby = '';
          UpdatePR.CheckoutDuration = '30 min';
          UpdatePR.Dependencies  = '';
          UpdatePR.Workaround = '';
          UpdatePR.RootCauseAnalysis = '';
          UpdatePR.RCASource = '';
          UpdatePR.RCAReasonCode = '';
          UpdatePR.Priority = '1';
          
        Id [] fixedSearchResults= new Id[1];
        fixedSearchResults[0] = ProblemObj.Id;
        Test.setFixedSearchResults(fixedSearchResults);
          
        Test.StartTest(); 
        UpdatePRThroughWebService.UpdatePR(UpdatePR) ; 
        Test.StopTest();   
           
          
        
        }
    }
}
}