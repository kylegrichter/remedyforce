@isTest
private class Create_UpdateTaskWebServiceTest {

    static testMethod void CreateUpdateTaskWebServiceTest() {
    	String TaskNmb;
    	Group QueueGroup = new Group ( Name = 'TIBTEST_QUEUE',
                                     Type = 'Queue'
                                    );
      INSERT QueueGroup;
      
      QueueSobject Qobject = new QueueSobject(QueueId = QueueGroup.Id, SobjectType = 'BMCServiceDesk__Task__c');
      System.runAs(new User(Id = UserInfo.getUserId())){
        insert Qobject;
      }
      
        Profile p = [select id from profile where name='System Administrator'];
        User newuser = [SELECT id,Name,lastname From User
                                       WHERE ProfileID = :p.Id 
                                       limit 1];
        newUser.lastname = 'vTIBTEST';
        //newUser.V_Z_ID_del__c = 'vTIBTEST';
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
      
      
      BMCServiceDesk__Release__c releaseObj  =  new BMCServiceDesk__Release__c();  
      releaseObj.BMCServiceDesk__Release_Title__c = 'Test_Release';                                          
      Insert releaseObj;

      BMCServiceDesk__Urgency__c urgy = 
          new BMCServiceDesk__Urgency__c ( Name = 'TIB_TEST_URGENCY' );                                           
      INSERT urgy; 
      
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
      TaskObj.BMCServiceDesk__FKRelease__c = null;
      
      insert TaskObj;
      
      BMCServiceDesk__Task__c TaskObbj = [select name from BMCServiceDesk__Task__c where id=:TaskObj.id];
      system.debug('*****' +TaskObbj.name);

      
      Create_UpdateTaskWebService.CreateTask CreateTaskObj = new Create_UpdateTaskWebService.CreateTask();
        CreateTaskObj.OwnerId = 'TIBTEST_QUEUE';
	    CreateTaskObj.Category = 'TIB_TEST_CATEGORY';
	    CreateTaskObj.Impact = 'TIB_TEST_IMPACT';
	    CreateTaskObj.Urgency = 'TIB_TEST_URGENCY';
	    CreateTaskObj.UserId = 'vTIBTEST';
	    CreateTaskObj.Description = 'Test';
	    CreateTaskObj.IsActive = false;
	    CreateTaskObj.ConfigurationItem = 'TibcoApexTestClass';
	    CreateTaskObj.Status = 'TestOpened';
	    CreateTaskObj.RallyURL = '';
		CreateTaskObj.USNumber = '';
		CreateTaskObj.Release = null;
	
      Create_UpdateTaskWebService.UpdateTaskInfo UpdateTaskObj = new Create_UpdateTaskWebService.UpdateTaskInfo();
	    UpdateTaskObj.TskNumber = TaskObbj.name;
	    system.debug(':::::::::::'+UpdateTaskObj.TskNumber);
        UpdateTaskObj.Category = 'TIB_TEST_CATEGORY';
        UpdateTaskObj.impact = 'TIB_TEST_IMPACT';
        UpdateTaskObj.urgency = 'TIB_TEST_URGENCY';
        UpdateTaskObj.description = '';
        UpdateTaskObj.resolution = '';
        UpdateTaskObj.status = 'TestOpened';
        UpdateTaskObj.inactive = false;
        UpdateTaskObj.configurationItem = 'TibcoApexTestClass';
        UpdateTaskObj.Staff = 'vTIBTEST';
        UpdateTaskObj.Queue = '';
        UpdateTaskObj.USNumber = '';
        UpdateTaskObj.RalleyURL = '';
        UpdateTaskObj.Release = null;
		
        
        
      Test.StartTest();
      Create_UpdateTaskWebService.CreateTaskinRmdy(CreateTaskObj);
      Create_UpdateTaskWebService.UpdateTask(UpdateTaskObj);
      Test.StopTest(); 
        
    }
    }
}