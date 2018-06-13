@isTest(SeeAllData=True)
Public class TestWebServiceUpdate {

      static testmethod void TestWebServiceUpdate(){
      
     
        
          
             
    
       
        List<WebServiceUpdate.BEInfo> beInfoUpdate = new List<WebServiceUpdate.BEInfo>();
        WebServiceUpdate.BEInfo beFields =new  WebServiceUpdate.BEInfo();
          /* beFields.empID= '1111'; 
        beFields.lastName= 'TEST_LNAME';
        beFields.firstName= 'TEST_FNAME';
        beFields.profileId= '932';
        beFields.profileName= 'TEST_PROF';
        beFields.baseElementLANID= 'tstV234769';
        beFields.baseElementName= 'ASA-TRUSTEE-KGEN-932-tstV234769';*/
        beFields.empID= '1111'; 
        beFields.lastName= 'TEST_LNAME';
        beFields.firstName= 'TEST_FNAME';
        beFields.profileId= '000';
        beFields.profileName= 'TEST_PROF';
        beFields.baseElementLANID= 'abionj01';
        beFields.baseElementName= 'ASA-Trustee-kGen-000-abionj01';    

           /*  beFields.empID= '1111'; 
        beFields.lastName= 'TEST_LNAME';
        beFields.firstName= 'TEST_FNAME';
        beFields.profileId= '535';
        beFields.profileName= 'TEST_PROF';
        beFields.baseElementLANID= 'DHARP01';
        beFields.baseElementName= 'ASA-TRUSTEE-KGEN-535-DHARP01';*/
       // beElementInfo.add(beFields);
             
        beInfoUpdate.add(beFields);
        
        
       /*
         List<BMCServiceDesk__BMC_BaseElement__c> BElst = new List<BMCServiceDesk__BMC_BaseElement__c>();                      
         BMCServiceDesk__BMC_BaseElement__c BEO= new  BMCServiceDesk__BMC_BaseElement__c ();
         BEO= [select id,name,BMCServiceDesk__Inactive__c from BMCServiceDesk__BMC_BaseElement__c where name=: 'ASA-TRUSTEE-KGEN-932-tstV234769']; 
         BEO.BMCServiceDesk__Inactive__c = True;
                 
        // BElst.add(BEO);
        UPDATE BEO;
        BMCServiceDesk__BMC_BaseElement__c BEODate= new  BMCServiceDesk__BMC_BaseElement__c ();
        BEODate= [select id,name,BMCServiceDesk__Inactive__c from BMCServiceDesk__BMC_BaseElement__c where name=: 'ASA-TRUSTEE-KGEN-932-tstV234769']; 
         BEODate.ASA_Verified_Date_Time__c = DateTime.now();
            
        // BElst.add(BEO);
        update BEODate;
        */
     /*  BMCServiceDesk__BMC_BaseElement__c BE = new BMCServiceDesk__BMC_BaseElement__c();
        
        //BE.Name ='ASA-TRUSTEE-KGEN-535-dharp01';
        BE.Name = 'ASA-TRUSTEE-KGEN-535';
        BE.Additional_System_Access__c = 'kGen Profile';
        BE.BMCServiceDesk__Name__c='dharp01';
       // BE.ASA_Application__c='ASA-TRUSTEE-KGEN-535';
        //BE.User__c = '005E0000008GxH6';
         BE.BMCServiceDesk__Inactive__c=TRUE;                     
        //BE.BMCServiceDesk__CMDB_Class__c = 'a1BE000000KXkHr';       
        //BE.BMCServiceDesk__LANID__c = 'dharp01';
        INSERT BE; */
        Test.StartTest();
        if(Test.isrunningtest())
        {
            WebServiceUpdate.UpdateBEInactive(beInfoUpdate);
            WebServiceUpdate.UpdateBEASAVerifiedDate(beInfoUpdate);
        }
        //List<BMCServiceDesk__BMC_BaseElement__c> BElist = new List<BMCServiceDesk__BMC_BaseElement__c>();                      
        // BMCServiceDesk__BMC_BaseElement__c BEOErr= new  BMCServiceDesk__BMC_BaseElement__c ();
        // BEOErr= [select id,name,BMCServiceDesk__Inactive__c from BMCServiceDesk__BMC_BaseElement__c where name=: 'ASA-Trustee-kGen-535']; 
        // BEOErr.BMCServiceDesk__Inactive__c = True;
         // BElist.add(BEOErr);        
        // BElst.add(BEO);
        //database.UPDATE (BElist,false);
        /*List<WebServiceUpdate.BEInfo> beInfoUpdateErr = new List<WebServiceUpdate.BEInfo>();
        WebServiceUpdate.BEInfo beFieldsErr =new  WebServiceUpdate.BEInfo();
        beFieldsErr.empID= '1111'; 
        beFieldsErr.lastName= 'TEST_LNAME';
        beFieldsErr.firstName= 'TEST_FNAME';
        beFieldsErr.profileId= '535';
        beFieldsErr.profileName= 'TEST_PROF';
        beFieldsErr.baseElementLANID= 'tstV234769';
        beFieldsErr.baseElementName= 'ASA-TRUSTEE-KGEN-535';
             
        beInfoUpdateErr.add(beFieldsErr);
        WebServiceUpdate.UpdateBEInactive(beInfoUpdateErr);
        WebServiceUpdate.UpdateBEASAVerifiedDate(beInfoUpdateErr);*/
        //BMCServiceDesk__BMC_BaseElement__c BEODateErr= new  BMCServiceDesk__BMC_BaseElement__c ();
        //BEODateErr= [select id,name,BMCServiceDesk__Inactive__c from BMCServiceDesk__BMC_BaseElement__c where name=: 'ASA-Trustee-kGen-535']; 
        // BEODateErr.ASA_Verified_Date_Time__c = DateTime.now();
            
        // BElst.add(BEO);
        //update BEODateErr;
        
       
        Test.StopTest(); 
       
        
    }

}