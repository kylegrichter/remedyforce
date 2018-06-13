public class BMCRF_CNTRL_EBDetails {


    List<BMCRF_Incident_Notification__c> incNotification{get;set;}
    List<BMCRF_Everbridge_details__c> EBDetails{get;set;}
    List<BMCRF_Everbridge_Response__c> EBRes{get;set;}
    String result{get;set;}
    String EBid;
    String Incid;
    String Type;
    //BMCRF_EB_Incident_Configuration__c EB_Config;
    
    public BMCRF_CNTRL_EBDetails()
    {
        //EB_Config = [select ID, BMCRF_Everbridge_Webhook_URL__c, BMCRF_Everbridge_Organization_ID__c, BMCRF_Everbridge_Username__c, 
        //                   BMCRF_Everbridge_Password__c, BMCRF_Everbridge_API_URL_Base__c, BMCRF_Everbridge_External_ID_Field__c
        //                      from BMCRF_EB_Incident_Configuration__c limit 1];
                              
        EBid = ApexPages.currentPage().getParameters().get('EBid');
        Incid = ApexPages.currentPage().getParameters().get('Incident_Id');
        Type = ApexPages.currentPage().getParameters().get('Type');
        incNotification=[select BMCRF_Confirmed__c,BMCRF_Confirmed_late__c,BMCRF_Name__c,BMCRF_Sent_On__c,BMCRF_Total__c,BMCRF_Unconfirmed__c from BMCRF_Incident_Notification__c where BMCRF_Everbridge_ID__c =: EBid order by BMCRF_Sent_On__c];
        EBRes=[select BMCRF_Attempt_Number__c,BMCRF_Confirmed__c,BMCRF_Contact__c,BMCRF_Delivery_Method__c,BMCRF_Everbridge_ID__c ,BMCRF_Phase__c from BMCRF_Everbridge_Response__c where BMCRF_Everbridge_ID__c =:EBid ];
        EBDetails=[select BMCRF_Attempt_Number__c,BMCRF_Attempt_Time__c,BMCRF_Call_Result__c,BMCRF_Confirmed_At__c,BMCRF_Confirmed_Delivery__c,BMCRF_Contact__c,BMCRF_Created__c,BMCRF_Deliver_Method__c,BMCRF_Notifications__c from BMCRF_Everbridge_Details__c where BMCRF_Everbridge_ID__c=:EBid order by BMCRF_Attempt_Time__c] ;
        
        
    }
    public List<BMCRF_Incident_Notification__c> getincNotification() {
        return incNotification;
    }
    public List<BMCRF_Everbridge_details__c> getEBDetails() {
        return EBDetails;
    }
    public List<BMCRF_Everbridge_Response__c> getEBRes() {
        return EBRes;
    }
    public pageReference getDeliveryDetails(){
        BMCRF_HELPER_EBGetDeliveryDetails dd=new BMCRF_HELPER_EBGetDeliveryDetails();
       try{
            dd.getDeliveryDetails(EBid,Incid,Type);
        }
        catch (Exception e){}
        return null;
    }
    /*public void getDeliveryDetails(String EBid, String IncId){
    
        //BMCRF_HELPER_EBHttpCallout calloutObj=new BMCRF_HELPER_EBHttpCallout();
        String param2=EBid+'?pageNumber=1';
        String ResponseJSON = call('','GET','incidentNotifications',param2,'');
        
        if(ResponseJSON!='## HTTP Callout Failed ##')
        {
            ResponseJSON = ResponseJSON.replace('"page"','"pageName"');
            ResponseJSON = ResponseJSON.replace('"default"', '"defaultValue"');
            
            BMCRF_IncidentNotificationParser notificationJSON = (BMCRF_IncidentNotificationParser) 
            JSON.deserialize(ResponseJSON, BMCRF_IncidentNotificationParser.class);
            
            BMCRF_IncidentNotificationParser.pageName pageName = notificationJSON.pageName;
            List<BMCRF_IncidentNotificationParser.data> dataList = pageName.data;
            List<BMCRF_IncidentNotificationParser.notificationResult> NotificationResultsList = new List<BMCRF_IncidentNotificationParser.notificationResult>();
            map<BMCRF_IncidentNotificationParser.notificationResult,String> NotifcationNameMap = new map<BMCRF_IncidentNotificationParser.notificationResult,String>();
            map<BMCRF_IncidentNotificationParser.notificationResult,String> NotifcationDateMap = new map<BMCRF_IncidentNotificationParser.notificationResult,String>();
            for(BMCRF_IncidentNotificationParser.data data : dataList)
            {
                NotificationResultsList.add(data.notificationResult);
                NotifcationNameMap.put(data.notificationResult,data.notificationName);
                NotifcationDateMap.put(data.notificationResult, String.valueOf(data.createdDate));
            } 
            List<BMCRF_Incident_Notification__c> upsertList = new List<BMCRF_Incident_Notification__c>();
            List<String> NotificationIds = new List<String>();
            for(BMCRF_IncidentNotificationParser.notificationResult notificationResult: NotificationResultsList)
            {
                BMCRF_Incident_Notification__c incNotif = new BMCRF_Incident_Notification__c();
                
                try{
                incNotif.BMCRF_Confirmed__c = notificationResult.confirmedCount;
                incNotif.BMCRF_Confirmed_late__c = notificationResult.confirmedLateCount;
                incNotif.BMCRF_Unconfirmed__c = notificationResult.notConfirmedCount;
                incNotif.BMCRF_Notification_ID__c = String.valueOf(notificationResult.notificationId);
                incNotif.BMCRF_Total__c = notificationResult.totalCount;
                NotificationIds.add(String.valueOf(notificationResult.notificationId));
                }
                catch(Exception e)
                {
                
                }
                incNotif.BMCRF_Everbridge_ID__c = EBid ;
                incNotif.BMCRF_Name__c = NotifcationNameMap.get(notificationResult);
                incNotif.BMCRF_Incident_ID__c = IncId;
                //incNotif.BMCRF_Notification_ID__c = String.valueOf(notificationResult.notificationId);
                //incNotif.BMCRF_Total__c = notificationResult.totalCount;
                String createdDate = NotifcationDateMap.get(notificationResult);
                long longDate = long.valueOf(createdDate);
                String CreatedDateTime =  datetime.newInstance(longDate).format('dd/MM/YYYY hh:mm:ss a');
                incNotif.BMCRF_Sent_On__c = CreatedDateTime;
                //NotificationIds.add(String.valueOf(notificationResult.notificationId));
                try{
                upsertList.add(incNotif);
                }catch(Exception e)
                {
                
                }
                
            
            }
        
            getNotificationDetails(NotificationIds,IncId,EBId);
            try{
            upsert upsertList BMCRF_Notification_ID__c;}catch(Exception e){}
        }
    }
    Public void getNotificationDetails(List<String> NotificationIds,String IncId,String EBid){
        List<BMCRF_Everbridge_Details__c> upsertList = new List<BMCRF_Everbridge_Details__c>();
        List<BMCRF_Everbridge_Response__c> EBResponsesList = new List<BMCRF_Everbridge_Response__c>();
        Set<String> DeleteDetailSet = new Set<String>();
        Set<String> DeleteResponsesSet = new Set<String>();
        
        List<BMCRF_NotificationDetailsParser> NotificationList = new List<BMCRF_NotificationDetailsParser>();
        String ResponseJSON;
        For(String NotificationId : NotificationIds)
        {
            BMCRF_HELPER_EBHttpCallout calloutObj=new BMCRF_HELPER_EBHttpCallout();
            String param2=NotificationId+'?verbose=true';
            ResponseJSON=call('','GET','notifications',param2,'');
            ResponseJSON = ResponseJSON.replace('"default"', '"defaultValue"');
            BMCRF_NotificationDetailsParser JSONparser = (BMCRF_NotificationDetailsParser) 
                JSON.deserialize(ResponseJSON,BMCRF_NotificationDetailsParser.class); 
            NotificationList.add(JSONparser);
        }
        for(BMCRF_NotificationDetailsParser NotificationUpdates :NotificationList)
        {
            
            BMCRF_NotificationDetailsParser.result result = NotificationUpdates.result;
            List<BMCRF_NotificationDetailsParser.allDetails>  allDetailsList=new List<BMCRF_NotificationDetailsParser.allDetails>();
            long longDateCreated;
            String Notifications;
            String phase;
            BMCRF_NotificationDetailsParser.notificationResult notificationResult;
            BMCRF_NotificationDetailsParser.incidentPhase incidentPhase;
            BMCRF_NotificationDetailsParser.phaseTemplate phaseTemplate;
            try{
            longDateCreated = long.valueOf(String.valueOf(result.createdDate));
            notificationResult = result.notificationResult;
            incidentPhase = result.incidentPhase;
            phaseTemplate = incidentPhase.phaseTemplate;
            phase = phaseTemplate.name;
            Notifications = String.valueOf(notificationResult.confirmedCount);
            allDetailsList = notificationResult.allDetails;
            }
            catch(Exception e)
            {
            
            }
            
            if(!allDetailsList.isEmpty())
            {
                for(BMCRF_NotificationDetailsParser.allDetails allDetails:allDetailsList)
                {
                    BMCRF_Everbridge_Details__c EBdetails = new BMCRF_Everbridge_Details__c(); 
                    EBdetails.BMCRF_Attempt_Number__c = allDetails.attempt;
                    String attemptTime = String.valueOf(allDetails.attemptTime);
                    long longAttemptDate;
                    if(String.isNotEmpty(attemptTime))
                    {
                        longAttemptDate = long.valueOf(String.valueOf(allDetails.attemptTime));
                    }
                    String AttemptDateTime = '';
                    if(longAttemptDate!=null)
                    {
                        AttemptDateTime =  datetime.newInstance(longAttemptDate).format('dd/MM/YYYY hh:mm:ss a');
                    }
                    EBdetails.BMCRF_Attempt_Time__c = AttemptDateTime;
                    List<BMCRF_NotificationDetailsParser.callResultByPaths> callResultByPathsList = allDetails.callResultByPaths;
                    String callResult='';
                    For(BMCRF_NotificationDetailsParser.callResultByPaths callResultByPaths:callResultByPathsList)
                    {
                        callResult = callResult + callResultByPaths.callResult;
                    }
                    EBdetails.BMCRF_Call_Result__c =  callResult;
                    String confirmDate = String.valueOf(allDetails.confirmedDate);
                    long longDateConfirm ;
                    if(String.isNotEmpty(confirmDate))
                    {
                        longDateConfirm = long.valueOf(String.valueOf(allDetails.confirmedDate));
                    }
                    String ConfirmDateTime = '';
                    if(longDateConfirm!=null)
                    {
                        ConfirmDateTime =  datetime.newInstance(longDateConfirm).format('dd/MM/YYYY hh:mm:ss a'); 
                    }
                    EBdetails.BMCRF_Confirmed_At__c =  ConfirmDateTime;
                    EBdetails.BMCRF_Confirmed_Delivery__c =  allDetails.confirmed;
                    EBdetails.BMCRF_Contact__c =  allDetails.fullName;     
                    String CreatedDateTime =  datetime.newInstance(longDateCreated).format('dd/MM/YYYY hh:mm:ss a');
                    EBdetails.BMCRF_Created__c = CreatedDateTime;
                    EBdetails.BMCRF_Deliver_Method__c =  allDetails.confirmedPath; 
                    EBdetails.BMCRF_Everbridge_ID__c = EBid;
                    EBdetails.BMCRF_Incident_ID__c =  IncId;
                    EBdetails.BMCRF_NotificationDetailsID__c = String.valueOf(allDetails.notificationId);
                    EBdetails.BMCRF_Notifications__c  =Notifications;
                    DeleteDetailSet.add(String.valueOf(allDetails.notificationId));
                    upsertList.add(EBdetails);
                    
                    if(allDetails.confirmed)
                    {
                   
                        BMCRF_Everbridge_Response__c EBResponses = new BMCRF_Everbridge_Response__c();
                        EBResponses.BMCRF_Attempt_Number__c = allDetails.attempt;                    
                        long confirmDatelong = long.valueOf(String.valueOf(allDetails.confirmedDate));
                        String confirmedDate = DateTime.newInstance(confirmDatelong).format('dd/MM/YYYY hh:mm:ss a'); 
                        EBResponses.BMCRF_Confirmed__c = confirmedDate;
                        EBResponses.BMCRF_Contact__c = allDetails.fullName;
                        EBResponses.BMCRF_Delivery_Method__c = allDetails.confirmedPath;
                        EBResponses.BMCRF_Everbridge_ID__c = EBid ;
                        EBResponses.BMCRF_Incident__c = IncId;
                        EBResponses.BMCRF_Incident_ID__c = IncId; 
                        EBResponses.BMCRF_Phase__c = phase;
                        EBResponses.BMCRF_Attempt_Time__c = DateTime.newInstance(Long.valueOf(String.valueOf(allDetails.attemptTime)));
                        EBResponses.BMCRF_EB_Response_ID__c = String.valueOf(allDetails.notificationId);
                        DeleteResponsesSet.add(String.valueOf(allDetails.notificationId));
                        
                        EBResponsesList.add(EBResponses);      
                    }
                }
            }
            
            
        }
        List<BMCRF_Everbridge_Details__c> DeleteDetailsList = [Select id from BMCRF_Everbridge_Details__c 
                                                        where BMCRF_NotificationDetailsID__c IN:DeleteDetailSet];
        List<BMCRF_Everbridge_Response__c> DeleteResponsesList = [Select id from BMCRF_Everbridge_Response__c
                                                                 where BMCRF_EB_Response_ID__c IN:DeleteResponsesSet];
        if(!DeleteDetailsList.isEmpty()){
            delete DeleteDetailsList;
        }
        if(!DeleteResponsesList.isEmpty()){
            delete DeleteResponsesList;
        }
        if(!EBResponsesList.isEmpty())
        {
            insert EBResponsesList ;
        }
        if(!upsertList.isEmpty())
        {
          insert upsertList ;
        }
    }
    public String call(String body,String method, String param1,String param2,String param3)
    {
        String JSONString='## HTTP Callout Failed ##';
        String baseuri = EB_Config.BMCRF_Everbridge_API_URL_Base__c;
        String uname_Password = EB_Config.BMCRF_Everbridge_Username__c + ':' + EB_Config.BMCRF_Everbridge_Password__c ;
        Blob toBlob = Blob.valueOf(uname_Password);
        String credentials = 'Basic '+ EncodingUtil.base64Encode(toBlob);
        String OraganizationId = EB_Config.BMCRF_Everbridge_Organization_ID__c;
        
        HttpRequest req = new HttpRequest();
        //set base url based on the parameter passed
        if(String.isEmpty(param2) && String.isEmpty(param3))
            req.setEndpoint(baseuri+'/'+param1+'/'+OraganizationId+'/');    
        else if(String.isEmpty(param3))
            req.setEndpoint(baseuri+'/'+param1+'/'+OraganizationId+'/'+param2);    
        else
            req.setEndpoint(baseuri+'/'+param1+'/'+OraganizationId+'/'+param2+'/'+param3);    
            
        req.setMethod(method);

        if(method=='POST' || method=='PUT')
            req.setBody(body);
            
        req.setHeader('Content-Type', 'application/json');
        req.setHeader('Authorization', credentials);
        req.setHeader('organizationId', OraganizationId);
        req.setTimeout(20000);
        Http h = new Http();
        HttpResponse res = new HttpResponse();
        
        try{
            res = h.send(req);
        }
        catch(Exception e)
        {
            system.debug('## Callout Exception ##'+ res+' excp: '+e );
        }
        if(res.getStatusCode() == 200)
            JSONString=res.getBody();
        else{
            JSONString='## HTTP Callout Failed ##';
            system.debug(JSONString+ res.getBody());
        }
            
        return JSONString;
    } */
   
}