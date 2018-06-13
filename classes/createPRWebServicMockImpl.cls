/******************************************************************************
Name:  createPRWebServicMockImpl
Copyright © 2013  DexMedia Inc. 
==============================================================================
Purpose:                                                            
This is the Test Class which creates Mock Webservice Response for createPRControllerTest
 to cover the invoke call
==============================================================================
History                                                            
-------                                                            
VERSION     AUTHOR              DATE           DETAIL           FEATURES/CSR/TTP
------      ------              -----         ---------         -----------------
1.0        Guru Vattam        06/17/2014    Initial Development      
*****************************************************************************/

@isTest
global class createPRWebServicMockImpl implements WebServiceMock {
	global void doInvoke(
           Object stub,
           Object request,
           Map<String, Object> response,
           String endpoint,
           String soapAction,
           String requestName,
           String responseNS,
           String responseName,
           String responseType) {
           	List<wwwTibcoComSchemasRallyInterfaceSh.exceptionDetail> respServiceFaultList = new List<wwwTibcoComSchemasRallyInterfaceSh.exceptionDetail>();
	        wwwTibcoComSchemasRallyInterfaceSh.exceptionDetail respServiceFaultObj = new wwwTibcoComSchemasRallyInterfaceSh.exceptionDetail();
	        respServiceFaultObj.errorDescription = 'Failed';
	        respServiceFaultList.add(respServiceFaultObj);
	       
	        List<wwwTibcoComSchemasRallyInterfaceSh.esbFault> esbServiceFaultObjList = new List<wwwTibcoComSchemasRallyInterfaceSh.esbFault>();
	        wwwTibcoComSchemasRallyInterfaceSh.esbFault esbServiceFaultObj = new wwwTibcoComSchemasRallyInterfaceSh.esbFault();
	        esbServiceFaultObj.exceptionDetail = respServiceFaultList;
	        esbServiceFaultObjList.add(esbServiceFaultObj);
	       
	            
            wwwTibcoComSchemasRallyInterfaceSh.PRUpdateRes RespObj = new wwwTibcoComSchemasRallyInterfaceSh.PRUpdateRes();
            RespObj.status = 'success';
            RespObj.rallyId = 'DE122';
            RespObj.rallyObjectUrl ='www.dexmedia.com';
            RespObj.transactionId = 'Test';
	        RespObj.hasWarningOrError = 'true';
	        RespObj.esbServiceFault = esbServiceFaultObjList;
           	
           	
           	 response.put('response_x', RespObj);
           	
           }
	
	
}