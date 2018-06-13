@isTest
public class BMCRF_CNTRL_ConditionsPage_Test
{
    static testMethod void testGetObjects()
    {
        BMCRF_EB_Incident_Configuration__c config=new BMCRF_EB_Incident_Configuration__c();
        config.BMCRF_Everbridge_Webhook_URL__c='Test';
        config.BMCRF_Everbridge_Organization_ID__c='Test';
        config.BMCRF_Everbridge_Username__c='Test';
        config.BMCRF_Everbridge_Password__c='Test';
        config.BMCRF_Everbridge_API_URL_Base__c='Test';
        insert config; 
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new BMCRF_MockHttpResponseGenerator('incidentVariableItems'));
        BMCRF_CNTRL_ConditionsPage obj=new BMCRF_CNTRL_ConditionsPage();
       
        List<SelectOption> sel1=obj.getObjects();
        
        Test.stopTest();
    }
    static testMethod void testGetIncidentFieldList()
    {
        BMCRF_EB_Incident_Configuration__c config=new BMCRF_EB_Incident_Configuration__c();
        config.BMCRF_Everbridge_Webhook_URL__c='Test';
        config.BMCRF_Everbridge_Organization_ID__c='Test';
        config.BMCRF_Everbridge_Username__c='Test';
        config.BMCRF_Everbridge_Password__c='Test';
        config.BMCRF_Everbridge_API_URL_Base__c='Test';
        insert config; 
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new BMCRF_MockHttpResponseGenerator('incidentVariableItems'));
        BMCRF_CNTRL_ConditionsPage obj=new BMCRF_CNTRL_ConditionsPage();
        List<SelectOption> sel=obj.getIncidentFieldList();
        Test.stopTest();
    }
    static testMethod void testGetChangeRequestFieldList()
    {
        BMCRF_EB_Incident_Configuration__c config=new BMCRF_EB_Incident_Configuration__c();
        config.BMCRF_Everbridge_Webhook_URL__c='Test';
        config.BMCRF_Everbridge_Organization_ID__c='Test';
        config.BMCRF_Everbridge_Username__c='Test';
        config.BMCRF_Everbridge_Password__c='Test';
        config.BMCRF_Everbridge_API_URL_Base__c='Test';
        insert config; 
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new BMCRF_MockHttpResponseGenerator('incidentVariableItems'));
        BMCRF_CNTRL_ConditionsPage obj=new BMCRF_CNTRL_ConditionsPage();
        List<SelectOption> sel2=obj.getChangeRequestFieldList();
        Test.stopTest();
    }
    static testMethod void testGetMappedValues()
    {
        BMCRF_EB_Incident_Configuration__c config=new BMCRF_EB_Incident_Configuration__c();
        config.BMCRF_Everbridge_Webhook_URL__c='Test';
        config.BMCRF_Everbridge_Organization_ID__c='Test';
        config.BMCRF_Everbridge_Username__c='Test';
        config.BMCRF_Everbridge_Password__c='Test';
        config.BMCRF_Everbridge_API_URL_Base__c='Test';
        insert config; 
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new BMCRF_MockHttpResponseGenerator('incidentVariableItems'));
        BMCRF_CNTRL_ConditionsPage obj=new BMCRF_CNTRL_ConditionsPage();
        List<SelectOption> sel3=obj.getMappedValues();
        Test.stopTest();
    }
    static testMethod void testSaveRecord()
    {
        BMCRF_EB_Incident_Configuration__c config=new BMCRF_EB_Incident_Configuration__c();
        config.BMCRF_Everbridge_Webhook_URL__c='Test';
        config.BMCRF_Everbridge_Organization_ID__c='Test';
        config.BMCRF_Everbridge_Username__c='Test';
        config.BMCRF_Everbridge_Password__c='Test';
        config.BMCRF_Everbridge_API_URL_Base__c='Test';
        insert config; 
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new BMCRF_MockHttpResponseGenerator('incidentVariableItems'));
        BMCRF_CNTRL_ConditionsPage obj=new BMCRF_CNTRL_ConditionsPage();
        obj.queryJSON='AB';
        obj.selectedObject='Test';
        obj.selectedEBTemplate='Test';
        PageReference page1=obj.saveRecord();
        
        Test.stopTest();
    }
    static testMethod void testGetEBTemplates()
    {
        BMCRF_EB_Incident_Configuration__c config=new BMCRF_EB_Incident_Configuration__c();
        config.BMCRF_Everbridge_Webhook_URL__c='Test';
        config.BMCRF_Everbridge_Organization_ID__c='Test';
        config.BMCRF_Everbridge_Username__c='Test';
        config.BMCRF_Everbridge_Password__c='Test';
        config.BMCRF_Everbridge_API_URL_Base__c='Test';
        insert config; 
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new BMCRF_MockHttpResponseGenerator('incidentVariableItems'));
        BMCRF_CNTRL_ConditionsPage obj=new BMCRF_CNTRL_ConditionsPage();
        List<SelectOption> sel4=obj.getEBTemplates();
        Test.stopTest();
    }
}