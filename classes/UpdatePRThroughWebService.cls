/******************************************************************************
Name:  UpdatePRThroughWebService
Copyright © 2014  DexMedia Inc. 
==============================================================================
Purpose:                                                            
Updates PR info from Ralley
==============================================================================
History                                                            
-------                                                            
VERSION     AUTHOR              DATE           DETAIL           FEATURES/CSR/TTP
------      ------              -----         ---------         -----------------
1.0       Guru Vattam          03/20/2014     Initial Development      
*****************************************************************************/
global class UpdatePRThroughWebService{


/******************************************************************************  
 This method is to Update PR info through webservice
 *****************************************************************************/
    global class UpdatePRInfo {
          webservice string PRNumber;
          webservice string Description;
          webservice string Resolution;
          webservice string Workaround;
          webservice string RootCauseAnalysis;
          webservice string RCASource;
          webservice string RCAReasonCode;
          webservice string ScrumTeam;
          webservice string ConfigurationItem;
          webservice string Priority;
          webservice string Status;
          webservice string Impact;
          webservice string Urgency;
          webservice Boolean FalloutIndicator;
          webservice string ChangeRecord;
          webservice string MigratedBy ;
          webservice string ReleaseManagerNotes ;
          webservice string Checkoutby;
          webservice string CheckoutDuration;
          webservice string Dependencies ;
      }
     
     WebService static String UpdatePR(UpdatePRInfo UpdatePR) {
        
            String strReturn = '';
            String ProblemNumber = UpdatePR.PRNumber.trim();
            string PRDescription = UpdatePR.Description.trim();
            string PRResolution= UpdatePR.Resolution.trim();
            string PRWorkaround= UpdatePR.Workaround.trim();
            string PRRootCauseAnalysis= UpdatePR.RootCauseAnalysis.trim();
            string PRRCASource= UpdatePR.RCASource.trim();
            string PRRCAReasonCode= UpdatePR.RCAReasonCode.trim();
            string PRScrumTeam= UpdatePR.ScrumTeam.trim();
            string PRConfigurationItem= UpdatePR.ConfigurationItem.trim();
            string PRPriority= UpdatePR.Priority.trim();
            string PRStatus= UpdatePR.Status.trim();
            string PRImpact= UpdatePR.Impact.trim();
            string PRUrgency= UpdatePR.Urgency.trim();
            Boolean PRFalloutIndicator= UpdatePR.FalloutIndicator;
            string PRChangeRecord= UpdatePR.ChangeRecord.trim();
            string PRMigratedBy = UpdatePR.MigratedBy.trim();
            string PRReleaseManagerNotes = UpdatePR.ReleaseManagerNotes.trim();
            string PRCheckoutby= UpdatePR.Checkoutby.trim();
            string PRCheckoutDuration= UpdatePR.CheckoutDuration.trim();
            string PRDependencies = UpdatePR.Dependencies.trim();
            
            BMCServiceDesk__Problem__c PrblmObj = [select id,BMCServiceDesk__Problem_Description__c,BMCServiceDesk__Problem_Resolution__c,BMCServiceDesk__Work_Around__c,Root_Cause_Analysis__c,RCA_Source__c,
                                                   RCA_Reason_Code__c,Scrum_Team__c,FKBMC_BaseElement__c,BMCServiceDesk__FKPriority__c,BMCServiceDesk__FKStatus__c,BMCServiceDesk__FKImpact__c,
                                                   BMCServiceDesk__FKUrgency__c,Fallout__c,Migrated_By__c,Release_Manager_Notes__c,Checkout_By__c,Checkout_Duration__c,
                                                   Dependencies__c from BMCServiceDesk__Problem__c where Name=:ProblemNumber];
                                                   
            
            if(PrblmObj != null ){
                PrblmObj.BMCServiceDesk__Problem_Description__c = PRDescription;
                PrblmObj.BMCServiceDesk__Problem_Resolution__c = PRResolution;
                PrblmObj.BMCServiceDesk__Work_Around__c = PRWorkaround;
                PrblmObj.Root_Cause_Analysis__c = PRRootCauseAnalysis;
                PrblmObj.RCA_Source__c = PRRCASource;
                PrblmObj.RCA_Reason_Code__c = PRRCAReasonCode;
                PrblmObj.Scrum_Team__c = PRScrumTeam;
                PrblmObj.Fallout__c = PRFalloutIndicator;
                PrblmObj.Change_Record__c = PRChangeRecord;
                PrblmObj.Migrated_By__c = PRMigratedBy;
                PrblmObj.Release_Manager_Notes__c = PRReleaseManagerNotes;
                PrblmObj.Checkout_By__c = PRCheckoutby;
                PrblmObj.Checkout_Duration__c = PRCheckoutDuration;
                PrblmObj.Dependencies__c = PRDependencies;
                PrblmObj.FKBMC_BaseElement__c  = [Select id from BMCServiceDesk__BMC_BaseElement__c where Name=:PRConfigurationItem limit 1].id;
                PrblmObj.BMCServiceDesk__FKPriority__c = [Select id from BMCServiceDesk__Priority__c where Name=:PRPriority limit 1].id;
                PrblmObj.BMCServiceDesk__FKStatus__c = [select id from BMCServiceDesk__Status__c where Name=:PRStatus limit 1].id; 
                PrblmObj.BMCServiceDesk__FKImpact__c = [select id from BMCServiceDesk__Impact__c where Name=:PRImpact limit 1].id;
                PrblmObj.BMCServiceDesk__FKUrgency__c = [select id from BMCServiceDesk__Urgency__c where Name=:PRUrgency limit 1].id;
                
                
                                                       
            }
            
                                                   
                                                   
            
            try{
                Database.Saveresult sr=Database.Update(PrblmObj);
                if(sr.isSuccess()) {
                strReturn ='PR has been updated sucessfully';      
                }
                return strReturn;
              }
            catch(Exception e){
               return String.ValueOf(e.getMessage());
             } 
      }

}