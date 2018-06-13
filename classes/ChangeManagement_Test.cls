@isTest (SeeAllData = true)
public class ChangeManagement_Test {
    
    public static testmethod void ChangeManagement() {
        
        Id p=[SELECT ActorId FROM ProcessInstanceWorkitem LIMIT 1].ActorId;
        user u=[select id from User where Id = :p limit 1];
        
        System.runAs(u) {
            
            //Use the PageReference Apex class to instantiate a page
            PageReference pageRef = Page.ChangeManagement;
            
            //In this case, the Visualforce page named 'success' is the starting point of this test method. 
            Test.setCurrentPage(pageRef);
            Test.setCurrentPageReference(pageRef);
            
            //Instantiate and construct the controller class.   
            ChangeManagement controller = new ChangeManagement();
            Change_Weekend__c weekend1 = new Change_Weekend__c();
            Change_Weekend__c weekend = new Change_Weekend__c();
            weekend.Start_Date_Time__c=Datetime.now()+1;
            weekend.End_Date_Time__c=Datetime.now()+3;
            weekend1.Start_Date_Time__c=Datetime.now()+1;
            weekend1.End_Date_Time__c=Datetime.now()+3;
            weekend1.Weekend_Type__c='Release';
            EmailTemplate e=new EmailTemplate();
            EmailTemplate e1=new EmailTemplate();
            EmailTemplate e2=new EmailTemplate();
            EmailTemplate e3=new EmailTemplate();
            String folderIdValue='00lE0000000xkC7IAI';
            e.name='Pre-Change'; e1.name='1st Draft'; e2.name='2nd Draft'; e3.name='Final'; 
            e.IsActive=true; e1.IsActive=true; e2.IsActive=true; e3.IsActive=true; 
            e.DeveloperName='Pre_Change'; e1.DeveloperName='First_Draft'; e2.DeveloperName='Second_Draft'; e3.DeveloperName='Final';        
            e.FolderId=folderIdValue; e1.FolderId=folderIdValue; e2.FolderId=folderIdValue; e3.FolderId=folderIdValue;
            e.TemplateType='custom';  e1.TemplateType='custom'; e2.TemplateType='custom'; e3.TemplateType='custom';
            User usr = [Select id from User where Id = :UserInfo.getUserId()];
            System.RunAs(usr){
                insert weekend; insert weekend1; insert e; insert e1; insert e2; insert e3;
            }
            controller.getweekend();
            controller.gettasks();
            controller.getchanges();
            controller.getchangesserverdecom();
            controller.getchangesCal();
            controller.getanswerCal();
            controller.setanswerCal('A');
            
            controller.emailTem = [select Name from EmailTemplate where DeveloperName='Pre_Change' Limit 1].name;
            ApexPages.currentPage().getParameters().put('emailSent', 'Pre-Change');
            ApexPages.currentPage().getParameters().put('wkid', weekend.id);
            ApexPages.currentPage().getParameters().put('answer', weekend.id);
            
            controller.getdefaultDate();
            controller.getanswers();
            controller.getanswersshort();
            controller.getchanges();
            controller.gettasks();
            //controller.getreleasetasks();
            controller.getweekend();
            controller.getanswer();
            controller.setanswer('A');
            controller.SendEmail();
            controller.getforecast();
            
            ApexPages.currentPage().getParameters().put('emailSent', '1st Draft');
            controller.emailTem = [select Name from EmailTemplate where DeveloperName='First_Draft' Limit 1].name;
            controller.SendEmail();
            
            ApexPages.currentPage().getParameters().put('emailSent', '2nd Draft');
            controller.emailTem = [select Name from EmailTemplate where DeveloperName='Second_Draft' Limit 1].name;
            controller.SendEmail();
            
            ApexPages.currentPage().getParameters().put('emailSent', 'Final');
            controller.emailTem = [select Name from EmailTemplate where DeveloperName='Final' Limit 1].name;
            controller.SendEmail();
            
            List<BMCServiceDesk__Change_Request__c > CR_Id=[select id,BMCServiceDesk__queueName__c  from BMCServiceDesk__Change_Request__c where BMCServiceDesk__Category__c != 'Firecall - Finance'
                                                            and BMCServiceDesk__queueName__c !=null and BMCServiceDesk__Status__c='APPROVED' limit 1];
            
            controller.getchangesCal();
            ApexPages.currentPage().getParameters().put('id', CR_Id[0].Id);
            ApexPages.currentPage().getParameters().put('answer', CR_Id[0].BMCServiceDesk__queueName__c );
            controller.getchanges();
            controller.getchangesCal();
            controller.getanswersCal();
            controller.getdefaultDate();
            
            controller.getanswer();
            controller.setanswer('A');
            controller.getview();
            controller.setview('agendaWeek');
            
            controller.rangeNum=1;
            controller.getchangesDaily();
            
            controller.rangeNum=4;
            controller.getchangesDaily();
            
            controller.rangeNum=5;
            controller.getchangesDaily();
            
            controller.rangeNum=10;
            controller.getchangesDaily();
            
            BMCServiceDesk__Category__c CATEGORY = new BMCServiceDesk__Category__c ( Name = 'TEST', BMCServiceDesk__AvailableForIncidents__c = true );
            Insert CATEGORY;
            
            BMCServiceDesk__Impact__c IMPACT = new BMCServiceDesk__Impact__c ( Name = 'TEST' );
            Insert IMPACT;
            
            BMCServiceDesk__Urgency__c URGENCY = new BMCServiceDesk__Urgency__c ( Name = 'TEST' );
            INSERT URGENCY;
            
            BMCServiceDesk__Change_Request__c CR = new BMCServiceDesk__Change_Request__c (
                BMCServiceDesk__FKInitiator__c = u.id,
                BMCServiceDesk__FKCategory__c = CATEGORY.Id,
                Title__c = 'Test CR for test class.',
                BMCServiceDesk__Change_Description__c = 'Test CR for test class.',
                BMCServiceDesk__Back_out_Plan_Details__c = 'Test CR for test class.',
                BMCServiceDesk__Change_Type__c = 'Normal',
                BMCServiceDesk__Change_Category__c = 'Minor',
                Environment__c = 'Test',
                OwnerId = '00GE0000001UlcU',
                BMCServiceDesk__FKStaff__c = '005E00000026vpQ',
                BMCServiceDesk__FKImpact__c = IMPACT.Id,
                BMCServiceDesk__FKUrgency__c = URGENCY.Id,
                BMCServiceDesk__Scheduled_Start_Date__c = system.now(),
                BMCServiceDesk__Scheduled_End_Date__c = system.now()+1
            );
            Insert CR;
            
            ApexPages.currentPage().getParameters().put('crid', CR.Id);
            controller.getincidentsbycr();
            controller.getproblemsbycr();
            
            controller.changeID = CR_Id[0].Id;
            controller.getincidentsbycr();
            controller.getproblemsbycr();
            controller.gettasksbycr();
            
            controller.getchangespending();
        }
    }
}