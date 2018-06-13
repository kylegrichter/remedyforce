@isTest
public class BMCRF_CNTRL_EBLandingPage_Test
{
    static testMethod void test()
    {
        BMCRF_EB_Incident_Configuration__c config=new BMCRF_EB_Incident_Configuration__c();
        config.BMCRF_Everbridge_Organization_ID__c='Test';
        config.BMCRF_Everbridge_Username__c='Test';
        config.BMCRF_Everbridge_Password__c='Test';
        config.BMCRF_Everbridge_API_URL_Base__c='Test';
        insert config;
        
        BMCRF_CNTRL_EBLandingPage landing=new BMCRF_CNTRL_EBLandingPage();
        landing.getEbID();
    }
}