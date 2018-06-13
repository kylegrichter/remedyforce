trigger BMCRF_ChangeRequest on BMCServiceDesk__Change_Request__c (after insert,after update) 
{
    Map<String, String> changeRequestFields_map;
    Map<ID,User> userEBId_Map=new Map<ID,User>([SELECT id, BMCRF_EB_ID__c FROM User WHERE BMCRF_Everbridge_Sync__c = true]);
     Map<String,BMCRF_Everbridge_Group_Details__c> groupEBId_Map = new Map<String,BMCRF_Everbridge_Group_Details__c>([select name,BMCRF_Everbridge_ID__c from BMCRF_Everbridge_Group_Details__c]);

    for(BMCServiceDesk__Change_Request__c cr : Trigger.New)
    {
        if(trigger.isInsert)
        {
            changeRequestFields_map=new Map<String, String>();
            changeRequestFields_map.put('Id',cr.id);
            changeRequestFields_map.put('Name',cr.Name);
            changeRequestFields_map.put('BMCServiceDesk__Impact__c',cr.BMCServiceDesk__Impact__c);
            changeRequestFields_map.put('BMCServiceDesk__Urgency__c',cr.BMCServiceDesk__Urgency__c);
            changeRequestFields_map.put('BMCServiceDesk__Status__c',cr.BMCServiceDesk__Status__c);
            changeRequestFields_map.put('BMCServiceDesk__Priority__c',cr.BMCServiceDesk__Priority__c);
            changeRequestFields_map.put('BMCServiceDesk__Category__c',cr.BMCServiceDesk__Category__c);
            changeRequestFields_map.put('BMCServiceDesk__Reason_for_Change_Details__c',cr.BMCServiceDesk__Reason_for_Change_Details__c);
            
            BMCRF_HELPER_EvaluateCondition evaluateConditionObj=new BMCRF_HELPER_EvaluateCondition('Change Request');
            Map<String,String> conditionData=evaluateConditionObj.evaluateCondition(changeRequestFields_map); 
            
            if(conditionData.get('OverrideContactGroup')=='true')
            {
                if(groupEBId_Map.containsKey(cr.Owner.Name))
                {
                    String groupId=groupEBId_Map.get(cr.Owner.Name).BMCRF_Everbridge_ID__c;
                     if(groupId!=NULL)
                     {
                         groupId=groupId.trim();
                         changeRequestFields_map.put('groupId',groupId);
                     }
                }
             
            }
             if(conditionData.get('OverrideContact')=='true')
             {
                 if(userEBId_Map.containsKey(cr.BMCServiceDesk__FKStaff__c))
                 {
                     String contactId=userEBId_Map.get(cr.BMCServiceDesk__FKStaff__c).BMCRF_EB_ID__c;
                     if(contactId!=NULL)
                     {
                         contactId=contactId.trim();
                         changeRequestFields_map.put('contactId',contactId);
                     }
                 }
             }
            
            
            BMCRF_Parser_EBCreateIncident.createEBIncident('Launch',conditionData.get('TemplateId'),changeRequestFields_map,'Change Request'); 
            //String conditionData=evaluateConditionObj.evaluateCondition(changeRequestFields_map); 
            //BMCRF_Parser_EBCreateIncident.createEBIncident('Launch',conditionData,changeRequestFields_map,'Change Request'); 
        }
        else if(trigger.isUpdate)
        {
            if(Trigger.oldMap.get(cr.id).BMCServiceDesk__FKStatus__c!=cr.BMCServiceDesk__FKStatus__c)
            {
                changeRequestFields_map=new Map<String,String>();
                changeRequestFields_map.put('BMCRF_EverBridge_Incident__c',cr.BMCRF_Everbridge_Template_ID_c__c);
                changeRequestFields_map.put('BMCServiceDesk__Status_ID__c',cr.BMCServiceDesk__Status__c);   
                BMCRF_Parser_EBCreateIncident.createEBIncident('Update',cr.BMCRF_Everbridge_Template_ID_c__c,changeRequestFields_map,'Incident');
            }
        }
    }
}