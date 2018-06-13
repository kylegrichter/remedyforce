trigger BMCRF_Incident1 on BMCServiceDesk__Incident__c (after insert,after update) {
    if(System.isFuture()) {
        return;
    }
    Map<String, String> incidentFields_map;
    Map<ID,User> userEBId_Map=new Map<ID,User>([SELECT id, BMCRF_EB_ID__c FROM User WHERE BMCRF_Everbridge_Sync__c = true]);
    Map<String,BMCRF_Everbridge_Group_Details__c> groupEBId_Map = new Map<String,BMCRF_Everbridge_Group_Details__c>([select name,BMCRF_Everbridge_ID__c from BMCRF_Everbridge_Group_Details__c]);
    System.debug('----------------------------- INCIDENT TRIGGER START -------------------------');
    
    BMCRF_HELPER_EvaluateCondition evaluateConditionObj=new BMCRF_HELPER_EvaluateCondition('Incident');
    
    Map<Id, String> tempConf = new Map<Id, String>();
    List<BMCServiceDesk__SYSTemplate__c>Tlist =  [select id,name from BMCServiceDesk__SYSTemplate__c where BMCServiceDesk__templateFor__c = 'Incident'];
    for ( BMCServiceDesk__SYSTemplate__c SYST : Tlist ){
        tempConf.put( SYST.Id, SYST.Name);
    }
    
    for(BMCServiceDesk__Incident__c inc: Trigger.new) {
        if(!Trigger.isInsert && !Trigger.isUpdate) {
            return;
        } 
        String template = null;
        try {
            template = tempConf.get(inc.BMCServiceDesk__FKTemplate__c);
        } catch (Exception e ) {
            //todo: fix logic to avoid exception handler
        }
        incidentFields_map=new Map<String,String>();
        incidentFields_map.put('Id',inc.id);
        incidentFields_map.put('Name', inc.name);
        incidentFields_map.put('Incident ID',inc.name);
        incidentFields_map.put('BMCServiceDesk__Category_ID__c',inc.BMCServiceDesk__Category_ID__c);
        incidentFields_map.put('BMCServiceDesk__Queue__c',inc.BMCServiceDesk__Queue__c);
        incidentFields_map.put('BMCServiceDesk__Client_Account__c',inc.BMCServiceDesk__Client_Account__c);
        incidentFields_map.put('BMCServiceDesk__Impact_Id__c',inc.BMCServiceDesk__Impact_Id__c);
        incidentFields_map.put('BMCServiceDesk__Urgency_ID__c',inc.BMCServiceDesk__Urgency_ID__c);
        incidentFields_map.put('BMCServiceDesk__Priority_ID__c',inc.BMCServiceDesk__Priority_ID__c);
        incidentFields_map.put('BMCServiceDesk__Client_Account__c',inc.BMCServiceDesk__Client_Account__c);
        incidentFields_map.put('BMCServiceDesk__Status_ID__c',inc.BMCServiceDesk__Status_ID__c);
        incidentFields_map.put('BMCServiceDesk__TemplateName__c', (template != null ? template : ''));
        incidentFields_map.put('BMCServiceDesk__clientId__c',inc.BMCServiceDesk__clientId__c);
        incidentFields_map.put('BMCServiceDesk__incidentDescription__c',inc.BMCServiceDesk__incidentDescription__c);         
        incidentFields_map.put('BMCServiceDesk__incidentResolution__c',inc.BMCServiceDesk__incidentResolution__c);
        incidentFields_map.put('BMCRF_EverBridge_Incident__c',inc.BMCRF_EverBridge_Incident__c +'');
        
        incidentFields_map.put('Notification_Group__c', (inc.Notification_Group__c != null ? inc.Notification_Group__c : 'P1-'+inc.BMCServiceDesk__Queue__c));
        incidentFields_map.put('Incident_Title__c',inc.Incident_Title__c);
        
        
        Map<String,String> conditionData=evaluateConditionObj.evaluateCondition(incidentFields_map); 
        if (conditionData.get('TemplateId') != null) {
            if(conditionData.get('OverrideContactGroup') == 'true') {
                if(groupEBId_Map.containsKey(inc.Owner.Name)) {
                    String groupId=groupEBId_Map.get(inc.Owner.Name).BMCRF_Everbridge_ID__c;
                    if(groupId!=NULL) {
                        groupId=groupId.trim();
                        incidentFields_map.put('groupId',groupId);
                    }
                }  
            }
            if(conditionData.get('OverrideContact') == 'true') {
                if(userEBId_Map.containsKey(inc.BMCServiceDesk__FKOpenBy__c)) {
                    String contactId=userEBId_Map.get(inc.BMCServiceDesk__FKOpenBy__c).BMCRF_EB_ID__c;
                    if(contactId!=NULL) {
                        contactId=contactId.trim();
                        incidentFields_map.put('contactId',contactId);
                    }
                }
            }
        }
        if(Trigger.isInsert && inc.BMCServiceDesk__Status_ID__c != 'CLOSED' && conditionData.get('TemplateId') != null) {  
            System.debug('NEW INC');
            BMCRF_Parser_EBCreateIncident.createEBIncident('Launch',conditionData.get('TemplateId'),incidentFields_map,'Incident');
        } else if (Trigger.isUpdate && inc.BMCRF_EverBridge_Incident__c != null && inc.Everbridge_Template_ID__c!='') { //only process if updated and has existing EB incident
            System.debug('CHANGEDINC');   
            if(inc.BMCServiceDesk__Status_ID__c.equalsignorecase('CLOSED') ||  inc.BMCServiceDesk__incidentDescription__c == 'TEST:-FORCE-CLOSE') { // launch close 
                System.debug('EB CLOSE');  
                BMCRF_Parser_EBCreateIncident.createEBIncident( 
                    ( (conditionData == null || conditionData.get('TemplateId') == null|| conditionData.get('closeWithoutNotification') == 'true') ? // if configuration exists, close with config condition, or default to w/o notification
                     'CloseWithoutNotification' : 
                     'CloseWithNotification'),
                    inc.Everbridge_Template_ID__c,incidentFields_map,
                    'Incident'
                );
            } else {
                // only update if these fields have changed
                if(
                    Trigger.oldMap.get(inc.id).BMCServiceDesk__incidentDescription__c!=inc.BMCServiceDesk__incidentDescription__c || 
                    Trigger.oldMap.get(inc.id).BMCServiceDesk__Impact_Id__c!=inc.BMCServiceDesk__Impact_Id__c || 
                    Trigger.oldMap.get(inc.id).BMCServiceDesk__Urgency_ID__c!=inc.BMCServiceDesk__Urgency_ID__c || 
                    Trigger.oldMap.get(inc.id).BMCServiceDesk__Priority_ID__c!=inc.BMCServiceDesk__Priority_ID__c ||
                    Trigger.oldMap.get(inc.id).BMCServiceDesk__FKStatus__c != inc.BMCServiceDesk__FKStatus__c ) {       
                        System.debug('EB CHANGE');  
                        // performa actual EB launch
                        BMCRF_Parser_EBCreateIncident.createEBIncident(
                            'Update',
                            inc.Everbridge_Template_ID__c,incidentFields_map,
                            'Incident'
                        );
                    }
            }
        }  
    }    
}