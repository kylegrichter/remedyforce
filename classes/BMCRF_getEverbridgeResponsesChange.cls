Public Class BMCRF_getEverbridgeResponsesChange {
    Public void getIncidentNotification(List<BMCServiceDesk__Change_Request__c> IncList){
    
        BMCRF_EB_Incident_Configuration__c EB_Config;
        EB_Config = [select ID, BMCRF_Everbridge_Webhook_URL__c, BMCRF_Everbridge_Organization_ID__c, BMCRF_Everbridge_Username__c, 
                           BMCRF_Everbridge_Password__c, BMCRF_Everbridge_API_URL_Base__c, BMCRF_Everbridge_External_ID_Field__c
                              from BMCRF_EB_Incident_Configuration__c limit 1];
    
        List<String> NotificationIds = new List<String>();
        
        //BMCServiceDesk__RemedyforceSettings__c baseuriSetting = BMCServiceDesk__RemedyforceSettings__c.getValues('baseuri');
        //BMCServiceDesk__RemedyforceSettings__c credentialsSetting = BMCServiceDesk__RemedyforceSettings__c.getValues('credentials');
        //BMCServiceDesk__RemedyforceSettings__c OrganizationIdSetting = BMCServiceDesk__RemedyforceSettings__c.getValues('OrganizationId');
        //String baseuri = baseuriSetting.BMCServiceDesk__value__c;
        //String credentials = credentialsSetting.BMCServiceDesk__value__c;
        //String OraganizationId = OrganizationIdSetting.BMCServiceDesk__value__c;
        
        String baseuri = EB_Config.BMCRF_Everbridge_API_URL_Base__c;
        String uname_Password = EB_Config.BMCRF_Everbridge_Username__c + ':' + EB_Config.BMCRF_Everbridge_Password__c ;
        Blob toBlob = Blob.valueOf(uname_Password);
        String credentials =  EncodingUtil.base64Encode(toBlob);
        
        String OraganizationId = EB_Config.BMCRF_Everbridge_Organization_ID__c;
        List<BMCRF_IncidentNotificationParser> notificationJSONList = new List<BMCRF_IncidentNotificationParser> (); 
        map<BMCRF_IncidentNotificationParser,String> NotificationEBIncMap = new map<BMCRF_IncidentNotificationParser,String>(); 
        List<String> EBIncidentIds = new List<String>();

        For(BMCServiceDesk__Change_Request__c inc: IncList){
            Http h = new Http();
            HttpRequest req = new HttpRequest();
            req.setEndpoint(baseuri+'/incidentNotifications/'+OraganizationId+'/'+inc.BMCRF_Everbridge_ID__c+'/');    
            req.setMethod('GET');
            req.setHeader('Content-Type', 'application/json');
            req.setHeader('Authorization', 'Basic '+credentials);
            req.setHeader('organizationId', OraganizationId);
            req.setHeader('incidentId',inc.BMCRF_Everbridge_ID__c);
            req.setHeader('pageNumber', '1');
            HttpResponse res;
            res = h.send(req);  
            String ResponseJSON = res.getBody();
            system.debug('Saurabh Actual JSON '+ResponseJSON);
            system.debug('umi EBNo '+inc.BMCRF_Everbridge_ID__c);
            ResponseJSON = ResponseJSON.replace('"page"','"pageName"');
            ResponseJSON = ResponseJSON.replace('"default"', '"defaultValue"');
            EBIncidentIds.add(inc.BMCRF_Everbridge_ID__c);
            BMCRF_IncidentNotificationParser notificationJSON = (BMCRF_IncidentNotificationParser) 
                JSON.deserialize(ResponseJSON, BMCRF_IncidentNotificationParser.class);
           
            notificationJSONList.add(notificationJSON);
            NotificationEBIncMap.put(notificationJSON, inc.BMCRF_Everbridge_ID__c);
            
        }
        map<String,String> NotificationIdEBIncIDmap = new  map<String,String>();
        for(BMCRF_IncidentNotificationParser notificationJSON : notificationJSONList)
        {
            
            BMCRF_IncidentNotificationParser.pageName pageName = notificationJSON.pageName;
            
            List<BMCRF_IncidentNotificationParser.data> dataList = pageName.data;
            
            List<BMCRF_IncidentNotificationParser.notificationResult> NotificationResultsList = new List<BMCRF_IncidentNotificationParser.notificationResult>();
            for(BMCRF_IncidentNotificationParser.data data : dataList)
            {
                NotificationResultsList.add(data.notificationResult);
            } 
            List<BMCRF_Incident_Notification__c> upsertList = new List<BMCRF_Incident_Notification__c>();
            
            
            for(BMCRF_IncidentNotificationParser.notificationResult notificationResult: NotificationResultsList)
            {
                if(notificationResult.confirmedCount!=0 ){
                    NotificationIds.add(String.valueOf(notificationResult.notificationId));
                    NotificationIdEBIncIDmap.put(String.valueOf(notificationResult.notificationId),NotificationEBIncMap.get(notificationJSON));
                    
                }
            }
        }
        BMCRF_getEverbridgeResponsesChange EBRes = new BMCRF_getEverbridgeResponsesChange();
        system.debug('Saurabh EBIncidentIds '+EBIncidentIds);
        try{
            if(!NotificationIds.isEmpty()){
                EBRes.getNotificationDetails(NotificationIds,NotificationIdEBIncIDmap,EBIncidentIds);
            }
        }
        catch(Exception e){}
    }
    Public void getNotificationDetails(List<String> NotificationIds, map<String,String> NotificationIdEBIncIDmap,List<String> EBIncIDList){
          system.debug('umi getNotification called ');
        List<BMCRF_Everbridge_Response__c> EBResponsesList = new List<BMCRF_Everbridge_Response__c>();
        map<String,String> EBIncFirstUsermap = new map<String,String>(); 
        Set<String> Staffusers = new Set<String>();
        Set<String> DeleteSet = new Set<String>();
        BMCRF_EB_Incident_Configuration__c EB_Config;
        EB_Config = [select ID, BMCRF_Everbridge_Webhook_URL__c, BMCRF_Everbridge_Organization_ID__c, BMCRF_Everbridge_Username__c, 
                           BMCRF_Everbridge_Password__c, BMCRF_Everbridge_API_URL_Base__c, BMCRF_Everbridge_External_ID_Field__c
                              from BMCRF_EB_Incident_Configuration__c limit 1];
    
        String baseuri = EB_Config.BMCRF_Everbridge_API_URL_Base__c;
        String uname_Password = EB_Config.BMCRF_Everbridge_Username__c + ':' + EB_Config.BMCRF_Everbridge_Password__c ;
        Blob toBlob = Blob.valueOf(uname_Password);
        String credentials =  EncodingUtil.base64Encode(toBlob);
        
        String OraganizationId = EB_Config.BMCRF_Everbridge_Organization_ID__c;
        List<BMCRF_NotificationDetailsParser> NotificationList = new List<BMCRF_NotificationDetailsParser>();
        String ResponseJSON;
        For(String NotificationId : NotificationIds){
            if(NotificationId!=null){
                //Http h = new Http();
                HttpRequest req = new HttpRequest();
                req.setEndpoint(baseuri+'/notifications/'+OraganizationId+'/'+NotificationId+'?verbose=true');    
                req.setMethod('GET');
                req.setHeader('Content-Type', 'application/json');
                req.setHeader('Authorization', 'Basic '+credentials);
                req.setHeader('organizationId', OraganizationId);
                req.setHeader('notificationId',NotificationId);
                req.setHeader('pageNumber', '1');
                HttpResponse res = new Http().send(req);        
                ResponseJSON = res.getBody();
                ResponseJSON = ResponseJSON.replace('"default"', '"defaultValue"');
                BMCRF_NotificationDetailsParser JSONparser = (BMCRF_NotificationDetailsParser) 
                    JSON.deserialize(ResponseJSON,BMCRF_NotificationDetailsParser.class); 
                NotificationList.add(JSONparser);
            }
        }
        system.debug('Saurabh NotificationIds '+NotificationIds);
        system.debug('saurabh NotificationList Size '+NotificationList.size());
        if(!NotificationList.isEmpty())
        {
            BMCRF_NotificationDetailsParser.phaseTemplate phaseTemplate;
            BMCRF_NotificationDetailsParser.notificationResult notificationResult;
            BMCRF_NotificationDetailsParser.incidentPhase incidentPhase;
            String phase;
            for(BMCRF_NotificationDetailsParser NotificationUpdates :NotificationList)
            {
                
                BMCRF_NotificationDetailsParser.result result = NotificationUpdates.result;
                long longDateCreated = long.valueOf(String.valueOf(result.createdDate));
                notificationResult = result.notificationResult;
                incidentPhase = result.incidentPhase;
                try{
                    phaseTemplate = incidentPhase.phaseTemplate;
                    phase = phaseTemplate.name;
                }
                catch(Exception e)
                {}
                
                //String ConfirmedCount = String.valueOf(notificationResult.confirmedCount);
                
                List<BMCRF_NotificationDetailsParser.allDetails>  allDetailsList = notificationResult.allDetails;
                if(!allDetailsList.isEmpty()){
                for(BMCRF_NotificationDetailsParser.allDetails allDetails:allDetailsList){
                    if(allDetails.confirmed){
                    BMCRF_Everbridge_Response__c EBResponses = new BMCRF_Everbridge_Response__c();
                    EBResponses.BMCRF_Attempt_Number__c = allDetails.attempt;
                    long confirmDatelong = long.valueOf(String.valueOf(allDetails.confirmedDate));
                    String confirmedDate = DateTime.newInstance(confirmDatelong).format('dd/MM/YYYY hh:mm:ss a'); 
                    EBResponses.BMCRF_Confirmed__c = confirmedDate;
                    EBResponses.BMCRF_Contact__c = allDetails.fullName;
                    EBResponses.BMCRF_Delivery_Method__c = allDetails.confirmedPath;
                    EBResponses.BMCRF_Everbridge_ID__c =  NotificationIdEBIncIDmap.get(String.valueOf(allDetails.NotificationId));
                    EBResponses.BMCRF_Incident__c = NotificationIdEBIncIDmap.get(String.valueOf(allDetails.NotificationId));
                    EBResponses.BMCRF_Phase__c = phase;
                    EBResponses.BMCRF_Attempt_Time__c = DateTime.newInstance(Long.valueOf(String.valueOf(allDetails.attemptTime)));
                    EBResponses.BMCRF_EB_Response_ID__c = String.valueOf(allDetails.NotificationId);
                    EBResponsesList.add(EBResponses);
                    DeleteSet.add(String.valueOf(allDetails.NotificationId));
                    }
                   
                }
                }
                DateTime firstReponse ;
                String EBIncId; 
                String FullName;
                if(!EBResponsesList.isEmpty()){
                For(BMCRF_Everbridge_Response__c EBResponse :EBResponsesList){
                    if(EBResponse.BMCRF_Attempt_Time__c!=null){
                        if(firstReponse==null || EBResponse.BMCRF_Attempt_Time__c<firstReponse) {
                            firstReponse = EBResponse.BMCRF_Attempt_Time__c;
                            EBIncId = EBResponse.BMCRF_Everbridge_ID__c;
                            FullName = EBResponse.BMCRF_Contact__c;  
                        }
                    }
                }
                }
               
                EBIncFirstUsermap.put(EBIncId, FullName);
                Staffusers.add(FullName);
                
            }
        }
        List<BMCServiceDesk__Change_Request__c> updateIncList = [Select id,name,BMCRF_Everbridge_ID__c,BMCServiceDesk__FKStaff__c
                                                           FROM BMCServiceDesk__Change_Request__c where BMCRF_Everbridge_ID__c IN:EBIncIDList]; 
        List<User> StaffUserList = [Select id,Name FROM User where name IN:Staffusers];
        map<String,String> NameIdMap = new map<String,String>();
        for(User u :StaffUserList){
            NameIdMap.put(u.name,u.id);
        }
        system.debug('umi Nameidmap  '+NameIdMap);
        List<BMCServiceDesk__Change_Request__c> updateList = new List<BMCServiceDesk__Change_Request__c>();
        for(BMCServiceDesk__Change_Request__c updateInc: updateIncList){
            String UserFullName = EBIncFirstUsermap.get(updateInc.BMCRF_Everbridge_ID__c);
            if(String.isNotEmpty(UserFullName)){
                updateInc.BMCServiceDesk__FKStaff__c = NameIdMap.get(UserFullName);
                updateInc.BMCRF_Assigned_by_EB__c = true;
                updateList.add(updateInc);
            }
        }
        system.debug('umi update list :'+updateList);
        
        if(!updateList.isEmpty()){
            update updateList;
            system.debug('umi update list1 :'+updateList);
        }
        List<BMCRF_Everbridge_Response__c> deleteList = [Select id FROm BMCRF_Everbridge_Response__c where 
                                                        BMCRF_EB_Response_ID__c IN: DeleteSet];
        if(!deleteList.isEmpty()){
            delete deleteList;
        }
        if(!EBResponsesList.isEmpty()){
           insert EBResponsesList ;
        }
    }
}