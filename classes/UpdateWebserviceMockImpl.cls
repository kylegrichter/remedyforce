/******************************************************************************
Name:  UpdateWebserviceMockImpl
Copyright © 2013  DexMedia Inc. 
==============================================================================
Purpose:                                                            
This is the Test Class which creates Mock Webservice Response for
UpdateStatusController to cover the invoke call
==============================================================================
History                                                            
-------                                                            
VERSION     AUTHOR              DATE           DETAIL           FEATURES/CSR/TTP
------      ------              -----         ---------         -----------------
1.0     Guru R. Vattam    05/08/2013    Initial Development      
*****************************************************************************/

@isTest

global class UpdateWebserviceMockImpl implements  WebServiceMock {
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
            List<RGVwwwSupermediaComRemedyforcemanagement.ServiceFault> servicefaultList = new List<RGVwwwSupermediaComRemedyforcemanagement.ServiceFault>();
            RGVwwwSupermediaComRemedyforcemanagement.ServiceFault servicefault = new RGVwwwSupermediaComRemedyforcemanagement.ServiceFault();
            servicefault.errorDescription = 'No Records Found';
            servicefaultList.add(servicefault);
            
            RGVwwwSupermediaComRemedyforcemanagement.ESBServiceFault esbservice = new RGVwwwSupermediaComRemedyforcemanagement.ESBServiceFault();
            esbservice.exceptionDetail = servicefaultList;
            
            RGVwwwSupermediaComRemedyforcemanagement.UpdateStatusRes_element Resp = new RGVwwwSupermediaComRemedyforcemanagement.UpdateStatusRes_element();
            Resp.hasWarningOrError = false;
            Resp.esbServiceFault = esbservice;
            Resp.transactionid = 'guru';
            response.put('response_x', Resp);
           }

}