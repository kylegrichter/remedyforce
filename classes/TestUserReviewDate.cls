@isTest
 private class TestUserReviewDate
 {
 static testmethod void TestUserReviewDate()
    {
     Test.StartTest();
     
    
        Profile p = [select id from profile where name='Standard User'];
        User usr = new User();
      User usr1 = new User();
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
            //usr.Review_Date__c=system.today()+1;
            insert usr;
            
             usr1.lastname = 'Test User959';
            usr1.Phone = '12345678909';
            usr1.Email = 'testtest959@test.com';
            usr1.Username='testtest959@test.com';
            usr1.CommunityNickname='Test99';
            usr1.Alias='Tu99';
            usr1.ProfileID =p.id;
            usr1.V_Z_ID_del__c = 'vTIBTEST99';
            usr1.EmailEncodingKey='UTF-8';
            usr1.LanguageLocaleKey='en_US';
            usr1.LocaleSidKey='en_US';
            usr1.TimeZoneSidKey='America/Los_Angeles';
            usr1.IsActive=true;
            usr1.Review_Date__c=system.today()+1;
            insert usr1;
      
       
        
        BMCServiceDesk__BMC_BaseElement__c bmcs = new BMCServiceDesk__BMC_BaseElement__c();
        bmcs.Name = 'TESTabc';
        bmcs.BMCServiceDesk__Name__c = 'TESTabc123';
        bmcs.BMCServiceDesk__Inactive__c = False;
        bmcs.BMCServiceDesk__LANID__c = 'vTIBTEST';
        insert bmcs;
        
         
        BMCServiceDesk__BMC_BaseElement__c bmcs1 = new BMCServiceDesk__BMC_BaseElement__c();
        bmcs1.Name = 'TESTabcd';
        bmcs1.BMCServiceDesk__Name__c = 'TESTabcd123';
        bmcs1.BMCServiceDesk__Inactive__c = False;
        bmcs1.BMCServiceDesk__LANID__c = 'vTIBTEST95';
        bmcs1.ASA_Application__C=bmcs.id;
        bmcs1.user__c=usr.id;
        insert bmcs1;
        
        BMCServiceDesk__BMC_BaseElement__c bmcs2 = new BMCServiceDesk__BMC_BaseElement__c();
        bmcs2.Name = 'TESTabcd';
        bmcs2.BMCServiceDesk__Name__c = 'TESTabcd1234';
        bmcs2.BMCServiceDesk__Inactive__c = False;
        bmcs2.BMCServiceDesk__LANID__c = 'vTIBTEST956';
        bmcs2.ASA_Application__C=bmcs.id;
        bmcs2.user__c=usr1.id;
        bmcs2.Review_Date_Time__c=System.today();
        insert bmcs2;
        
        bmcs2.Review_Date_Time__c=System.today()-1;
        update bmcs2;
        
        List<BMCServiceDesk__BMC_BaseElement__c> tstbmclst =new List<BMCServiceDesk__BMC_BaseElement__c>();
        List<BMCServiceDesk__BMC_BaseElement__c> tstbmclst1 =new List<BMCServiceDesk__BMC_BaseElement__c>();
        tstbmclst.add(bmcs1);
         tstbmclst1.add(bmcs2);
        UserReviewDate urdate= new UserReviewDate ();
        urdate.UpdateReviewDate(tstbmclst);
        urdate.UpdateReviewDate(tstbmclst1);
        Test.StopTest();
     }
 
 }