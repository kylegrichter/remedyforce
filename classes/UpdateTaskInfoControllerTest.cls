@isTest
private class UpdateTaskInfoControllerTest {

    static testMethod void UpdateTaskInfoControllerTest() {
        String TaskNmb;

        String sessionId = userInfo.getSessionId();
        String ServerUrl = URL.getSalesforceBaseUrl().toExternalForm()+'/services/Soap/c/23.0/'+UserInfo.getOrganizationId().subString(0,15);


        Group QueueGroup = new Group ( Name = 'TIBTEST_QUEUE',
                                     Type = 'Queue'
                                    );
      INSERT QueueGroup;
      
      QueueSobject Qobject = new QueueSobject(QueueId = QueueGroup.Id, SobjectType = 'BMCServiceDesk__Task__c');
      System.runAs(new User(Id = UserInfo.getUserId())){
        insert Qobject;
      }
      
        Profile p = [select id from profile where name='System Administrator'];
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
          new BMCServiceDesk__Category__c ( Name = 'TIB_TEST_CATEGORY');
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
      
      /* BMCServiceDesk__Priority__c priority = new BMCServiceDesk__Priority__c();
      priority.Name = '1'; 
      priority.BMCServiceDesk__FKImpact__c = impt.Id;
      priority.BMCServiceDesk__FKUrgency__c = urgy.Id;
      priority.BMCServiceDesk__description__c = 'Test';
      INSERT priority;  
      */
      BMCServiceDesk__Status__c statusObj = new BMCServiceDesk__Status__c();
        statusObj.Name = 'TestOpened';
        statusObj.BMCServiceDesk__appliesToTask__c = true;
        statusObj.BMCServiceDesk__inactive__c = false;
        insert statusObj; 
      
      BMCServiceDesk__Task__c TaskObj = new BMCServiceDesk__Task__c();
      TaskObj.BMCServiceDesk__FKCategory__c = cat.id;
      TaskObj.BMCServiceDesk__FKClient__c = newuser.id;
      TaskObj.OwnerId = QueueGroup.Id;
      TaskObj.BMCServiceDesk__FKImpact__c = impt.Id;
      TaskObj.BMCServiceDesk__FKUrgency__c = urgy.Id;
      TaskObj.BMCServiceDesk__taskDescription__c = 'Test';
      TaskObj.BMCServiceDesk__taskResolution__c = 'Test';
      TaskObj.BMCServiceDesk__FKStatus__c = statusObj.id;
      TaskObj.Configuration_Item__c = ConfigurationItem.Id;
      //TaskObj.BMCServiceDesk__FKPriority__c = priority.Id;
      
      insert TaskObj;
      
      BMCServiceDesk__Task__c TaskObbj = [select id, User_Story__c, Rally_URL__c from BMCServiceDesk__Task__c where id=:TaskObj.id];
      //system.debug('*****' +TaskObbj.name);
      TaskObbj.User_Story__c = '1111';
      TaskObj.Rally_URL__c = 'abc';
      
      Test.StartTest();
      Update TaskObbj;
      UpdateTaskInfoController.UpdateTaskInfo(TaskObbj.Id, sessionId, ServerUrl);
      Test.StopTest(); 
        
    }
    }
}