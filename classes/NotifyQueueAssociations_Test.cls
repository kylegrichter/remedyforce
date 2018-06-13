@isTest (SeeAllData = true)
public class NotifyQueueAssociations_Test {
    public static testmethod void NotifyQueueAssociations_Base(){
        
        //Use the PageReference Apex class to instantiate a page
        PageReference pageRef = Page.NotifyQueueAssociations;
        
        //In this case, the Visualforce page named 'success' is the starting point of this test method. 
        Test.setCurrentPage(pageRef);
        Test.setCurrentPageReference(pageRef);
        
        //Instantiate and construct the controller class.   
        NotifyQueueAssociations controller = new NotifyQueueAssociations();
        Queue_Notification_Association__c assocrecord1 = new Queue_Notification_Association__c();
        
        assocrecord1.Environment__c='PROD';
        assocrecord1.Association_Pattern_1__c='dfwabc';
        assocrecord1.Association_Pattern_2__c='df';
        assocrecord1.Association_Pattern_3__c='/';
        assocrecord1.Queue__c=[SELECT Id FROM Group LIMIT 1].id;
        assocrecord1.IsActive__c=true;
        assocrecord1.No_IR_Notification__c=false;
        assocrecord1.X_Matters_Notification_Group__c='OPSYS';
        assocrecord1.IR_Category__c=[SELECT Id FROM BMCServiceDesk__Category__c LIMIT 1].id;
        assocrecord1.Impact__c=[SELECT Id FROM BMCServiceDesk__Impact__c LIMIT 1].id;
        assocrecord1.Urgency__c=[SELECT Id FROM BMCServiceDesk__Urgency__c LIMIT 1].id;
        
        User usr = [Select id from User where Id = :UserInfo.getUserId()];
        System.RunAs(usr){insert assocrecord1;}
        
        controller.pattern1 = 'dfwsti-02';
        controller.pattern2 = 'df';
        controller.pattern3 = '/usr/bin';
        
        controller.getCIAssociationRecord();
        
        controller.pattern1 = 'dfwsti-02';
        controller.pattern2 = 'df';
        controller.pattern3 = null;
        
        controller.getCIAssociationRecord();
        
        controller.pattern1 = 'dfwsti-02';
        controller.pattern2 = 'df';
        controller.pattern3 = '/usr/bin';
        controller.queue = 'IT_Operations';
        controller.impact = 'LOW';
        controller.urgency = 'LOW';
        controller.configitem = 'VAST';
        controller.category = 'Server-Server';
        controller.ClientId = 'RemForce API';
        controller.opsMonitor = true;
        controller.title = 'Test';
        controller.description = 'Testing';
        controller.source = 'Spectrum';
		controller.xmatters = 'USS';

        controller.createIR();
        controller.LookupCreate();
        
        BMCServiceDesk__Incident__c AnyExistingIR = [SELECT Id, Name
                                                     FROM BMCServiceDesk__Incident__c 
                                                     LIMIT 1];
        
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator_200());
        Test.startTest();
        send2Xmatters.postTicketID(AnyExistingIR.ID);
        Test.stopTest();
    }
	public static testmethod void NotifyQueueAssociations_CreateTask_UseLookup() {
	//Use the PageReference Apex class to instantiate a page
        PageReference pageRef = Page.NotifyQueueAssociations;
        
        //In this case, the Visualforce page named 'success' is the starting point of this test method. 
        Test.setCurrentPage(pageRef);
        Test.setCurrentPageReference(pageRef);
        
        //Instantiate and construct the controller class.   
        NotifyQueueAssociations controller = new NotifyQueueAssociations();
        Queue_Notification_Association__c assocrecord1 = new Queue_Notification_Association__c();
        
        assocrecord1.Environment__c='PROD';
        assocrecord1.Association_Pattern_1__c='dfwabc';
        assocrecord1.Association_Pattern_2__c='df';
        assocrecord1.Association_Pattern_3__c='/';
        assocrecord1.Queue__c=[SELECT Id FROM Group LIMIT 1].id;
        assocrecord1.IsActive__c=true;
        assocrecord1.No_IR_Notification__c=false;
        assocrecord1.X_Matters_Notification_Group__c='OPSYS';
        assocrecord1.IR_Category__c=[SELECT Id FROM BMCServiceDesk__Category__c LIMIT 1].id;
        assocrecord1.Impact__c=[SELECT Id FROM BMCServiceDesk__Impact__c LIMIT 1].id;
        assocrecord1.Urgency__c=[SELECT Id FROM BMCServiceDesk__Urgency__c LIMIT 1].id;
        
        User usr = [Select id from User where Id = :UserInfo.getUserId()];
        System.RunAs(usr){insert assocrecord1;}
		
		pageRef.getParameters().put('targetObject', 'BMCServiceDesk__Task__c');
        pageRef.getParameters().put('Lookup', 'TRUE');
        pageRef.getParameters().put('Instance1', 'DFWSTI-02');
        pageRef.getParameters().put('Instance2', 'df');
        pageRef.getParameters().put('Incident_Title__c', 'Test');
        pageRef.getParameters().put('Description__c', 'Testing');
        Test.setCurrentPageReference(pageRef);
        
        controller.LookupCreate();
	}
	public static testmethod void NotifyQueueAssociations_CreateTask_LookupBlank() {	
	//Use the PageReference Apex class to instantiate a page
        PageReference pageRef = Page.NotifyQueueAssociations;
        
        //In this case, the Visualforce page named 'success' is the starting point of this test method. 
        Test.setCurrentPage(pageRef);
        Test.setCurrentPageReference(pageRef);
        
        //Instantiate and construct the controller class.   
        NotifyQueueAssociations controller = new NotifyQueueAssociations();
		
		pageRef.getParameters().put('targetObject', 'BMCServiceDesk__Task__c');
        pageRef.getParameters().put('BMCServiceDesk__FKCategory__c', 'Server-Server');
        pageRef.getParameters().put('Lookup', '');
        pageRef.getParameters().put('BMCServiceDesk__FKImpact__c', 'LOW');
        pageRef.getParameters().put('BMCServiceDesk__FKUrgency__c', 'LOW');
        pageRef.getParameters().put('OwnerId', 'RemedyForce_Support');
        pageRef.getParameters().put('ClientId', 'RemForce API');
        pageRef.getParameters().put('Incident_Title__c', 'Test');
        pageRef.getParameters().put('Description__c', 'Testing');
        pageRef.getParameters().put('ConfigItem', 'VAST');
        Test.setCurrentPageReference(pageRef);
        
        controller.LookupCreate();
	}
	public static testmethod void NotifyQueueAssociations_CreateTask_LookupBlank_WithDueDate() {	
	//Use the PageReference Apex class to instantiate a page
        PageReference pageRef = Page.NotifyQueueAssociations;
        
        //In this case, the Visualforce page named 'success' is the starting point of this test method. 
        Test.setCurrentPage(pageRef);
        Test.setCurrentPageReference(pageRef);
        
        //Instantiate and construct the controller class.   
        NotifyQueueAssociations controller = new NotifyQueueAssociations();
		
		pageRef.getParameters().put('targetObject', 'BMCServiceDesk__Task__c');
        pageRef.getParameters().put('BMCServiceDesk__FKCategory__c', 'Server-Server');
        pageRef.getParameters().put('Lookup', '');
        pageRef.getParameters().put('BMCServiceDesk__FKImpact__c', 'LOW');
        pageRef.getParameters().put('BMCServiceDesk__FKUrgency__c', 'LOW');
        pageRef.getParameters().put('OwnerId', 'RemedyForce_Support');
        pageRef.getParameters().put('ClientId', 'RemForce API');
        pageRef.getParameters().put('Incident_Title__c', 'Test');
        pageRef.getParameters().put('Description__c', 'Testing');
        pageRef.getParameters().put('ConfigItem', 'VAST');
		pageRef.getParameters().put('dueDateTime__c', '1232875600');
        Test.setCurrentPageReference(pageRef);
        
        controller.LookupCreate();
	}
	public static testmethod void NotifyQueueAssociations_CreateTask_LookupBlank_BadData() {	
	//Use the PageReference Apex class to instantiate a page
        PageReference pageRef = Page.NotifyQueueAssociations;
        
        //In this case, the Visualforce page named 'success' is the starting point of this test method. 
        Test.setCurrentPage(pageRef);
        Test.setCurrentPageReference(pageRef);
        
        //Instantiate and construct the controller class.   
        NotifyQueueAssociations controller = new NotifyQueueAssociations();
		
		pageRef.getParameters().put('targetObject', 'BMCServiceDesk__Task__c');
        pageRef.getParameters().put('BMCServiceDesk__FKCategory__c', 'SomethingNotThere');
        pageRef.getParameters().put('Lookup', '');
        pageRef.getParameters().put('BMCServiceDesk__FKImpact__c', 'LOWISH');
        pageRef.getParameters().put('BMCServiceDesk__FKUrgency__c', 'HIGHISH');
        pageRef.getParameters().put('OwnerId', 'Those_Guys');
        pageRef.getParameters().put('ClientId', 'RemForce API');
        pageRef.getParameters().put('Incident_Title__c', 'Test');
        pageRef.getParameters().put('Description__c', 'Testing');
        pageRef.getParameters().put('ConfigItem', 'WhatIsAConfigItem');
		pageRef.getParameters().put('dueDateTime__c', '1232875600');
        Test.setCurrentPageReference(pageRef);
        
        controller.LookupCreate();
	}
	public static testmethod void NotifyQueueAssociations_CreateIncident_UseLookup() {
	//Use the PageReference Apex class to instantiate a page
        PageReference pageRef = Page.NotifyQueueAssociations;
        
        //In this case, the Visualforce page named 'success' is the starting point of this test method. 
        Test.setCurrentPage(pageRef);
        Test.setCurrentPageReference(pageRef);
        
        //Instantiate and construct the controller class.   
        NotifyQueueAssociations controller = new NotifyQueueAssociations();
        Queue_Notification_Association__c assocrecord1 = new Queue_Notification_Association__c();
        
        assocrecord1.Environment__c='PROD';
        assocrecord1.Association_Pattern_1__c='dfwabc';
        assocrecord1.Association_Pattern_2__c='df';
        assocrecord1.Association_Pattern_3__c='/';
        assocrecord1.Queue__c=[SELECT Id FROM Group LIMIT 1].id;
        assocrecord1.IsActive__c=true;
        assocrecord1.No_IR_Notification__c=false;
        assocrecord1.X_Matters_Notification_Group__c='OPSYS';
        assocrecord1.IR_Category__c=[SELECT Id FROM BMCServiceDesk__Category__c LIMIT 1].id;
        assocrecord1.Impact__c=[SELECT Id FROM BMCServiceDesk__Impact__c LIMIT 1].id;
        assocrecord1.Urgency__c=[SELECT Id FROM BMCServiceDesk__Urgency__c LIMIT 1].id;
        
        User usr = [Select id from User where Id = :UserInfo.getUserId()];
        System.RunAs(usr){insert assocrecord1;}
		
		pageRef.getParameters().put('targetObject', 'BMCServiceDesk__Incident__c');
        pageRef.getParameters().put('Ops_Monitor__c', 'FALSE');
        pageRef.getParameters().put('BMCServiceDesk__contactType__c', 'Spectrum');
        pageRef.getParameters().put('Lookup', 'TRUE');
        pageRef.getParameters().put('Instance1', 'DFWSTI-02');
        pageRef.getParameters().put('Instance2', 'df');
        pageRef.getParameters().put('Incident_Title__c', 'Test');
        pageRef.getParameters().put('Description__c', 'Testing');
        Test.setCurrentPageReference(pageRef);
        
        controller.LookupCreate();
        
        BMCServiceDesk__Incident__c AnyExistingIR = [SELECT Id, Name
                                                     FROM BMCServiceDesk__Incident__c 
                                                     LIMIT 1];
        
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator_200());
        Test.startTest();
        send2Xmatters.postTicketID(AnyExistingIR.ID);
        Test.stopTest();
	}
	public static testmethod void NotifyQueueAssociations_CreateIncident_LookupBlank() {
	//Use the PageReference Apex class to instantiate a page
        PageReference pageRef = Page.NotifyQueueAssociations;
        
        //In this case, the Visualforce page named 'success' is the starting point of this test method. 
        Test.setCurrentPage(pageRef);
        Test.setCurrentPageReference(pageRef);
        
        //Instantiate and construct the controller class.   
        NotifyQueueAssociations controller = new NotifyQueueAssociations();
		
		pageRef.getParameters().put('targetObject', 'BMCServiceDesk__Incident__c');
        pageRef.getParameters().put('Ops_Monitor__c', 'TRUE');
        pageRef.getParameters().put('BMCServiceDesk__contactType__c', 'Spectrum');
        pageRef.getParameters().put('BMCServiceDesk__FKCategory__c', 'Server-Server');
        pageRef.getParameters().put('Lookup', '');
        pageRef.getParameters().put('BMCServiceDesk__FKImpact__c', 'LOW');
        pageRef.getParameters().put('BMCServiceDesk__FKUrgency__c', 'LOW');
        pageRef.getParameters().put('OwnerId', 'RemedyForce_Support');
        pageRef.getParameters().put('ClientId', 'RemForce API');
        pageRef.getParameters().put('Incident_Title__c', 'Test');
        pageRef.getParameters().put('Description__c', 'Testing');
        pageRef.getParameters().put('ConfigItem', 'VAST');
        pageRef.getParameters().put('XMatters', 'OPSYS');
        Test.setCurrentPageReference(pageRef);
        
        controller.LookupCreate();
        
        BMCServiceDesk__Incident__c AnyExistingIR = [SELECT Id, Name
                                                     FROM BMCServiceDesk__Incident__c 
                                                     LIMIT 1];
        
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator_200());
        Test.startTest();
        send2Xmatters.postTicketID(AnyExistingIR.ID);
        Test.stopTest();
	}
}