/******************************************************************************
Name:  TestUpdateStatusController
Copyright © 2013  DexMedia Inc. 
==============================================================================
Purpose:                                                            
This is the Test Class which covers UpdateStatusController class with
all the Positive & Negative scenarios
==============================================================================
History                                                            
-------                                                            
VERSION     AUTHOR              DATE           DETAIL           FEATURES/CSR/TTP
------      ------              -----         ---------         -----------------
1.0     Guru R. Vattam    05/08/2013    Initial Development
1.0     Jason D. Boyer    05/12/2013   Updated to clear RGVwwwSupermediaComRemedyforcemanagement 100% 
                                       and removed reference to static ticket in TestupdateStatusController Mock Webservice
                                       callout by calling any live IR.
2.0     Jason D. Boyer    06/17/2013    Per SR#00070198 - fixed to send back status 
                                        and incident ID as per original request                                                                  
*****************************************************************************/

@isTest(seeAllData= true)

public class TestUpdateStatusController {

    
    
    @isTest static void TestUpdateStatusController(){
        BMCServiceDesk__Incident__c AnyExistingIR = [SELECT Name, BMCServiceDesk__Status_ID__c 
                                                     FROM BMCServiceDesk__Incident__c
                                                     WHERE BMCServiceDesk__state__c = true 
                                                     LIMIT 1];
        Test.setMock(WebServiceMock.class, new UpdateWebserviceMockImpl());
        Test.startTest();
        updateStatusController.updateStatus( AnyExistingIR.Name, AnyExistingIR.BMCServiceDesk__Status_ID__c, AnyExistingIR.Id );
        Test.stopTest();
     }  
     
     static testmethod void testUpdateStatusReq_element(){
        RGVwwwSupermediaComRemedyforcemanagement Remedy = new RGVwwwSupermediaComRemedyforcemanagement();
        RGVwwwSupermediaComRemedyforcemanagement.UpdateStatusReq_element updatesReq = new RGVwwwSupermediaComRemedyforcemanagement.UpdateStatusReq_element();
        
     }
     static testmethod void testUpdateStatusRes_element(){
        RGVwwwSupermediaComRemedyforcemanagement Remedy = new RGVwwwSupermediaComRemedyforcemanagement();
        RGVwwwSupermediaComRemedyforcemanagement.UpdateStatusRes_element updatesResp = new RGVwwwSupermediaComRemedyforcemanagement.UpdateStatusRes_element();
        
        
     }
     static testmethod void testServiceFault(){
        RGVwwwSupermediaComRemedyforcemanagement Remedy = new RGVwwwSupermediaComRemedyforcemanagement();
        RGVwwwSupermediaComRemedyforcemanagement.ServiceFault sfault = new RGVwwwSupermediaComRemedyforcemanagement.ServiceFault();
     }
     static testmethod void testESBServiceFault(){
        RGVwwwSupermediaComRemedyforcemanagement Remedy = new RGVwwwSupermediaComRemedyforcemanagement();
        RGVwwwSupermediaComRemedyforcemanagement.ESBServiceFault esbfault = new RGVwwwSupermediaComRemedyforcemanagement.ESBServiceFault();
     }
     static testmethod void testESBSecurityInfo(){
        RGVwwwSupermediaComRemedyforcemanagement Remedy = new RGVwwwSupermediaComRemedyforcemanagement();
        RGVwwwSupermediaComRemedyforcemanagement.ESBSecurityInfo esbInfo = new RGVwwwSupermediaComRemedyforcemanagement.ESBSecurityInfo();
     }
     static testmethod void testSourceAppInfo(){
        RGVwwwSupermediaComRemedyforcemanagement Remedy = new RGVwwwSupermediaComRemedyforcemanagement();
        RGVwwwSupermediaComRemedyforcemanagement.SourceAppInfo sourceapp = new RGVwwwSupermediaComRemedyforcemanagement.SourceAppInfo();
     }
     
     static testmethod void testRemedyForceManagementServiceEndpoint1(){
        RGVwwwSupermediaComRemedyforcemanagement Remedy = new RGVwwwSupermediaComRemedyforcemanagement();
        RGVwwwSupermediaComRemedyforcemanagement.RemedyForceManagementServiceEndpoint1 stub = new RGVwwwSupermediaComRemedyforcemanagement.RemedyForceManagementServiceEndpoint1();
     }
     
     
}