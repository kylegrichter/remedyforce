@isTest
public class BMCRF_ChangeHistory_Test
{
    static testMethod void test()
    {
        profile pr=[select Id from profile where name ='System Administrator'];
        User us = [select Id from User where profileId =: pr.id limit 1];
        system.runAs(us)
        {
        BMCRF_Everbridge_Group_Details__c gd=new BMCRF_Everbridge_Group_Details__c();
        gd.Name='Test';
        gd.BMCRF_IsActive__c=true;
        gd.BMCRF_Everbridge_ID__c='4428875786358275';
        gd.BMCRF_Everbridge_Name__c='Test';
        gd.BMCRF_Everbridge_Sync__c=true;
        gd.BMCRF_Group_Members__c='{00561000000LFzBAAW, 00561000001DcdwAAC, 00561000001dsOzAAI}';
        gd.BMCRF_Salesforce_ID__c='00G61000000OpIJEA0';
        insert gd;
        
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
        
        BMCServiceDesk__Status__c status1=new BMCServiceDesk__Status__c();
        status1.name='Test1';
        status1.BMCServiceDesk__appliesToChange__c=true;
        insert status1;
        
        BMCServiceDesk__Status__c status2=new BMCServiceDesk__Status__c();
        status2.name='Test2';
        status2.BMCServiceDesk__appliesToIncident__c=true;
        insert status2;
        
        Group gr=new Group(Name='Test',Type='Queue');
        Group gr1=[select id from Group where type='Queue' limit 1];
        BMCServiceDesk__Category__c cat1=[select id from BMCServiceDesk__Category__c limit 1];
        BMCServiceDesk__Impact__c imp1=[select id from BMCServiceDesk__Impact__c limit 1];
        Id queue = [select Id from Group where DeveloperName = 'Remedyforce_Support'].id;
		Id user = [select UserOrGroupId from GroupMember where GroupId = '00GE0000000fOncMAE'].UserOrGroupId;
        
         BMCRF_Everbridge_Incident_Conditions__c cond=new BMCRF_Everbridge_Incident_Conditions__c();
        cond.Active__c=true;
        cond.Everbridge_Template__c='Integration Template';
        cond.Everbridge_Template_ID__c='444206992589693';
        cond.Name__c='Test';
        cond.Override_Contact__c=true;
        cond.Override_Contact_Group__c=true;
        cond.Object_Name__c='Incident';
        cond.Query_JSON__c='{"expressions":[{"attribute":"BMCServiceDesk__Impact_Id__c","operator":"Equals","value":"HIGH"}],"logicals":[{"value":""}]}';
        cond.BMCRF_Sort_Order__c=1;
        insert cond;
        
         BMCRF_EB_Incident_Configuration__c config=new BMCRF_EB_Incident_Configuration__c();
        config.BMCRF_Everbridge_Webhook_URL__c='Test';
        config.BMCRF_Everbridge_Organization_ID__c='Test';
        config.BMCRF_Everbridge_Username__c='Test';
        config.BMCRF_Everbridge_Password__c='Test';
        config.BMCRF_Everbridge_API_URL_Base__c='Test';
        insert config;
        
        BMCServiceDesk__Change_Request__c inc=new BMCServiceDesk__Change_Request__c();
        //inc.BMCServiceDesk__FKClient__c=u.id;
        inc.BMCServiceDesk__FKCategory__c=cat.id;
        inc.BMCServiceDesk__Change_Description__c='Test';
        //inc.BMCRF_Notes__c='Test';
        inc.BMCServiceDesk__FKImpact__c=imp1.id;
        inc.BMCServiceDesk__FKUrgency__c=urg.id;
        //inc.OwnerID=gr1.id;
        inc.ownerID=queue;
		inc.BMCServiceDesk__FKStaff__c=user;
        inc.Auto_Submit_for_Approval__c=false;
        inc.BMCServiceDesk__FKStatus__c=status1.id;
        insert inc;
        
        
        
            BMCServiceDesk__Action__c act=new BMCServiceDesk__Action__c();
            act.name='Notes';
            act.BMCServiceDesk__appliesToIncident__c=true;
            act.BMCServiceDesk__appliesToChange__c=true;
            insert act;
            
            BMCServiceDesk__Change_History__c hist=new BMCServiceDesk__Change_History__c();
            hist.BMCServiceDesk__FKAction__c=act.id;
            hist.BMCServiceDesk__description__c='Test';
            hist.BMCServiceDesk__note__c='Test';
            hist.BMCServiceDesk__FKChange__c= inc.id;
            insert hist;
        }
    }
}