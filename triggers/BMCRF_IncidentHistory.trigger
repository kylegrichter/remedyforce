trigger BMCRF_IncidentHistory on BMCServiceDesk__IncidentHistory__c (after insert) {

    Map<ID,User> userEBId_Map=new Map<ID,User>([Select id,BMCRF_EB_ID__c from User where isactive = true]);
    List<BMCRF_Everbridge_Group_Details__c> ebgrdetails=new List<BMCRF_Everbridge_Group_Details__c>([select BMCRF_Everbridge_Name__c,BMCRF_Everbridge_ID__c from BMCRF_Everbridge_Group_Details__c]);
    Map<String,String> groupEBId_Map = new Map<String,String>();
    for(BMCRF_Everbridge_Group_Details__c ebgr : ebgrdetails)
    {
        groupEBId_Map.put(ebgr.BMCRF_Everbridge_Name__c,ebgr.BMCRF_Everbridge_ID__c );
    }
    
    for(BMCServiceDesk__IncidentHistory__c incHistory : Trigger.New)
    {
        if(incHistory.BMCServiceDesk__actionId__c=='Notes')
        {
            Map<string,String> incidentFields_map=new Map<String,String>();
            incidentFields_map.put('BMCServiceDesk__note__c',incHistory.BMCServiceDesk__note__c);
            incidentFields_map.put('Description',incHistory.BMCServiceDesk__note__c);
            BMCServiceDesk__Incident__c inc=[select name,BMCServiceDesk__incidentResolution__c,BMCServiceDesk__incidentDescription__c,BMCServiceDesk__clientId__c,BMCServiceDesk__TemplateName__c,BMCServiceDesk__Status_ID__c,BMCServiceDesk__Client_Account__c,BMCServiceDesk__Priority_ID__c,BMCServiceDesk__Urgency_ID__c,BMCServiceDesk__Impact_Id__c,BMCServiceDesk__Category_ID__c,BMCRF_Queue_Name__c,BMCRF_Override_Contact__c,BMCRF_Override_Group__c,BMCRF_EverBridge_Incident__c,Everbridge_Template_ID__c from BMCServiceDesk__Incident__c where id=: incHistory.BMCServiceDesk__FKIncident__c];
            incidentFields_map.put('EverBridge INCID',inc.BMCRF_EverBridge_Incident__c);
            incidentFields_map.put('Name',inc.name);
         incidentFields_map.put('Incident ID',inc.name);
         incidentFields_map.put('BMCServiceDesk__Category_ID__c',inc.BMCServiceDesk__Category_ID__c);
         incidentFields_map.put('BMCServiceDesk__Queue__c',inc.BMCRF_Queue_Name__c);
         
         incidentFields_map.put('BMCServiceDesk__Impact_Id__c',inc.BMCServiceDesk__Impact_Id__c);
         incidentFields_map.put('BMCServiceDesk__Urgency_ID__c',inc.BMCServiceDesk__Urgency_ID__c);
         incidentFields_map.put('BMCServiceDesk__Priority_ID__c',inc.BMCServiceDesk__Priority_ID__c);
         incidentFields_map.put('BMCServiceDesk__Client_Account__c',inc.BMCServiceDesk__Client_Account__c);
         incidentFields_map.put('BMCServiceDesk__Status_ID__c',inc.BMCServiceDesk__Status_ID__c);
         incidentFields_map.put('BMCServiceDesk__TemplateName__c',inc.BMCServiceDesk__TemplateName__c);
         incidentFields_map.put('BMCServiceDesk__clientId__c',inc.BMCServiceDesk__clientId__c);
         incidentFields_map.put('BMCServiceDesk__incidentDescription__c',inc.BMCServiceDesk__incidentDescription__c);         
         incidentFields_map.put('BMCServiceDesk__incidentResolution__c',inc.BMCServiceDesk__incidentResolution__c);
           
            if(inc.BMCRF_Override_Group__c=='true')
            {
                String QueueName = inc.BMCRF_Queue_Name__c;
                QueueName=QueueName.trim();
                String groupId=groupEBId_Map.get(QueueName);
                groupId=groupId.trim();
                incidentFields_map.put('groupId',groupId);
            }
            else if(inc.BMCRF_Override_Contact__c=='true')
            {
                String contactId=userEBId_Map.get(inc.BMCServiceDesk__FKOpenBy__c).BMCRF_EB_ID__c;
                contactId=contactId.trim();
                incidentFields_map.put('contactId',contactId);
            }
            incidentFields_map.put('EverBridge INCID',inc.BMCRF_EverBridge_Incident__c);
            BMCRF_Parser_EBCreateIncident.createEBIncident('Update',inc.Everbridge_Template_ID__c,incidentFields_map,'Incident');       
        }
    }
}