@isTest
public class BMCRF_Parser_EBCreateGroupContact_Test
{
    static testMethod void testCreateEBContact()
    {
        BMCRF_EB_Incident_Configuration__c config=new BMCRF_EB_Incident_Configuration__c();
        config.BMCRF_Everbridge_Webhook_URL__c='Test';
        config.BMCRF_Everbridge_Organization_ID__c='Test';
        config.BMCRF_Everbridge_Username__c='Test';
        config.BMCRF_Everbridge_Password__c='Test';
        config.BMCRF_Everbridge_API_URL_Base__c='Test';
        insert config;
        
        List<User> users=[select id,Phone,BMCRF_EB_ID__c,BMCRF_Everbridge_Sync__c,MobilePhone,name,email,firstName,lastname,username,FederationIdentifier,BMCRF_EB_Country_Code__c from User limit 1];
        
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new BMCRF_MockHttpResponseGenerator('recordTypes'));
        BMCRF_Parser_EBCreateGroupContact groupContact=new BMCRF_Parser_EBCreateGroupContact();
        groupContact.createEBContact(users,true);
        Test.stopTest();
    }
    static testMethod void testCreateEBContact1()
    {
        BMCRF_EB_Incident_Configuration__c config=new BMCRF_EB_Incident_Configuration__c();
        config.BMCRF_Everbridge_Webhook_URL__c='Test';
        config.BMCRF_Everbridge_Organization_ID__c='Test';
        config.BMCRF_Everbridge_Username__c='Test';
        config.BMCRF_Everbridge_Password__c='Test';
        config.BMCRF_Everbridge_API_URL_Base__c='Test';
        insert config;
        
        List<User> users=[select id,Phone,BMCRF_EB_ID__c,BMCRF_Everbridge_Sync__c,MobilePhone,name,email,firstName,lastname,username,FederationIdentifier,BMCRF_EB_Country_Code__c from User limit 1];
        
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new BMCRF_MockHttpResponseGenerator('recordTypes'));
        BMCRF_Parser_EBCreateGroupContact groupContact=new BMCRF_Parser_EBCreateGroupContact();
        groupContact.createEBContact(users,false);
        Test.stopTest();
    }
    static testMethod void testCreateEBGroup()
    {
        BMCRF_EB_Incident_Configuration__c config=new BMCRF_EB_Incident_Configuration__c();
        config.BMCRF_Everbridge_Webhook_URL__c='Test';
        config.BMCRF_Everbridge_Organization_ID__c='Test';
        config.BMCRF_Everbridge_Username__c='Test';
        config.BMCRF_Everbridge_Password__c='Test';
        config.BMCRF_Everbridge_API_URL_Base__c='Test';
        insert config;
        
        List<BMCRF_Everbridge_Group_Details__c> gd1=new List<BMCRF_Everbridge_Group_Details__c>();
        BMCRF_Everbridge_Group_Details__c gd=new BMCRF_Everbridge_Group_Details__c();
        gd.BMCRF_IsActive__c=true;
        gd.BMCRF_Everbridge_ID__c='test';
        gd.BMCRF_Everbridge_Name__c='test';
        gd.BMCRF_Everbridge_Sync__c=false;
        gd.BMCRF_Salesforce_ID__c='00G610000012nxsEAA';
        gd1.add(gd);
        
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new BMCRF_MockHttpResponseGenerator('groups'));
        BMCRF_Parser_EBCreateGroupContact groupContact=new BMCRF_Parser_EBCreateGroupContact();
        groupContact.createEBGroup(gd1);
        Test.stopTest();
    }
    static testMethod void testCreateEBGroup1()
    {
        BMCRF_EB_Incident_Configuration__c config=new BMCRF_EB_Incident_Configuration__c();
        config.BMCRF_Everbridge_Webhook_URL__c='Test';
        config.BMCRF_Everbridge_Organization_ID__c='Test';
        config.BMCRF_Everbridge_Username__c='Test';
        config.BMCRF_Everbridge_Password__c='Test';
        config.BMCRF_Everbridge_API_URL_Base__c='Test';
        insert config;
        
        List<BMCRF_Everbridge_Group_Details__c> gd1=new List<BMCRF_Everbridge_Group_Details__c>();
        BMCRF_Everbridge_Group_Details__c gd=new BMCRF_Everbridge_Group_Details__c();
        gd.BMCRF_IsActive__c=true;
        gd.BMCRF_Everbridge_ID__c='test';
        gd.BMCRF_Everbridge_Name__c='test';
        gd.BMCRF_Everbridge_Sync__c=false;
        gd.BMCRF_Salesforce_ID__c='00G610000012nxsEAA';
        gd1.add(gd);
        
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new BMCRF_MockHttpResponseGenerator('contacts'));
        BMCRF_Parser_EBCreateGroupContact groupContact=new BMCRF_Parser_EBCreateGroupContact();
        groupContact.createEBGroup(gd1);
        Test.stopTest();
    }
    
}