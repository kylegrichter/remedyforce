@isTest(SeeAllData=True)
private class TestWebServiceInsert {

    static testmethod void TestWebServiceInsert()
    {
      
      //user nuser= [select id from user where FederationIdentifier='dharp01'];
      //String asaApplication="ASA-TRUSTEE-KGEN"+300;
    //  BMCServiceDesk__BMC_BaseElement__c bmc=[select id from BMCServiceDesk__BMC_BaseElement__c where Name='ASA-TRUSTEE-KGEN-520'];
      //Book__c b = new Book__c(Name='Behind the Cloud', Price__c=100);
          /*BMCServiceDesk__BMC_BaseElement__c bmcTest  = 
          new BMCServiceDesk__BMC_BaseElement__c (Name = 'ASA-TRUSTEE-KGEN-TT1-DHARP01',ASA_Application__c = 'a0Ge0000003dGuQ',user__c=nuser.id);*/
          // bmcTest.Name = 'ASA-TRUSTEE-KGEN-TEST-DHARP01';
           //bmcTest.ASA_Application__c = 'a0Ge0000003dGuQ';                                           
    // database.insert( bmcTest);
        
             
      //  system.debug(bmcTest.id);
  
      /* BMCServiceDesk__BMC_BaseElement__c bmcs1 = new BMCServiceDesk__BMC_BaseElement__c();
        bmcs1.Id =  bmcs.Id;
        bmcs1.Name = 'abcd';
        bmcs1.BMCServiceDesk__Name__c = 'abcd123';
        bmcs1.BMCServiceDesk__Inactive__c = true;
        bmcs1.Review_Date_Time__c = datetime.now();
        bmcs1.ASA_Application__c = 'a0Ge0000003dGuQ';
        insert bmcs1;*/
        
        //List<BMCServiceDesk__BMC_BaseElement__c> BE = new List<BMCServiceDesk__BMC_BaseElement__c>([SELECT Id, BMCServiceDesk__BMC_BaseElement__c.ASA_Application__c FROM BMCServiceDesk__BMC_BaseElement__c WHERE BMCServiceDesk__Inactive__c = false AND BMCServiceDesk__BMC_BaseElement__c.user__c = :ApexPages.currentPage().getParameters().get('id')]);
      //List<BMCServiceDesk__BMC_BaseElement__c> BEApprove = new List<BMCServiceDesk__BMC_BaseElement__c>{bmcs,bmcs1};
       // List<BMCServiceDesk__BMC_BaseElement__c> BEReject = new List<BMCServiceDesk__BMC_BaseElement__c>{bmcs,bmcs1};       
           //user userp=new user();
             
   // userp.lanid
       
        List<WebServiceInsert.BaseElementFields> beElementInfo = new List<WebServiceInsert.BaseElementFields>();
        
        WebServiceInsert.BaseElementFields beFields =new WebServiceInsert.BaseElementFields();
        beFields.empID= '1111'; 
        beFields.lastName= 'TEST_LNAME';
        beFields.firstName= 'TEST_FNAME';
        beFields.profileId= '535';
        beFields.profileName= 'TEST_PROF';
        beFields.baseElementLANID= 'DHARP01';
        beFields.baseElementName= 'ASA-TRUSTEE-KGEN-535-DHARP01';
        beElementInfo.add(beFields);     
        //-------------------        
        
        BMCServiceDesk__BMC_BaseElement__c BE = new BMCServiceDesk__BMC_BaseElement__c();
        
        //BE.Name ='ASA-TRUSTEE-KGEN-535-dharp01';
        BE.Name = 'ASA-TRUSTEE-KGEN-535';
        BE.Additional_System_Access__c = 'kGen Profile';
        BE.BMCServiceDesk__Name__c='dharp01';
       // BE.ASA_Application__c='ASA-TRUSTEE-KGEN-535';
        //BE.User__c = '005E0000008GxH6';
                              
        //BE.BMCServiceDesk__CMDB_Class__c = 'a1BE000000KXkHr';       
        //BE.BMCServiceDesk__LANID__c = 'dharp01';
        INSERT BE;          
        
      
        Test.StartTest();
        
        WebServiceInsert.insertNewBE(beElementInfo);
        //-------------------
        
        beElementInfo = new List<WebServiceInsert.BaseElementFields>();
        beFields =new WebServiceInsert.BaseElementFields();
        beFields.empID= '1111'; 
        beFields.lastName= 'TEST_LNAME';
        beFields.firstName= 'TEST_FNAME';
        beFields.profileId= '535';
        beFields.profileName= null;
        beFields.baseElementLANID= 'DHARP01';
        beFields.baseElementName= null;
        beElementInfo.add(beFields);   
        
        WebServiceInsert.insertNewBE(beElementInfo);
        
        Test.StopTest(); 
       
        
    }

}