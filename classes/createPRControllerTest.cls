/******************************************************************************
Name:  createPRControllerTest
Copyright © 2014  DexMedia Inc. 
==============================================================================
Purpose:                                                            
This is the Test Class which covers createPRController class with
all the Positive & Negative scenarios
==============================================================================
History                                                            
-------                                                            
VERSION     AUTHOR              DATE           DETAIL           FEATURES/CSR/TTP
------      ------              -----         ---------         -----------------
1.0       Guru Vattam          06/16/2014     Initial Development      
*****************************************************************************/

@isTest(SeeAllData=true)

public class createPRControllerTest {

    @isTest static void TestCreatePR() {
         String sessionId = userInfo.getSessionId();
         String ServerUrl = URL.getSalesforceBaseUrl().toExternalForm()+'/services/Soap/c/23.0/'+UserInfo.getOrganizationId().subString(0,15);
         ID userId = userInfo.getUserId();
         User usrObj = [select Id,Name from User where id=:userId limit 1 ];
         String UserName = usrObj.Name;
         
         BMCServiceDesk__Category__c cat = new BMCServiceDesk__Category__c ( Name = 'TIB_TEST_CATEGORY');
         Insert cat;
         BMCServiceDesk__Problem__c PrObj = new BMCServiceDesk__Problem__c();
         PrObj.BMCServiceDesk__FKCategory__c = cat.id;
         PrObj.OwnerId = [select id from group where type = 'queue' and (not name like 'Do Not Use%') limit 1].id;
         insert PrObj ;
         
         Test.setMock(WebServiceMock.class, new createPRWebServicMockImpl());
         
         Test.startTest();
         createPRController.CreatePr(PrObj.Id, sessionId, UserName, ServerUrl);
         createPRController.UpdatePr(PrObj.Id, sessionId, UserName, ServerUrl);
         Test.stopTest();
    }
    
    
     static testMethod void testPortTypeEndpoint(){
        xmlnsExampleCom1395789827798 obj = new xmlnsExampleCom1395789827798();
        xmlnsExampleCom1395789827798.prCreatePortTypeEndpoint1 testStub = new xmlnsExampleCom1395789827798.prCreatePortTypeEndpoint1();
    }
    
     static testMethod void linkedChangeRequests(){
        wwwTibcoComSchemasRallyInterfaceSh obj = new wwwTibcoComSchemasRallyInterfaceSh();
        wwwTibcoComSchemasRallyInterfaceSh.linkedChangeRequests_element testlinked = new wwwTibcoComSchemasRallyInterfaceSh.linkedChangeRequests_element();
    }
     static testMethod void linkedIncidents(){
        wwwTibcoComSchemasRallyInterfaceSh obj = new wwwTibcoComSchemasRallyInterfaceSh();
        wwwTibcoComSchemasRallyInterfaceSh.linkedIncidents_element testlinkedInc = new wwwTibcoComSchemasRallyInterfaceSh.linkedIncidents_element();
    }
     static testMethod void PRCreate(){
        wwwTibcoComSchemasRallyInterfaceSh obj = new wwwTibcoComSchemasRallyInterfaceSh();
        wwwTibcoComSchemasRallyInterfaceSh.PRCreate_element testcreatePr = new wwwTibcoComSchemasRallyInterfaceSh.PRCreate_element();
    }
     static testMethod void linkedTasks(){
        wwwTibcoComSchemasRallyInterfaceSh obj = new wwwTibcoComSchemasRallyInterfaceSh();
        wwwTibcoComSchemasRallyInterfaceSh.linkedTasks_element testlinkedTask = new wwwTibcoComSchemasRallyInterfaceSh.linkedTasks_element();
    }
     static testMethod void prCreateRequest_element(){
        wwwTibcoComSchemasRallyInterfaceSh obj = new wwwTibcoComSchemasRallyInterfaceSh();
        wwwTibcoComSchemasRallyInterfaceSh.prCreateRequest_element testcreatePREle = new wwwTibcoComSchemasRallyInterfaceSh.prCreateRequest_element();
    }
    static testMethod void prUpdate(){
        wwwTibcoComSchemasRallyInterfaceSh obj = new wwwTibcoComSchemasRallyInterfaceSh();
        wwwTibcoComSchemasRallyInterfaceSh.prUpdate testcreatePREle = new wwwTibcoComSchemasRallyInterfaceSh.prUpdate();
    }
    static testMethod void esbFault(){
        wwwTibcoComSchemasRallyInterfaceSh obj = new wwwTibcoComSchemasRallyInterfaceSh();
        wwwTibcoComSchemasRallyInterfaceSh.esbFault testesbFault = new wwwTibcoComSchemasRallyInterfaceSh.esbFault();
    }
    static testMethod void pvEsbSecurityInfo(){
        wwwTibcoComSchemasRallyInterfaceSh obj = new wwwTibcoComSchemasRallyInterfaceSh();
        wwwTibcoComSchemasRallyInterfaceSh.pvEsbSecurityInfo testpvEsbSecurityInfo = new wwwTibcoComSchemasRallyInterfaceSh.pvEsbSecurityInfo();
    }
    
    
     
    
}