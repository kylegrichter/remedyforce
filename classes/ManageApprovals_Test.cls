@isTest (SeeAllData = true)
public class ManageApprovals_Test {
    
    public static testmethod void ManageApprovals() {
        
        user u=[select id, ManagerId from User where Username like 'remedyforcesystemuseonly@dexmedia.com%' limit 1];
        User userManager=[select Id from User where Id = :u.ManagerId limit 1];
        Group TestQueue = [select id from group where developername = 'Change_Management' limit 1];     
        GroupMember QueueMemberRecord = new GroupMember ( 
            UserOrGroupId = u.id, 
            GroupID       = TestQueue.id 
        );
        
        INSERT QueueMemberRecord; 
        
        System.runAs(userManager) {
            
            //Use the PageReference Apex class to instantiate a page
            PageReference pageRef = Page.ManageApprovals;
            
            //In this case, the Visualforce page named 'success' is the starting point of this test method. 
            Test.setCurrentPage(pageRef);
            Test.setCurrentPageReference(pageRef);
            
            //Instantiate and construct the controller class.   
            ManageApprovals controller = new ManageApprovals();
            controller.getincidentspending();
            controller.gettaskspending();
            controller.getchangespending();
            
            controller.approvalWorkItem=[SELECT Id FROM ProcessInstanceWorkitem limit 1].id;
            
            Profile profile = [SELECT Id FROM Profile WHERE Name='Standard User'];
            User user = new User(Alias = 'standt', Email='standarduser@testorg.com',EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US',LocaleSidKey='en_US', ProfileId = profile.Id,TimeZoneSidKey='America/Los_Angeles', UserName='standarduser@example.com');
            BMCServiceDesk__Category__c cat = new BMCServiceDesk__Category__c ( Name = 'TestCat',BMCServiceDesk__AvailableForIncidents__c=TRUE);
            insert cat;
            
            BMCServiceDesk__Impact__c imp=new BMCServiceDesk__Impact__c();
            imp.Name='TEST';
            insert imp;
            
            BMCServiceDesk__Urgency__c urg=new BMCServiceDesk__Urgency__c();
            urg.Name='TEST';
            insert urg;
            
            Group gr=new Group(Name='Test',Type='Queue');
            Group gr1=[select id from Group where type='Queue' limit 1];
            BMCServiceDesk__Category__c cat1=[select id from BMCServiceDesk__Category__c limit 1];
            BMCServiceDesk__Impact__c imp1=[select id from BMCServiceDesk__Impact__c limit 1];
            
            BMCServiceDesk__Change_Request__c cr=new BMCServiceDesk__Change_Request__c();
            cr.BMCServiceDesk__FKCategory__c=cat.id;
            cr.BMCServiceDesk__FKImpact__c=imp1.id;
            cr.BMCServiceDesk__FKUrgency__c=urg.id;
            cr.BMCServiceDesk__Change_Description__c='Test';
            cr.BMCRF_Everbridge_Auto_Assignment__c=false;
            cr.BMCRF_Override_Group__c = 'Test';
            cr.BMCRF_Override_Contact__c = 'Test';
            cr.BMCServiceDesk__FKStaff__c = u.id;
            cr.BMCServiceDesk__Scheduled_Start_Date__c = System.now()+7;
            cr.BMCServiceDesk__Scheduled_End_Date__c = System.now()+10;
            cr.OwnerId = TestQueue.id;
            cr.Auto_Submit_for_Approval__c=true;
            insert cr;
            
            controller.approvalWorkItem=cr.id;
            controller.ApproveChange();
            controller.RejectChange();
        }
    }
}