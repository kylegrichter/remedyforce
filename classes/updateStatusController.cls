/******************************************************************************
Name:  updateStatusController
Copyright © 2013  DexMedia Inc. 
==============================================================================
Purpose:                                                            
This is the Class is to Update the status of the Incident to TIBCO.
==============================================================================
History                                                            
-------                                                            
VERSION     AUTHOR              DATE           DETAIL           FEATURES/CSR/TTP
------      ------              -----         ---------         -----------------
1.0     Guru R. Vattam    05/08/2013    Initial Development      
2.0     Jason D. Boyer    06/17/2013    Per SR#00070198 - fixed to send back status 
                                        and incident ID as per original request
*****************************************************************************/

public class updateStatusController {
    
    
    @future(callout =true)  
    
    public static void updateStatus(string incidentno, string incidentStatus, string incidentId){
        RGVwwwSupermediaComRemedyforcemanagement.RemedyForceManagementServiceEndpoint1 stub = new RGVwwwSupermediaComRemedyforcemanagement.RemedyForceManagementServiceEndpoint1();
        
        RGVwwwSupermediaComRemedyforcemanagement.UpdateStatusRes_element Resp = new RGVwwwSupermediaComRemedyforcemanagement.UpdateStatusRes_element();
        Resp = stub.UpdateStatus( incidentno, incidentStatus, incidentId );
       
    }
}