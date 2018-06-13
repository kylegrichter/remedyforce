trigger BMCRF_ChangeHistory on BMCServiceDesk__Change_History__c (after insert) {

    Map<ID,User> userEBId_Map=new Map<ID,User>([Select id,BMCRF_EB_ID__c from User]);
    List<BMCRF_Everbridge_Group_Details__c> ebgrdetails=new List<BMCRF_Everbridge_Group_Details__c>([select BMCRF_Everbridge_Name__c,BMCRF_Everbridge_ID__c from BMCRF_Everbridge_Group_Details__c]);
     Map<String,String> groupEBId_Map = new Map<String,String>();
     for(BMCRF_Everbridge_Group_Details__c ebgr : ebgrdetails)
     {
         groupEBId_Map.put(ebgr.BMCRF_Everbridge_Name__c,ebgr.BMCRF_Everbridge_ID__c );
     }

    for(BMCServiceDesk__Change_History__c crHistory : Trigger.New)
    {
        if(crHistory.BMCServiceDesk__Action__c=='Notes')
        {
            Map<string,String> changeRequestFields_map=new Map<String,String>();
            changeRequestFields_map.put('BMCServiceDesk__note__c',crHistory.BMCServiceDesk__note__c);
            changeRequestFields_map.put('Description',crHistory.BMCServiceDesk__note__c);
            BMCServiceDesk__Change_Request__c cr=[select Name,BMCServiceDesk__Change_Description__c,BMCServiceDesk__Reason_for_Change_Details__c,BMCServiceDesk__Category__c,BMCServiceDesk__Priority__c,BMCServiceDesk__Status__c,BMCServiceDesk__Urgency__c,BMCServiceDesk__Impact__c,BMCRF_Override_Contact__c,BMCRF_Override_Group__c,BMCRF_Queue_Name__c,BMCRF_Everbridge_ID__c,BMCRF_Everbridge_Template_ID_c__c from BMCServiceDesk__Change_Request__c where id=: crHistory.BMCServiceDesk__FKChange__c];
            changeRequestFields_map.put('Name',cr.Name);
            changeRequestFields_map.put('BMCServiceDesk__Queue__c',cr.BMCRF_Queue_Name__c);
            changeRequestFields_map.put('BMCServiceDesk__Impact__c',cr.BMCServiceDesk__Impact__c);
            changeRequestFields_map.put('BMCServiceDesk__Urgency__c',cr.BMCServiceDesk__Urgency__c);
            changeRequestFields_map.put('BMCServiceDesk__Status_ID__c',cr.BMCServiceDesk__Status__c);   
            changeRequestFields_map.put('BMCServiceDesk__Priority__c',cr.BMCServiceDesk__Priority__c);
            changeRequestFields_map.put('BMCServiceDesk__Category__c',cr.BMCServiceDesk__Category__c);
            changeRequestFields_map.put('BMCServiceDesk__Change_Description__c',cr.BMCServiceDesk__Change_Description__c);
            changeRequestFields_map.put('BMCServiceDesk__Reason_for_Change_Details__c',cr.BMCServiceDesk__Reason_for_Change_Details__c);
            if(cr.BMCRF_Override_Group__c=='true')
                 {
                     String QueueName = cr.BMCRF_Queue_Name__c;
                     QueueName=QueueName.trim();
                     String groupId=groupEBId_Map.get(QueueName);
                     groupId=groupId.trim();
                     changeRequestFields_map.put('groupId',groupId);
                 }
                 else if(cr.BMCRF_Override_Contact__c=='true')
                 {
                     String contactId=userEBId_Map.get(cr.BMCServiceDesk__FKStaff__c).BMCRF_EB_ID__c;
                     contactId=contactId.trim();
                     changeRequestFields_map.put('contactId',contactId);
                 }
            
            changeRequestFields_map.put('EverBridge INCID',cr.BMCRF_Everbridge_ID__c);
            BMCRF_Parser_EBCreateIncident.createEBIncident('Update',cr.BMCRF_Everbridge_Template_ID_c__c ,changeRequestFields_map,'Change Request');       
        }
    }


}