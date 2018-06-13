@isTest
public class BMCRF_CNTRL_EBUserSync_Test
{
    static testMethod void testGetFields()
    {
        Profile p = [SELECT Id FROM Profile WHERE Name='Standard User']; 
        User us = new User(Alias = 'standt', Email='standarduser@testorg.com', 
            EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId = p.Id, 
            TimeZoneSidKey='America/Los_Angeles', UserName='standarduser@testorg.com');
        Test.startTest();
        
        ApexPages.StandardController controller=new ApexPages.StandardController(us);
        BMCRF_CNTRL_EBUserSync userSync=new BMCRF_CNTRL_EBUserSync(controller);
        BMCRF_CNTRL_EBUserSync.UserListWrapper obj=new BMCRF_CNTRL_EBUserSync.UserListWrapper();
        userSync.getFields();
        Test.stopTest();
    }
    static testMethod void testGetcolumnHeaders()
    {
        Profile p = [SELECT Id FROM Profile WHERE Name='Standard User']; 
        User us = new User(Alias = 'standt', Email='standarduser@testorg.com', 
            EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId = p.Id, 
            TimeZoneSidKey='America/Los_Angeles', UserName='standarduser@testorg.com');
        Test.startTest();
        
        ApexPages.StandardController controller=new ApexPages.StandardController(us);
        BMCRF_CNTRL_EBUserSync userSync=new BMCRF_CNTRL_EBUserSync(controller);
        userSync.getcolumnHeaders();
        Test.stopTest();
    }
    static testMethod void testGetconditionList()
    {
        Profile p = [SELECT Id FROM Profile WHERE Name='Standard User']; 
        User us = new User(Alias = 'standt', Email='standarduser@testorg.com', 
            EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId = p.Id, 
            TimeZoneSidKey='America/Los_Angeles', UserName='standarduser@testorg.com');
        Test.startTest();
        
        ApexPages.StandardController controller=new ApexPages.StandardController(us);
        BMCRF_CNTRL_EBUserSync userSync=new BMCRF_CNTRL_EBUserSync(controller);
        userSync.getconditionList();
        Test.stopTest();
    }
    static testMethod void testSyncUser()
    {
        Profile p = [SELECT Id FROM Profile WHERE Name='Standard User']; 
        User us = new User(Alias = 'standt', Email='standarduser@testorg.com', 
            EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId = p.Id, 
            TimeZoneSidKey='America/Los_Angeles', UserName='standarduser@testorg.com');
        Test.startTest();
        
        ApexPages.StandardController controller=new ApexPages.StandardController(us);
        PageReference pageRef = controller.view();
        List<User> userID = [select id from user where isActive = true limit 2];
        Set<String> userIDSet = new Set<String>();
        String node = '["';
        Integer i = 0;
        for(User u: userID){
            if(i != 1)
                node = node +u.id +'","';
            else 
                node = node +u.id +'"]';
            i++;
        }
        system.debug('node:' +node);
        System.currentPageReference().getParameters().put('node', node);
        system.debug('node:' +System.currentPageReference().getParameters().put('node', node));
        system.debug('node:'+ApexPages.currentPage().getParameters().get('node'));
        //pageRef.getParameters().put('node', node);
        //controller.save().getParameters().put('node', node);
        BMCRF_CNTRL_EBUserSync userSync=new BMCRF_CNTRL_EBUserSync(controller);
        userSync.syncUser();
        Test.stopTest();
    }
}