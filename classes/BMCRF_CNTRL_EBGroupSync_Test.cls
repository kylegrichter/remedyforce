@isTest
public class BMCRF_CNTRL_EBGroupSync_Test
{
    static testMethod void testUpsertOnLoad()
    {
        Group gr=new Group();
        gr.Name='Test';
        insert gr;
        
        Group gr1=new Group();
        gr1.Name='Test';
        insert gr1;
        
        BMCRF_Everbridge_Group_Details__c groupDetails=new BMCRF_Everbridge_Group_Details__c();
        groupDetails.name='Test';
        groupDetails.BMCRF_Everbridge_ID__c='10002121012';
        groupDetails.BMCRF_Everbridge_Sync__c=true;
        groupDetails.BMCRF_Salesforce_ID__c=gr.id;
        insert groupDetails;

        Test.startTest();
        //Test.setMock(HttpCalloutMock.class, new BMCRF_MockHttpResponseGenerator('notifications'));
        BMCRF_CNTRL_EBGroupSync groupSync=new BMCRF_CNTRL_EBGroupSync();
        groupSync.upsertOnLoad();
        Test.stopTest();
    }
    static testMethod void testNewCondition()
    {
        Test.startTest();
        //Test.setMock(HttpCalloutMock.class, new BMCRF_MockHttpResponseGenerator('notifications'));
        BMCRF_CNTRL_EBGroupSync groupSync=new BMCRF_CNTRL_EBGroupSync();
        groupSync.newCondition();
        Test.stopTest();
    }
    static testMethod void testGetFields()
    {
        Test.startTest();
        //Test.setMock(HttpCalloutMock.class, new BMCRF_MockHttpResponseGenerator('notifications'));
        BMCRF_CNTRL_EBGroupSync groupSync=new BMCRF_CNTRL_EBGroupSync();
        groupSync.getFields();
        Test.stopTest();
    }
    static testMethod void testGetcolumnHeaders()
    {
        Test.startTest();
        //Test.setMock(HttpCalloutMock.class, new BMCRF_MockHttpResponseGenerator('notifications'));
        BMCRF_CNTRL_EBGroupSync groupSync=new BMCRF_CNTRL_EBGroupSync();
        groupSync.getcolumnHeaders();
        Test.stopTest();
    }
    static testMethod void testGetconditionList()
    {
        
        Group gr=new Group();
        gr.Name='Test';
        insert gr;
        
        Group gr1=new Group();
        gr1.Name='Test';
        insert gr1;
        
        BMCRF_Everbridge_Group_Details__c groupDetails=new BMCRF_Everbridge_Group_Details__c();
        groupDetails.name='Test';
        groupDetails.BMCRF_Everbridge_ID__c='10002121012';
        groupDetails.BMCRF_Everbridge_Sync__c=true;
        groupDetails.BMCRF_Salesforce_ID__c=gr.id;
        insert groupDetails;
        
        Test.startTest();
        //Test.setMock(HttpCalloutMock.class, new BMCRF_MockHttpResponseGenerator('notifications'));
        BMCRF_CNTRL_EBGroupSync groupSync=new BMCRF_CNTRL_EBGroupSync();
        groupSync.getconditionList();
        Test.stopTest();
    }
    static testMethod void testSyncGroup()
    {
        Group gr=new Group();
        gr.Name='Test';
        insert gr;
        
        Group gr1=new Group();
        gr1.Name='Test';
        insert gr1;
        
        BMCRF_Everbridge_Group_Details__c groupDetails=new BMCRF_Everbridge_Group_Details__c();
        groupDetails.name='Test';
        groupDetails.BMCRF_Everbridge_ID__c='10002121012';
        groupDetails.BMCRF_Everbridge_Sync__c=true;
        groupDetails.BMCRF_Salesforce_ID__c=gr.id;
        insert groupDetails;
        
        Test.startTest();
        //Test.setMock(HttpCalloutMock.class, new BMCRF_MockHttpResponseGenerator('notifications'));
        BMCRF_CNTRL_EBGroupSync groupSync=new BMCRF_CNTRL_EBGroupSync();
        groupSync.syncGroup();
        Test.stopTest();
    }
}