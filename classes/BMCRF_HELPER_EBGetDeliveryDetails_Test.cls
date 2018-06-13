@isTest
public class BMCRF_HELPER_EBGetDeliveryDetails_Test
{
    static testMethod void testGetDeliveryDetails()    
    {
        
        BMCRF_Incident_Notification__c notif=new BMCRF_Incident_Notification__c();
        notif.BMCRF_Confirmed__c=1;
        notif.BMCRF_Confirmed_late__c=1;
        notif.BMCRF_Name__c='Test';
        notif.BMCRF_Sent_On__c='1';
        notif.BMCRF_Total__c=3;
        notif.BMCRF_Unconfirmed__c=1;
        notif.BMCRF_Notification_ID__c='Test';
        insert notif;
        
        BMCRF_EB_Incident_Configuration__c config=new BMCRF_EB_Incident_Configuration__c();
        config.BMCRF_Everbridge_Webhook_URL__c='Test';
        config.BMCRF_Everbridge_Organization_ID__c='Test';
        config.BMCRF_Everbridge_Username__c='Test';
        config.BMCRF_Everbridge_Password__c='Test';
        config.BMCRF_Everbridge_API_URL_Base__c='Test';
        insert config;
        
        Test.startTest();
        //Test.setMock(WebServiceMock.class, new BMCRF_WebServiceMockImpl('incidentNotifications'));
        Test.setMock(HttpCalloutMock.class, new BMCRF_MockHttpResponseGenerator('incidentNotifications'));
        BMCRF_HELPER_EBGetDeliveryDetails EBDetails=new BMCRF_HELPER_EBGetDeliveryDetails();
        EBDetails.getDeliveryDetails('5748251084982358','a2U61000000MSBeEAO','');
        Test.stopTest();
    }
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
        //NotificationIds.add('444206992591361');
        
        String IncId='a2U61000000MSBeEAO';
        String EBid='5748251084982358';
        
        Test.startTest();
        //Test.setMock(WebServiceMock.class, new BMCRF_WebServiceMockImpl('notifications'));
        Test.setMock(HttpCalloutMock.class, new BMCRF_MockHttpResponseGenerator('notifications'));
        BMCRF_HELPER_EBGetDeliveryDetails EBDetails=new BMCRF_HELPER_EBGetDeliveryDetails();
        EBDetails.getNotificationDetails(NotificationIds,IncId,EBid,'');
        Test.stopTest();
    }
}