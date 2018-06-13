public class BMCRF_CNTRL_EBLandingPage {

    public string recordID{get;set;}

    public BMCRF_CNTRL_EBLandingPage() {
    
        BMCRF_EB_Incident_Configuration__c EB_Config = [select ID, BMCRF_Everbridge_Webhook_URL__c, BMCRF_Everbridge_Organization_ID__c, BMCRF_Everbridge_Username__c, 
                                                               BMCRF_Everbridge_Password__c, BMCRF_Everbridge_API_URL_Base__c, BMCRF_Everbridge_External_ID_Field__c
                                                            from BMCRF_EB_Incident_Configuration__c limit 1];
                                                            
        recordID = EB_Config.id;
    } 

    public String getEbID() {
        BMCRF_EB_Incident_Configuration__c EB_Config = [select ID from BMCRF_EB_Incident_Configuration__c limit 1];
        return EB_Config.ID;
    }
}