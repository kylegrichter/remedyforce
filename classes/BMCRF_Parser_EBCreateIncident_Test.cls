@isTest (SeeAllData = true)
public class BMCRF_Parser_EBCreateIncident_Test
{
    static testMethod void testEscapeJSON() {
         String plain = null;
        
         String quote = 'Test\"';
         System.assertNotEquals(quote,BMCRF_Parser_EBCreateIncident.escapeJSON(quote));
        
         String slash = 'Test\\"';
         System.assertNotEquals(slash,BMCRF_Parser_EBCreateIncident.escapeJSON(slash));
        
         plain = 'Test/';
         System.assertNotEquals(plain,BMCRF_Parser_EBCreateIncident.escapeJSON(plain));
        
         plain = 'Test\"';
         System.assertNotEquals(plain,BMCRF_Parser_EBCreateIncident.escapeJSON(plain));
        
         plain = 'Test\b';
         System.assertNotEquals(plain,BMCRF_Parser_EBCreateIncident.escapeJSON(plain));
        
         plain = 'Test\n';
         System.assertNotEquals(plain,BMCRF_Parser_EBCreateIncident.escapeJSON(plain));
        
         plain = 'Test\f';
         System.assertNotEquals(plain,BMCRF_Parser_EBCreateIncident.escapeJSON(plain));
        
         String noEscape = 'Test';
         System.assertEquals(noEscape,BMCRF_Parser_EBCreateIncident.escapeJSON(noEscape));
        
         noEscape = '';
         System.assertEquals(noEscape,BMCRF_Parser_EBCreateIncident.escapeJSON(noEscape));
        
         noEscape = null;
         System.assertEquals(noEscape,BMCRF_Parser_EBCreateIncident.escapeJSON(noEscape));
        
    }

    static testMethod void testCreateIncident()
    {
       
 
        BMCRF_EB_Incident_Configuration__c config=new BMCRF_EB_Incident_Configuration__c();
        config.BMCRF_Everbridge_Webhook_URL__c='Test';
        config.BMCRF_Everbridge_Organization_ID__c='Test';
        config.BMCRF_Everbridge_Username__c='Test';
        config.BMCRF_Everbridge_Password__c='Test';
        config.BMCRF_Everbridge_API_URL_Base__c='Test';
        config.BMCRF_Everbridge_External_ID_Field__c = 'Test';
        config.BMCRF_Auto_Assignment__c = true;
        
        insert config;
        
        Profile p = [SELECT Id FROM Profile WHERE Name='Standard User'];
        User u = new User(Alias = 'standt', Email='standarduser@testorg.com',EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US',LocaleSidKey='en_US', ProfileId = p.Id,TimeZoneSidKey='America/Los_Angeles', UserName='standarduser@testorg.com');
        //BMCServiceDesk__Category__c cat=new BMCServiceDesk__Category__c();//[select id from BMCServiceDesk__Category__c limit 1];
       // cat.Name='Test';
        BMCServiceDesk__Category__c cat = new BMCServiceDesk__Category__c ( Name = 'TestCat',BMCServiceDesk__AvailableForIncidents__c=TRUE);
        insert cat;

		BMCServiceDesk__Status__c status = new BMCServiceDesk__Status__c ( Name = 'TestStatus', BMCServiceDesk__appliesToIncident__c = true);
        insert status;
        
        BMCServiceDesk__Impact__c imp=new BMCServiceDesk__Impact__c(); //[select id from BMCServiceDesk__Impact__c limit 1];
        imp.Name='TEST';
        insert imp;
        
        BMCServiceDesk__Urgency__c urg= new BMCServiceDesk__Urgency__c();//[select id from BMCServiceDesk__Urgency__c limit 1];
        urg.Name='TEST';
        insert urg;
        
        Group gr=new Group(Name='Test',Type='Queue');
        Group gr1=[select id, Name from Group where type='Queue' and (NOT Name Like 'Do Not Use%') limit 1];
        BMCServiceDesk__Category__c cat1=[select id from BMCServiceDesk__Category__c limit 1];
        BMCServiceDesk__Impact__c imp1=[select id from BMCServiceDesk__Impact__c limit 1];
        
        
        BMCRF_Everbridge_Incident_Conditions__c cond=new BMCRF_Everbridge_Incident_Conditions__c();
        cond.Active__c=true;
        cond.Everbridge_Template__c='Integration Template';
        cond.Everbridge_Template_ID__c='444206992589693';
        cond.Name__c='Test';
        cond.Object_Name__c='Incident';
        cond.Query_JSON__c='{"expressions":[{"attribute":"BMCServiceDesk__Impact_Id__c","operator":"Equals","value":"HIGH"}],"logicals":[{"value":""}]}';
        cond.BMCRF_Sort_Order__c=1;
        insert cond;
        
        
        for (integer x = 0; x < 20; x++) {
        BMCRF_Everbridge_Incident_Conditions__c cond1=new BMCRF_Everbridge_Incident_Conditions__c();
        cond1.Active__c=true;
        cond1.Everbridge_Template__c='Integration Template';
        cond1.Everbridge_Template_ID__c='444206992589693' + (x > 0 ? x +'' : '');
        cond1.Name__c='Test' + x;
        cond1.Object_Name__c='Change Request';
        cond1.Query_JSON__c='{"expressions":[{"attribute":"BMCServiceDesk__Impact__c","operator":"Equals","value":"HIGH"}],"logicals":[{"value":""}]}';
        cond1.BMCRF_Sort_Order__c=1;
        insert cond1;
        }
        
        BMCServiceDesk__Incident__c inc=new BMCServiceDesk__Incident__c();
        inc.BMCServiceDesk__FKClient__c=u.id;
        inc.BMCServiceDesk__FKCategory__c=cat.id;
        inc.BMCServiceDesk__incidentDescription__c='Test';
        inc.BMCRF_Notes__c='Test';
        inc.BMCServiceDesk__FKImpact__c=imp1.id;
        inc.BMCServiceDesk__FKUrgency__c=urg.id;
        inc.OwnerID=gr1.id;
        inc.BMCRF_EverBridge_Incident__c = 'Test';
        inc.BMCServiceDesk__FKStatus__c=status.id;
        //inc.Alternate_Contact_Name__c = 'Test';
        
        
        insert inc; 
        

        
        Map<String,String> valueMap=new Map<String,String>();
        valueMap.put('Impact','HIGH');
        valueMap.put('Id',inc.id);
        valueMap.put('BMCServiceDesk__Status__c','OPENED');
          valueMap.put('groupId','-1');
        valueMap.put('contactId','-1');

        BMCRF_Model_IncidentVariableItems vars = new BMCRF_Model_IncidentVariableItems();
        vars.firstPageUri = 'Test';
      
      
        BMCRF_Parser_EBCreateIncident.createEBIncident('Launch','-1',valueMap,'Incident'); // DISABLED   
        BMCRF_Parser_EBCreateIncident.createEBIncident('Update','-1',valueMap,'Incident'); // DISABLED    
        
          inc.BMCRF_EB_Ticket_Link__c='https://manager.everbridge.net/incidents/incident/'+ '1234' + '/notifications/';
            inc.BMCRF_EverBridge_Incident__c='1234';
            inc.Everbridge_Template_ID__c='1234';
            update inc;

        
    }
    
    static testMethod void testCloseIncident()
    {
        BMCRF_EB_Incident_Configuration__c config=new BMCRF_EB_Incident_Configuration__c();
        config.BMCRF_Everbridge_Webhook_URL__c='Test2';
        config.BMCRF_Everbridge_Organization_ID__c='Test2';
        config.BMCRF_Everbridge_Username__c='Test2';
        config.BMCRF_Everbridge_Password__c='Test2';
        config.BMCRF_Everbridge_API_URL_Base__c='Test2';
        config.BMCRF_Everbridge_External_ID_Field__c = 'Test2';
        insert config;
        
        Profile p = [SELECT Id FROM Profile WHERE Name='Standard User'];
        User u = new User(Alias = 'standt', Email='standarduser@testorg.com',EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US',LocaleSidKey='en_US', ProfileId = p.Id,TimeZoneSidKey='America/Los_Angeles', UserName='standarduser@testorg.com');
        //BMCServiceDesk__Category__c cat=new BMCServiceDesk__Category__c();//[select id from BMCServiceDesk__Category__c limit 1];
       // cat.Name='Test';
        BMCServiceDesk__Category__c cat = new BMCServiceDesk__Category__c ( Name = 'TestCat',BMCServiceDesk__AvailableForIncidents__c=TRUE);
        insert cat;
        
        BMCServiceDesk__Status__c status = new BMCServiceDesk__Status__c ( Name = 'TestStatus', BMCServiceDesk__appliesToIncident__c = true);
        insert status;
        
        BMCServiceDesk__Impact__c imp=new BMCServiceDesk__Impact__c(); //[select id from BMCServiceDesk__Impact__c limit 1];
        imp.Name='TEST';
        insert imp;
        
        BMCServiceDesk__Urgency__c urg=new BMCServiceDesk__Urgency__c(); //[select id from BMCServiceDesk__Urgency__c limit 1];
        urg.Name='TEST';
        insert urg;
        
        Group gr=new Group(Name='Test',Type='Queue');
        Group gr1=[select id, Name from Group where type='Queue' and (NOT Name Like 'Do Not Use%') limit 1];
        BMCServiceDesk__Category__c cat1=[select id from BMCServiceDesk__Category__c limit 1];
        BMCServiceDesk__Impact__c imp1=[select id from BMCServiceDesk__Impact__c limit 1];
        
        BMCRF_Everbridge_Incident_Conditions__c cond=new BMCRF_Everbridge_Incident_Conditions__c();
        cond.Active__c=true;
        cond.Everbridge_Template__c='Integration Template';
        cond.Everbridge_Template_ID__c='444206992589693';
        cond.Name__c='Test';
        cond.Object_Name__c='Incident';
        cond.Query_JSON__c='{"expressions":[{"attribute":"BMCServiceDesk__Impact_Id__c","operator":"Equals","value":"HIGH"}],"logicals":[{"value":""}]}';
        cond.BMCRF_Sort_Order__c=1;
        cond.Short_Description__c = 'Test';

        insert cond;
        
        BMCRF_Everbridge_Incident_Conditions__c cond1=new BMCRF_Everbridge_Incident_Conditions__c();
        cond1.Active__c=true;
        cond1.Everbridge_Template__c='Integration Template';
        cond1.Everbridge_Template_ID__c='444206992589693';
        cond1.Name__c='Test';
        cond1.Object_Name__c='Change Request';
        cond1.Query_JSON__c='{"expressions":[{"attribute":"BMCServiceDesk__Impact__c","operator":"Equals","value":"HIGH"}],"logicals":[{"value":""}]}';
        cond1.BMCRF_Sort_Order__c=1;
        insert cond1;
        
        BMCServiceDesk__Incident__c inc=new BMCServiceDesk__Incident__c();
        inc.BMCServiceDesk__FKClient__c=u.id;
        inc.BMCServiceDesk__FKCategory__c=cat.id;
        inc.BMCServiceDesk__incidentDescription__c='Test';
        inc.BMCRF_Notes__c='Test';
        inc.BMCServiceDesk__FKImpact__c=imp1.id;
        inc.BMCServiceDesk__FKUrgency__c=urg.id;
        inc.OwnerID=gr1.id;
        inc.BMCRF_EverBridge_Incident__c = 'Test';
        inc.BMCServiceDesk__FKStatus__c=status.id;
        insert inc; 
        

        
        Map<String,String> valueMap=new Map<String,String>();
        valueMap.put('Impact','HIGH');
        valueMap.put('Id',inc.id);
        valueMap.put('BMCServiceDesk__Status__c','OPENED');
        valueMap.put('test','test');
        valueMap.put('groupId','-1');
        valueMap.put('contactId','-1');
   

        BMCRF_Parser_EBCreateIncident.createEBIncident('Launch','-1',valueMap,'Incident'); // DISABLED   
        BMCRF_Parser_EBCreateIncident.createEBIncident('Update','-1',valueMap,'Incident'); // DISABLED     
        BMCRF_Parser_EBCreateIncident.createEBIncident('CloseWithNotification','-1',valueMap,'Incident'); // DISABLED   
        BMCRF_Parser_EBCreateIncident.createEBIncident('CloseWithoutNotification','-1',valueMap,'Incident'); // DISABLED   
             
    }
    
     
     static testMethod void testCreateCR()
    {
        BMCRF_EB_Incident_Configuration__c config=new BMCRF_EB_Incident_Configuration__c();
        config.BMCRF_Everbridge_Webhook_URL__c='Test';
        config.BMCRF_Everbridge_Organization_ID__c='Test';
        config.BMCRF_Everbridge_Username__c='Test';
        config.BMCRF_Everbridge_Password__c='Test';
        config.BMCRF_Everbridge_API_URL_Base__c='Test';
        config.BMCRF_Everbridge_External_ID_Field__c = 'Test';
        insert config;
        
        Profile p = [SELECT Id FROM Profile WHERE Name='Standard User'];
        User u = new User(Alias = 'standt', Email='standarduser@testorg.com',EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US',LocaleSidKey='en_US', ProfileId = p.Id,TimeZoneSidKey='America/Los_Angeles', UserName='standarduser@example.com');
        //BMCServiceDesk__Category__c cat=new BMCServiceDesk__Category__c();//[select id from BMCServiceDesk__Category__c limit 1];
       // cat.Name='Test';
        BMCServiceDesk__Category__c cat = new BMCServiceDesk__Category__c ( Name = 'TestCat',BMCServiceDesk__AvailableForIncidents__c=TRUE);
        insert cat;
        
        BMCServiceDesk__Impact__c imp=new BMCServiceDesk__Impact__c(); //[select id from BMCServiceDesk__Impact__c limit 1];
        imp.Name='TEST';
        insert imp;
        
        Group TestQueue = [select id from group where developername = 'Change_Management' limit 1];
        Id Staff = [select UserorGroupId from groupmember where groupid = :TestQueue.id limit 1].UserorGroupId;
        
        BMCServiceDesk__Urgency__c urg=new BMCServiceDesk__Urgency__c(); //[select id from BMCServiceDesk__Urgency__c limit 1];
        urg.Name='TEST';
        insert urg;
        
        Group gr=new Group(Name='Test',Type='Queue');
        Group gr1=[select id from Group where type='Queue' limit 1];
        BMCServiceDesk__Category__c cat1=[select id from BMCServiceDesk__Category__c limit 1];
        BMCServiceDesk__Impact__c imp1=[select id from BMCServiceDesk__Impact__c limit 1];
        
        BMCRF_Everbridge_Incident_Conditions__c cond=new BMCRF_Everbridge_Incident_Conditions__c();
        cond.Active__c=true;
        cond.Everbridge_Template__c='Integration Template';
        cond.Everbridge_Template_ID__c='444206992589693';
        cond.Name__c='Test';
        cond.Object_Name__c='Incident';
        cond.Query_JSON__c='{"expressions":[{"attribute":"BMCServiceDesk__Impact_Id__c","operator":"Equals","value":"HIGH"}],"logicals":[{"value":""}]}';
        cond.BMCRF_Sort_Order__c=1;

        insert cond;
        
        BMCRF_Everbridge_Incident_Conditions__c cond1=new BMCRF_Everbridge_Incident_Conditions__c();
        cond1.Active__c=true;
        cond1.Everbridge_Template__c='Integration Template';
        cond1.Everbridge_Template_ID__c='444206992589693';
        cond1.Name__c='Test';
        cond1.Object_Name__c='Change Request';
        cond1.Query_JSON__c='{"expressions":[{"attribute":"BMCServiceDesk__Impact__c","operator":"Equals","value":"HIGH"}],"logicals":[{"value":""}]}';
        cond1.BMCRF_Sort_Order__c=1;
        insert cond1;
        
        BMCServiceDesk__Change_Request__c cr=new BMCServiceDesk__Change_Request__c();
        cr.BMCServiceDesk__FKCategory__c=cat.id;
        cr.BMCServiceDesk__FKImpact__c=imp1.id;
        cr.BMCServiceDesk__FKUrgency__c=urg.id;
        cr.BMCServiceDesk__Change_Description__c='Test';
        cr.BMCRF_Everbridge_Auto_Assignment__c=false;
        cr.BMCRF_Override_Group__c = 'Test';
        cr.BMCRF_Override_Contact__c = 'Test';
        cr.BMCServiceDesk__FKStaff__c = Staff;
        cr.OwnerId = TestQueue.id;
        cr.Auto_Submit_for_Approval__c=false;
        insert cr;
        
        Map<String,String> valueMapCR=new Map<String,String>();
        valueMapCR.put('Id',cr.id);
        valueMapCR.put('BMCServiceDesk__Impact__c','HIGH');
        valueMapCR.put('BMCServiceDesk__Urgency__c','HIGH');
        valueMapCR.put('BMCServiceDesk__Status__c','OPENED');
        valueMapCR.put('groupId','-1');
        valueMapCR.put('contactId','-1');


      
 
        BMCRF_Parser_EBCreateIncident.createEBIncident('Launch','-1',valueMapCR,'Change Request'); // DISABLED   


              

        
    }
   
}