@isTest
public class BMCRF_HELPER_EBHttpCallout_Test
{
    static testMethod void test()
    {
        BMCRF_EB_Incident_Configuration__c config=new BMCRF_EB_Incident_Configuration__c();
        config.BMCRF_Everbridge_Webhook_URL__c='Test';
        config.BMCRF_Everbridge_Organization_ID__c='Test';
        config.BMCRF_Everbridge_Username__c='Test';
        config.BMCRF_Everbridge_Password__c='Test';
        config.BMCRF_Everbridge_API_URL_Base__c='Test';
        insert config;
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new BMCRF_MockHttpResponseGenerator('response'));
        BMCRF_HELPER_EBHttpCallout callout=new BMCRF_HELPER_EBHttpCallout();
        callout.call('','GET','test','','');
        Test.stopTest();
    }
}