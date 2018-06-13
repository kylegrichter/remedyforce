/******************************************************************************
Name:  UpdateTaskInfo
Copyright © 2014  DexMedia Inc. 
==============================================================================
Purpose:                                                            
This class to update the Task Info when updated in Remedy
==============================================================================
History                                                            
-------                                                            
VERSION     AUTHOR              DATE           DETAIL           FEATURES/CSR/TTP
------      ------              -----         ---------         -----------------
1.0       Guru Vattam         06/04/2014     Initial Development           
*****************************************************************************/
trigger UpdateTaskInfo on BMCServiceDesk__Task__c (after update) {
	String sessionId = userInfo.getSessionId();
	String ServerUrl = URL.getSalesforceBaseUrl().toExternalForm()+'/services/Soap/c/23.0/'+UserInfo.getOrganizationId().subString(0,15);
	ID userProfileId = userInfo.getProfileId();    
    Profile TbcoUser = new Profile();    
    TbcoUser = [Select Id from Profile WHERE Name = 'API' limit 1];  
    Id TbcoUserId = TbcoUser.Id;
	
	
	if(Trigger.isUpdate){
	  if(userProfileId != TbcoUserId){		 
		for(BMCServiceDesk__Task__c TaskObj :Trigger.new){
			if(TaskObj.Rally_URL__c!=null && TaskObj.User_Story__c!=null){  
				UpdateTaskInfoController.UpdateTaskInfo(TaskObj.Id, sessionId, ServerUrl);
			}
			
		}
	}
 }
}