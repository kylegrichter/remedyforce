public class BMCRF_Parser_EBCreateIncident
{
    @future(callout=true)
    public static void createEBIncident(String action,String EBTemplateId,Map<String,String> rfObjectFields_map,String rfObject)
    {
       
        System.debug('TEST');
        BMCRF_EB_Incident_Configuration__c EB_Config;
        EB_Config = [select ID, BMCRF_Everbridge_Webhook_URL__c, BMCRF_Everbridge_Organization_ID__c, BMCRF_Everbridge_Username__c, 
                           BMCRF_Everbridge_Password__c, BMCRF_Everbridge_API_URL_Base__c, BMCRF_Everbridge_External_ID_Field__c
                              from BMCRF_EB_Incident_Configuration__c limit 1];
                              
        String baseuri = EB_Config.BMCRF_Everbridge_API_URL_Base__c;
        String uname_Password = EB_Config.BMCRF_Everbridge_Username__c + ':' + EB_Config.BMCRF_Everbridge_Password__c ;
        Blob toBlob = Blob.valueOf(uname_Password);
        String credentials = 'Basic '+ EncodingUtil.base64Encode(toBlob);
        String OraganizationId = EB_Config.BMCRF_Everbridge_Organization_ID__c;
        HttpRequest req = new HttpRequest();
        
               
        Set<String> incidentFieldNames_set=rfObjectFields_map.KeySet();
        //EBTemplateId='444206992589693';
        BMCRF_HELPER_EBHttpCallout calloutObj=new BMCRF_HELPER_EBHttpCallout();
        String incidentvariables;//= calloutObj.call('','GET','incidentVariableItems',EBTemplateId,'New');
        
        if (EBTemplateId != '-1') {
            req.setEndpoint(baseuri+'/incidentVariableItems/'+OraganizationId+'/'+EBTemplateId+'/New');   
            req.setMethod('GET'); 
            req.setHeader('Content-Type', 'application/json');
            req.setHeader('Authorization', credentials);
            req.setHeader('organizationId', OraganizationId);
            Http h = new Http();
            HttpResponse res = new HttpResponse();
            try{
            res = h.send(req);
            }
            catch(Exception e)
            {
            }
            incidentvariables=res.getBody();
        } else {
           incidentvariables = '';
        }
        
        String JSONString='';  
        String incidentName;
        
        if(rfObject=='Incident')
            incidentName='INC'+rfObjectFields_map.get('Name');
        else if(rfObject=='Change Request')
            incidentName='CR'+rfObjectFields_map.get('Name');     
               
        String incidentAction=action;
        Long templateID;
        try{
            templateID=Long.valueOf(EBTemplateId);
        }
        catch(Exception e)
        {
        }
        Integer phaseDefinitionId;
        
        if(action=='Launch')
            phaseDefinitionId=1001;
        else if(action=='Update')
            phaseDefinitionId=1002;
            
        Long contactId=NULL;
        Long groupId=NULL;
        if(rfObjectFields_map.containsKey('groupId'))
        {
            groupId=Long.valueOf(rfObjectFields_map.get('groupId'));
        }
        else if(rfObjectFields_map.containsKey('contactId'))
        {
            contactId=Long.valueOf(rfObjectFields_map.get('contactId'));
        }
        
        JSONString='{"name": "'+escapeJSON(incidentName)+'",';
        JSONString += '"incidentAction":"'+ incidentAction+'",';
        JSONString += '"incidentPhases": [{"phaseTemplate": {"templateId": '+ templateID +',';
        JSONString += '"phaseDefinitions": [{"id": '+phaseDefinitionId+'}],';
        JSONString +='"formTemplate": {"formVariableItems": [';
        
        if(incidentvariables != '## HTTP Callout Failed ##')
        {
            incidentvariables=incidentvariables.replace('page','page1');
            integer i;
            BMCRF_Model_IncidentVariableItems parseObj;
            BMCRF_Model_IncidentVariableItems.Page1 itemVariableList;
            try{
                parseObj=BMCRF_Model_IncidentVariableItems.parse(incidentvariables);
                itemVariableList = new BMCRF_Model_IncidentVariableItems.Page1();
                itemVariableList=parseObj.Page1;
                i=itemVariableList.Data.size();
            }
            catch(Exception e)
            {
            
            }
            if(itemVariableList!=NULL)
            {
                for(BMCRF_Model_IncidentVariableItems.Data itemVariable : itemVariableList.Data)
                {
                    i--;
                    String variableId =string.valueof(itemVariable.id);
                    String variableName = itemVariable.Name;
                    String value;
                    for(string fldName : incidentFieldNames_set)
                    {
                        if(fldName.containsIgnoreCase(variableName))
                        {
                            value=rfObjectFields_map.get(fldName);
                            break;
                        }
                        
                    }
                
                    if(i==0)
                        JSONString += '{"variableName": "'+ escapeJSON(variableName)+'","val": ["'+escapeJSON(value)+'"],"variableId": '+variableId+'}';
                    else
                        JSONString += '{"variableName": "'+escapeJSON(variableName)+'","val": ["'+escapeJSON(value)+'"],"variableId": '+variableId+'},';
                }
            }
        }
       
        //JSONString += ']},"broadcastTemplate": {"broadcastContacts": {"contactIds": ['+contactId+'],"groupIds": ['+groupId+']}}}}]}';
        
        JSONString += ']}';

        if(contactId != null || groupId != null ) {

            JSONString += ',"broadcastTemplate": {"broadcastContacts": {';

               if (contactId != null) {
                   JSONString +='"contactIds": ['+contactId+']';
               }

             if (groupId != null) {
                 if (contactId != null) { JSONString += ','; }

                   JSONString +=  '"groupIds": ['+groupId+']';

               }

            JSONString += '}}';

        }

        JSONString += '}}]}';
         BMCRF_EBResponse responseObj;
        System.debug('!!! JSONString=' + JSONString);
        String response = null;
        if (EBTemplateId != '-1') {
          if(action.contains('Close')) {
                   response = calloutObj.call(JSONString,'PUT','incidents',rfObjectFields_map.get('BMCRF_EverBridge_Incident__c'),'');
            } else {
                   response = calloutObj.call(JSONString,'POST','incidents','','');             
            }
        } else {
           responseObj = new BMCRF_EBResponse();
           responseObj.id = 'Test';
        }
           
        System.debug(response);                               
      
       
        try{
           responseObj=BMCRF_EBResponse.parse(response);     
        }
        catch(Exception e)  {
            
        }
        
        if(rfObject=='Incident' && action=='Launch')
        {
            BMCServiceDesk__Incident__c inc=[select BMCRF_EverBridge_Incident__c,BMCRF_EB_Ticket_Link__c from BMCServiceDesk__Incident__c where id =: rfObjectFields_map.get('Id')];
            if(responseObj!=NULL)
            {
            inc.BMCRF_EB_Ticket_Link__c='https://manager.everbridge.net/incidents/incident/'+responseObj.id+'/notifications/';
            inc.BMCRF_EverBridge_Incident__c=responseObj.id;
            }
            inc.Everbridge_Template_ID__c=EBTemplateId;
            update inc;
        }
        else if(rfObject=='Change Request' && action=='Launch')
        {
            BMCServiceDesk__Change_Request__c cr=[select BMCRF_Everbridge_Template_ID_c__c,BMCRF_Everbridge_Link__c,BMCRF_Everbridge_ID__c from BMCServiceDesk__Change_Request__c where id =: rfObjectFields_map.get('Id')];
            if(responseObj!=NULL)
            {
                cr.BMCRF_Everbridge_Link__c='https://manager.everbridge.net/incidents/incident/'+responseObj.id+'/notifications/';
                cr.BMCRF_Everbridge_ID__c=responseObj.id;
            }
            cr.BMCRF_Everbridge_Template_ID_c__c=EBTemplateId;
            update cr;
        }
        
    }
    
    public static String escapeJSON(String value) {
        
        if (value != null) {
            value = value.replace('\\','\\\\"');
            value = value.replace('"','\\"');
            value = value.replace('/','\\/');
            // EB fields won't support formatting control characters; stripped:
            value = value.replace('\b','');
            value = value.replace('\f','');
            value = value.replace('\n','');
            value = value.replace('\r','');
            value = value.replace('\t','');
        }
        
        return value;
    }
}