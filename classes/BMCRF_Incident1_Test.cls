@isTest (SeeAllData = true)
public class BMCRF_Incident1_Test
{
    static testMethod void test()
    {
        profile pr=[select Id from profile where name ='ServiceDesk System Administrator'];
        User us = [select Id from User where isActive = true  AND profileId =: pr.id limit 1];
        System.debug('USER=' + us);
        
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
            //  BMCServiceDesk__Category__c cat= new BMCServiceDesk__Category__c(); 
            
            BMCServiceDesk__Category__c cat = new BMCServiceDesk__Category__c ( Name = 'Test',BMCServiceDesk__AvailableForIncidents__c=TRUE);
            
            insert cat;
            
            
            //cat.Name='Test';
            System.debug(cat);
            //insert ;
            
            
            BMCServiceDesk__Impact__c imp=new BMCServiceDesk__Impact__c(); //[select id from BMCServiceDesk__Impact__c limit 1];
            imp.Name='TEST';
            insert imp;
            
            BMCServiceDesk__Urgency__c urg=new BMCServiceDesk__Urgency__c(); //[select id from BMCServiceDesk__Urgency__c limit 1];
            urg.Name='TEST';
            insert urg;
            
            BMCServiceDesk__Status__c status1=new BMCServiceDesk__Status__c();
            status1.name='Test1';
            status1.BMCServiceDesk__appliesToIncident__c=true;
            insert status1;
            
            BMCServiceDesk__Status__c status2=new BMCServiceDesk__Status__c();
            status2.name='Test2';
            status2.BMCServiceDesk__appliesToIncident__c=true;
            insert status2;
            
            
            Group gr=new Group(Name='Test',Type='Queue');
            Group gr1=[select id from Group where type='Queue' limit 1];
            //     BMCServiceDesk__Category__c cat1=[select id from BMCServiceDesk__Category__c limit 1];
            BMCServiceDesk__Impact__c imp1=[select id from BMCServiceDesk__Impact__c limit 1];
            
            BMCRF_EB_Incident_Configuration__c config=new BMCRF_EB_Incident_Configuration__c();
            config.BMCRF_Everbridge_Webhook_URL__c='Test';
            config.BMCRF_Everbridge_Organization_ID__c='Test';
            config.BMCRF_Everbridge_Username__c='Test';
            config.BMCRF_Everbridge_Password__c='Test';
            config.BMCRF_Everbridge_API_URL_Base__c='Test';
            config.BMCRF_Auto_Assignment__c = false;
            config.BMCRF_Auto_Sync_new_Contacts__c = false;
            config.BMCRF_Template_Category__c = 'Test';
            
            insert config;
            
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
            cond.Close_Without_Notification__c=true;
            
            insert cond;
            
            
            
            BMCServiceDesk__Incident__c inc=new BMCServiceDesk__Incident__c();
            inc.BMCServiceDesk__FKClient__c=u.id;
            //inc.BMCRF_Override_Group__c='true';
            inc.BMCServiceDesk__FKCategory__c=cat.id; // needs to be a valid group which we can't know or insert?
            inc.BMCServiceDesk__incidentDescription__c='Test';
            inc.BMCRF_Notes__c='Test';
            inc.BMCServiceDesk__FKImpact__c=imp1.id;
            inc.BMCServiceDesk__FKUrgency__c=urg.id;
            inc.OwnerID=gr1.id;
            inc.BMCServiceDesk__FKStatus__c=status1.id;
            inc.BMCRF_EverBridge_Incident__c = 'Test';
            inc.BMCServiceDesk__incidentResolution__c = 'Test';
            
            System.debug(inc);
            
            
            insert inc;   
            BMCServiceDesk__Incident__c incUPDATE=[select id,BMCServiceDesk__FKStatus__c from BMCServiceDesk__Incident__c limit 1];
            incUPDATE.BMCServiceDesk__FKStatus__c=status2.id;
            update incUPDATE;   
            
            BMCServiceDesk__Incident__c incCLOSE=[select id,BMCServiceDesk__incidentDescription__c from BMCServiceDesk__Incident__c limit 1];
            incCLOSE.BMCServiceDesk__incidentDescription__c='TEST:-FORCE-CLOSE';
            update incCLOSE;   
            
        }
        
    }
}