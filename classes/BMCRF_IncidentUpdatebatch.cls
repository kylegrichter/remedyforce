global class BMCRF_IncidentUpdatebatch implements Database.Batchable<sObject>,Database.AllowsCallouts {
    global Database.QueryLocator start(Database.BatchableContext BC) {
        String query = 'SELECT Id,Name,BMCRF_Everbridge_Incident__c,BMCServiceDesk__FKOpenBy__c,BMCRF_Assigned_By_EB__c' 
                       +' FROM BMCServiceDesk__Incident__c where BMCRF_Assigned_By_EB__c = false '+
                        ' AND BMCRF_Everbridge_Incident__c!=null AND BMCServiceDesk__State__c =true';
        return Database.getQueryLocator(query);
    }
   
    global void execute(Database.BatchableContext BC, List<BMCServiceDesk__Incident__c> scope) {
        //call to the Mehtod getDetails
        BMCRF_getEverbridgeResponses e =new BMCRF_getEverbridgeResponses();
        try{
        e.getIncidentNotification(scope);
        }
        catch(Exception exc){}
    }   
    
    global void finish(Database.BatchableContext BC) {
    }
}