@isTest
public class BMCRF_getEverbridgeResponses_Test
{
    static testMethod void testGetNotificationDetails()    
    {
        
        BMCRF_Incident_Notification__c notif=new BMCRF_Incident_Notification__c();
        notif.BMCRF_Confirmed__c=1;
        notif.BMCRF_Confirmed_late__c=1;
        notif.BMCRF_Name__c='Test';
        notif.BMCRF_Sent_On__c='1';
        notif.BMCRF_Total__c=1;
        notif.BMCRF_Unconfirmed__c=1;
        insert notif;
        
        BMCRF_EB_Incident_Configuration__c config=new BMCRF_EB_Incident_Configuration__c();
        config.BMCRF_Everbridge_Webhook_URL__c='Test';
        config.BMCRF_Everbridge_Organization_ID__c='Test';
        config.BMCRF_Everbridge_Username__c='Test';
        config.BMCRF_Everbridge_Password__c='Test';
        config.BMCRF_Everbridge_API_URL_Base__c='Test';
        insert config;
        
        List<String> NotificationIds=new List<String>();
        NotificationIds.add('444206992765487');
        Map<String,String> map1=new Map<String,String>();
        map1.put('444206992765487','444206992765487');
        //NotificationIds.add('444206992591361');
        
        //String IncId='a2U61000000MSBeEAO';
        //String EBid='5748251084982358';
        List<String> list1=new List<String>();
        list1.add('5748251084982358');
        Test.startTest();
        //Test.setMock(WebServiceMock.class, new BMCRF_WebServiceMockImpl('notifications'));
        Test.setMock(HttpCalloutMock.class, new BMCRF_MockHttpResponseGenerator('notifications'));
        BMCRF_getEverbridgeResponses er=new BMCRF_getEverbridgeResponses();
        er.getNotificationDetails(NotificationIds,map1,list1);
        Test.stopTest();
    }
    static testMethod void testGetIncidentNotification()    
    {
        
        BMCRF_Incident_Notification__c notif=new BMCRF_Incident_Notification__c();
        notif.BMCRF_Confirmed__c=1;
        notif.BMCRF_Confirmed_late__c=1;
        notif.BMCRF_Name__c='Test';
        notif.BMCRF_Sent_On__c='1';
        notif.BMCRF_Total__c=1;
        notif.BMCRF_Unconfirmed__c=1;
        insert notif;
        
        BMCRF_EB_Incident_Configuration__c config=new BMCRF_EB_Incident_Configuration__c();
        config.BMCRF_Everbridge_Webhook_URL__c='Test';
        config.BMCRF_Everbridge_Organization_ID__c='Test';
        config.BMCRF_Everbridge_Username__c='Test';
        config.BMCRF_Everbridge_Password__c='Test';
        config.BMCRF_Everbridge_API_URL_Base__c='Test';
        insert config;
        
        BMCRF_Everbridge_Incident_Conditions__c cond=new BMCRF_Everbridge_Incident_Conditions__c();
        cond.Active__c=true;
        cond.Everbridge_Template__c='Integration Template';
        cond.Everbridge_Template_ID__c='444206992589693';
        cond.Name__c='Test';
        cond.Object_Name__c='Incident';
        cond.Query_JSON__c='{"expressions":[{"attribute":"BMCServiceDesk__Impact_Id__c","operator":"Equals","value":"HIGH"}],"logicals":[{"value":""}]}';
        cond.BMCRF_Sort_Order__c=1;
        insert cond;
        
        Profile p = [SELECT Id FROM Profile WHERE Name='Standard User'];
        User u = new User(Alias = 'standt', Email='standarduser@testorg.com',EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US',LocaleSidKey='en_US', ProfileId = p.Id,TimeZoneSidKey='America/Los_Angeles', UserName='standarduser@testorg.com');
        BMCServiceDesk__Category__c cat=new BMCServiceDesk__Category__c();//[select id from BMCServiceDesk__Category__c limit 1];
        cat.Name='Test';
        insert cat;
        
        BMCServiceDesk__Impact__c imp=new BMCServiceDesk__Impact__c(); //[select id from BMCServiceDesk__Impact__c limit 1];
        imp.Name='HIGH';
        insert imp;
        
        BMCServiceDesk__Urgency__c urg=new BMCServiceDesk__Urgency__c(); //[select id from BMCServiceDesk__Urgency__c limit 1];
        urg.Name='HIGH';
        insert urg;
        
        Group gr=new Group(Name='Test',Type='Queue');
        Group gr1=[select id from Group where type='Queue' limit 1];
        BMCServiceDesk__Category__c cat1=[select id from BMCServiceDesk__Category__c limit 1];
        BMCServiceDesk__Impact__c imp1=[select id from BMCServiceDesk__Impact__c limit 1];
        BMCServiceDesk__Urgency__c urg1=[select id from BMCServiceDesk__Urgency__c limit 1];
        BMCServiceDesk__Incident__c inc=new BMCServiceDesk__Incident__c();
        inc.BMCServiceDesk__FKClient__c=u.id;
        inc.BMCServiceDesk__FKCategory__c=cat.id;
        inc.BMCServiceDesk__incidentDescription__c='Test';
        inc.BMCRF_Notes__c='Test';
        inc.BMCServiceDesk__FKImpact__c=imp1.id;
        inc.BMCServiceDesk__FKUrgency__c=urg1.id;
        inc.OwnerID=gr1.id;
        inc.BMCRF_EverBridge_Incident__c='5748251084982358';
        
        
        List<BMCServiceDesk__Incident__c> incList=new List<BMCServiceDesk__Incident__c>();
        incList.add(inc);
        //insert inc;
        
        BMCRF_getEverbridgeResponses er=new BMCRF_getEverbridgeResponses();
        
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new BMCRF_MockHttpResponseGenerator('incidentNotifications1'));
        er.getIncidentNotification(incList);
        Test.stopTest();
    }
}