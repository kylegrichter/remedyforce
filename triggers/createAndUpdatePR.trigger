/******************************************************************************
Name:  createAndUpdatePR
Copyright © 2014  DexMedia Inc. 
==============================================================================
Purpose:                                                            
This class to create a Defect in Ralley when a PR is inserted and update the defect when updated in Remedy
==============================================================================
History                                                            
-------                                                            
VERSION     AUTHOR              DATE           DETAIL           FEATURES/CSR/TTP
------      ------              -----         ---------         -----------------
1.0       Guru Vattam         04/01/2014     Initial Development           
*****************************************************************************/
trigger createAndUpdatePR on BMCServiceDesk__Problem__c (after insert, after update) {
	set<id> problemIds = new set<id>();
	String sessionId = userInfo.getSessionId();
	String ServerUrl = URL.getSalesforceBaseUrl().toExternalForm()+'/services/Soap/c/23.0/'+UserInfo.getOrganizationId().subString(0,15);
	system.debug('ServerUrl'+ServerUrl);
    ID userId = userInfo.getUserId();
    Id ProblemRecordId = trigger.new[0].id;
    system.debug('ProblemRecordId'+ProblemRecordId);
    User usrObj = [select Id,Name from User where id=:userId limit 1 ];
    ID userProfileId = userInfo.getProfileId();    
    Profile TbcoUser = new Profile();    
    TbcoUser = [Select Id from Profile WHERE Name = 'API' limit 1];  
    Id TbcoUserId = TbcoUser.Id;
    
    
    list<BMCServiceDesk__Problem__c> PrObj = [select Id,RalleyID__c,ServiceIsCalled__c,BMCServiceDesk__FKStaff__r.UserRole.Name,BMCServiceDesk__FKStaff__r.Name from BMCServiceDesk__Problem__c where 
                                              BMCServiceDesk__FKStaff__r.UserRole.Name IN ('SharedApps-Dev-Acn','SharedApps-Dev-SM','DigitalProd-Dev-SM','DigitalProd-Dev-DO','DigitalProd-Dev-TCS') 
                                              and Id=:ProblemRecordId limit 1 ];
    if(probj.size()>0)
    {
    system.debug('Role Name'+PrObj[0].BMCServiceDesk__FKStaff__r.UserRole.Name);
    String UserName = PrObj[0].BMCServiceDesk__FKStaff__r.Name;
    system.debug(':::::'+UserName);
    
    try{
		for(BMCServiceDesk__Problem__c ProblemObj:trigger.new){
			problemIds.add(ProblemObj.Id);  
			
		}
		
	   if(Trigger.isInsert){	  
		if(PrObj[0].BMCServiceDesk__FKStaff__r.UserRole.Name!=null && PrObj[0].ServiceIsCalled__c!=true){
		  for (BMCServiceDesk__Problem__c PR:trigger.new){	
			createPRController.CreatePr(PR.Id, sessionId, UserName, ServerUrl);
			PrObj[0].ServiceIsCalled__c=true;
			update PrObj; 
		   }
			
		}  
	   }
	   if(Trigger.isUpdate){	  
		if(PrObj[0].BMCServiceDesk__FKStaff__r.UserRole.Name!=null && PrObj[0].RalleyID__c==null && PrObj[0].ServiceIsCalled__c!=true){
	      for(BMCServiceDesk__Problem__c PR:trigger.old){	
			createPRController.CreatePr(PR.Id, sessionId, UserName, ServerUrl); 
			PrObj[0].ServiceIsCalled__c=true;
			update PrObj; 
		   } 
		 }else  
	   if(userProfileId != TbcoUserId){ 
		  if(PrObj[0].BMCServiceDesk__FKStaff__r.UserRole.Name!=null && PrObj[0].RalleyID__c!=null){
		      for (BMCServiceDesk__Problem__c PR:trigger.old){	
			    createPRController.UpdatePr(PR.Id, sessionId, UserName, ServerUrl);
		      } 
			 }
	     }
	   } 
     }  
     catch(exception e){
	}
       
    }

}