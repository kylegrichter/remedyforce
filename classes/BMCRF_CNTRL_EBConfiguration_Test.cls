@isTest
public class BMCRF_CNTRL_EBConfiguration_Test
{
    static testMethod void test()
    {
        BMCRF_EB_Incident_Configuration__c config=new BMCRF_EB_Incident_Configuration__c();
        config.BMCRF_Everbridge_Organization_ID__c='Test';
        config.BMCRF_Everbridge_Username__c='Test';
        config.BMCRF_Everbridge_Password__c='Test';
        config.BMCRF_Everbridge_API_URL_Base__c='Test';
        insert config;
        
        ApexPages.StandardController sc = new ApexPages.StandardController(config);
        BMCRF_CNTRL_EBConfiguration ebconfig=new BMCRF_CNTRL_EBConfiguration(sc);
        ebconfig.getExtIDs();
    }
    static testMethod void testTestConnection()
    {
        Test.setMock(HttpCalloutMock.class, new BMCRF_MockHttpResponseGenerator('response'));
        BMCRF_EB_Incident_Configuration__c config=new BMCRF_EB_Incident_Configuration__c();
        config.BMCRF_Everbridge_Organization_ID__c='Test';
        config.BMCRF_Everbridge_Username__c='Test';
        config.BMCRF_Everbridge_Password__c='Test';
        config.BMCRF_Everbridge_API_URL_Base__c='Test';
        insert config;
        
        ApexPages.StandardController sc = new ApexPages.StandardController(config);
        BMCRF_CNTRL_EBConfiguration ebconfig=new BMCRF_CNTRL_EBConfiguration(sc);
        ebconfig.testConnection();
    }
    static testMethod void testSave()
    {
        
        BMCRF_EB_Incident_Configuration__c config=new BMCRF_EB_Incident_Configuration__c();
        config.BMCRF_Everbridge_Organization_ID__c='Test';
        config.BMCRF_Everbridge_Username__c='Test';
        config.BMCRF_Everbridge_Password__c='Test';
        config.BMCRF_Everbridge_API_URL_Base__c='Test';
        insert config;
        
        ApexPages.StandardController sc = new ApexPages.StandardController(config);
        BMCRF_CNTRL_EBConfiguration ebconfig=new BMCRF_CNTRL_EBConfiguration(sc);
        ebconfig.save();
    }
    
    
}