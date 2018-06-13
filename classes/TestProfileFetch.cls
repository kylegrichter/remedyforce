@isTest 
public class TestProfileFetch{
    static testmethod void ProfileFetchTst(){
    
    
     Test.StartTest();
     
    
        Profile p = [select id from profile where name='Standard User'];
        User usr = new User();
      
            usr.lastname = 'Test User95';
            usr.Phone = '1234567890';
            usr.Email = 'testtest95@test.com';
            usr.Username='testtest95@test.com';
            usr.CommunityNickname='Test95';
            usr.Alias='Tu95';
            usr.ProfileID =p.id;
            usr.V_Z_ID_del__c = 'vTIBTEST95';
            usr.EmailEncodingKey='UTF-8';
            usr.LanguageLocaleKey='en_US';
            usr.LocaleSidKey='en_US';
            usr.TimeZoneSidKey='America/Los_Angeles';
            usr.IsActive=true;
            insert usr;
      
       
        
        BMCServiceDesk__BMC_BaseElement__c bmcs = new BMCServiceDesk__BMC_BaseElement__c();
        bmcs.Name = 'TESTabc';
        bmcs.BMCServiceDesk__Name__c = 'TESTabc123';
        bmcs.BMCServiceDesk__Inactive__c = False;
        bmcs.BMCServiceDesk__LANID__c = 'vTIBTEST';
        insert bmcs;
        
         
        BMCServiceDesk__BMC_BaseElement__c bmcs1 = new BMCServiceDesk__BMC_BaseElement__c();
        bmcs1.Name = 'TESTabcd';
        bmcs1.BMCServiceDesk__Name__c = 'TESTabcd123';
        bmcs1.BMCServiceDesk__Inactive__c = true;
        bmcs1.BMCServiceDesk__LANID__c = 'vTIBTEST95';
        insert bmcs1;
            
        //Test.setCurrentPageReference(new PageReference('Page.BMC_Profile'));
         PageReference tpageRef = Page.BMC_Profile;
         Test.setCurrentPage(tpageRef);
        //PageReference.currentPageReference().getParameters().put('id', usr.id);
         //PageReference pageRef = Page.BMC_Profile; 
        //Test.setCurrentPage(pageref);
        ApexPages.currentPage().getParameters().put('Id', usr.id);
        
        ProfileFetch pf = new ProfileFetch();
        //ApexPages.currentPage().getParameters().put('aBEId', bmcs.id);
        //ApexPages.currentPage().getParameters().put('sBEId', bmcs1.id);
        //pf.loadBE();
        pf.ApproveRecord();
        pf.ApproveAllRecord();
        pf.RejectRecord();
        pf.RejectAllRecord();
        
        Test.StopTest();
          
        
    }
}