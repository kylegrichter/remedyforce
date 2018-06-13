public class BMCRF_CNTRL_ConditionsPage
{
    public String templateNameJson;
    List<SelectOption> EBTemplateOptions;
    Map<String,String> EBTemplates;
    public BMCRF_Everbridge_Incident_Conditions__c conditionObj{get;set;}
    public String queryJSON{get;set;}
    public String callfunc{get;set;}
    
    public String selectedObject{get;set;}
    public String selectedEBTemplate{get;set;}
    public String selectedField{get;set;}
    public Map<String, Schema.SObjectField> mfields;
    public Map<String, Schema.SObjectType> mobjects {set;get;}
    public String testStr{get;set;}
    public List<String> impactValues{get;set;}
    public List<String> urgencyValues{get;set;}
    public List<String> categoryValues{get;set;}
    public List<String> statusValues{get;set;}
    public String selectedField1{get;set;}
    public String selectedField2{get;set;}
    BMCRF_HELPER_EBHttpCallout calloutObj;
        
    public BMCRF_CNTRL_ConditionsPage()
    {
        
        EBTemplateCall();
        conditionObj=new BMCRF_Everbridge_Incident_Conditions__c();
        String recordId=apexpages.currentpage().getparameters().get('id');
        System.debug('rec=' + recordId);
        System.debug('cond=' + conditionObj);
       if(recordId!=NULL)
        {
            conditionObj=[select Name,Close_Without_Notification__c,BMCRF_Sort_Order__c,Active__c,Everbridge_Template__c,Name__c,Object_Name__c,Override_Contact__c,Override_Contact_Group__c,Query_JSON__c,Short_Description__c from BMCRF_Everbridge_Incident_Conditions__c where id=:recordId];
            callfunc='<script> parent.changeTabName("'+conditionObj.Name+'"); </script>';
            queryJSON=conditionObj.Query_JSON__c;
            selectedEBTemplate=conditionObj.Everbridge_Template__c;
            selectedObject=conditionObj.Object_Name__c;
        }
        mobjects = Schema.getGlobalDescribe();
        impactValues=new List<String>();
        urgencyValues=new List<String>();
        categoryValues=new List<String>();
        statusValues=new List<String>();
        
       List<BMCServiceDesk__Impact__c> impct=[select id,name from BMCServiceDesk__Impact__c];
       for(BMCServiceDesk__Impact__c imp : impct)
       {
           impactValues.add(imp.name);
       }
       
       List<BMCServiceDesk__Urgency__c> urgncy=[select id,name from BMCServiceDesk__Urgency__c];
       for(BMCServiceDesk__Urgency__c urg : urgncy)
       {
           urgencyValues.add(urg.name);
       }
       
       List<BMCServiceDesk__category__c> category=[select id,name from BMCServiceDesk__category__c];
       for(BMCServiceDesk__category__c cat : category)
       {
           categoryValues.add(cat.name);
       }
       
       List<BMCServiceDesk__status__c> status=[select id,name from BMCServiceDesk__status__c];
       for(BMCServiceDesk__status__c stat : status)
       {
           statusValues.add(stat.name);
       }
       
    }
    public void EBTemplateCall()
    {
        templateNameJson='';
        EBTemplates=new Map<String,String>();
        calloutObj=new BMCRF_HELPER_EBHttpCallout();
        try{
        templateNameJson = calloutObj.call('','GET','incidentTemplates','','');
        }
        catch(Exception e)
        {
        
        }
        EBTemplateOptions=new List<SelectOption>();
        if(templateNameJson != '## HTTP Callout Failed ##' && templateNameJson != '')
        {
            templateNameJson=templateNameJson.replace('page','page1');
            BMCRF_Model_IncidentTemplate parseObj=BMCRF_Model_IncidentTemplate.parse(templateNameJson);
            BMCRF_Model_IncidentTemplate.Page1 EBTemplateList = new BMCRF_Model_IncidentTemplate.Page1();
            EBTemplateList=parseObj.Page1;
            if (EBTemplateList == null || EBTemplateList.Data == null) {
                templateNameJson='No templates defined';
            } else {
                for(BMCRF_Model_IncidentTemplate.Data EBTemplate : EBTemplateList.Data)
                {
                    String templateId =string.valueof(EBTemplate.id);
                    String templateName = EBTemplate.Name;
                    
                    if (templateName == null || templateId == null) {
				        continue;
                    }
                    
                    EBTemplates.put(templateName,templateId);
                    EBTemplateOptions.add(new SelectOption(templateName,templateName));
                }  
            }
        }
        else
        {
            templateNameJson='Not Success..';
        }
    }
    
    public List<SelectOption> getObjects()
    {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('Incident','Incident'));
        options.add(new SelectOption('Change Request','Change Request'));
        return options;
    }
    public List<SelectOption> getEBTemplates()
    {
        List<SelectOption> options = EBTemplateOptions;
        
        return options;
    }
    public List<SelectOption> getIncidentFieldList()
    {
        String objName='bmcservicedesk__incident__c';
        List<SelectOption> options=new List<SelectOption>();
        mfields = mobjects.get(objName).getDescribe().fields.getMap();
        options.add(new SelectOption('-None-','-None-'));
        for(String fieldName : mfields.keySet())
        {
            String opt=mfields.get(fieldName).getDescribe().getLabel();
            String opt1=mfields.get(fieldName).getDescribe().getName();
            if(opt1.contains('Client_Account'))
                options.add(new SelectOption(opt1,'Account'));
            if(opt1.contains('clientId'))
                options.add(new SelectOption(opt1,'Client ID'));
            if(opt1.contains('Category_ID'))     
                options.add(new SelectOption(opt1,'Category'));
            if(opt1.contains('Impact_Id'))
                options.add(new SelectOption(opt1,'Impact'));
            if(opt1.contains('Urgency_ID'))
                options.add(new SelectOption(opt1,'Urgency'));
            if(opt1.contains('Priority_ID'))
                options.add(new SelectOption(opt1,'Priority'));
            if(opt1.contains('Status_ID'))
                options.add(new SelectOption(opt1,'Status'));
            if(opt1.contains('TemplateName') || opt1.contains('incidentDescription') || opt1.contains('incidentResolution'))   
                options.add(new SelectOption(opt1,opt));          
        }
        options.sort();
        return options;
    }
    public List<SelectOption> getChangeRequestFieldList()
    {
        
        String objName='BMCServiceDesk__Change_Request__c';
        List<SelectOption> options=new List<SelectOption>();
        mfields = mobjects.get(objName).getDescribe().fields.getMap();
        options.add(new SelectOption('-None-','-None-'));
        for(String fieldName : mfields.keySet())
        {
            String opt=mfields.get(fieldName).getDescribe().getLabel();
            String opt1=mfields.get(fieldName).getDescribe().getName();
            if(opt1.contains('__Category__c'))     
                options.add(new SelectOption(opt1,'Category'));
            if(opt1.contains('__Impact__c'))
                options.add(new SelectOption(opt1,'Impact'));
            if(opt1.contains('__Urgency__c'))
                options.add(new SelectOption(opt1,'Urgency'));
            if(opt1.contains('__Priority__c'))
                options.add(new SelectOption(opt1,'Priority'));
            if(opt1.contains('__Status__c'))
                options.add(new SelectOption(opt1,'Status'));
            if(opt1.contains('Change_Description')||opt1.contains('Reason_for_Change_Details'))
                options.add(new SelectOption(opt1,opt));
            
        }
        options.sort();
        return options;
    }
    
    public List<String> mappingString=new List<String>();
    public List<SelectOption> getMappedValues()
    {
        if(mappingString==NULL)
            return null;
            
        List<SelectOption> options=new List<SelectOption>();
        for(String str:mappingString)
        {
            options.add(new SelectOption(str,str));
        }
        return options;
    }
    
    public PageReference saveRecord()
    { 
        conditionObj.Query_JSON__c=queryJSON;
        conditionObj.Object_Name__c=selectedObject;
        conditionObj.Everbridge_Template__c=selectedEBTemplate;
        String EBTemplateId= EBTemplates.get(selectedEBTemplate);
        conditionObj.Everbridge_Template_ID__c=EBTemplateId;
        upsert conditionObj;
        PageReference redirect=new PageReference('/apex/BMCRF_VF_ConditionsPage?id='+conditionObj.id);
        redirect.setRedirect(true);
        return redirect;
    }
}