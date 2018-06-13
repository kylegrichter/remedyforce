global class BMCRF_ChangeUpdatebatch implements Database.Batchable<sObject>,Database.AllowsCallouts {
    global Database.QueryLocator start(Database.BatchableContext BC) {
        String query = 'SELECT Id,Name,BMCRF_Everbridge_ID__c,BMCServiceDesk__FKStaff__c,BMCRF_Assigned_By_EB__c' 
                       +' FROM BMCServiceDesk__Change_Request__c where BMCRF_Assigned_By_EB__c = false '+
                        ' AND BMCRF_Everbridge_ID__c!=null AND BMCServiceDesk__State__c =true';
        return Database.getQueryLocator(query);
    }
   
    global void execute(Database.BatchableContext BC, List<BMCServiceDesk__Change_Request__c> scope) {
        //call to the Mehtod getDetails
        BMCRF_getEverbridgeResponsesChange e =new BMCRF_getEverbridgeResponsesChange();
        try{
        e.getIncidentNotification(scope);
        }
        catch(Exception exc){}
    }   
    
    global void finish(Database.BatchableContext BC) {
    }
}