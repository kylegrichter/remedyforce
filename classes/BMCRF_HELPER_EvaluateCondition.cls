public class BMCRF_HELPER_EvaluateCondition
{
    
    public Map<String,String> map_IncidentValues;
    BMCRF_Model_Condition conditionParser;
    List<BMCRF_Model_Condition.expressions> expressionsList;
    List<BMCRF_Model_Condition.logicals> logicalsList;
    Boolean boolAND;
    Boolean boolOR;
    public String JSONString;
    List<BMCRF_Everbridge_Incident_Conditions__c> EBCondition;
    integer maxSortOrder;
    
    
    public BMCRF_HELPER_EvaluateCondition(String objectName)
    {
        BMCRF_Everbridge_Incident_Conditions__c con =[select BMCRF_Sort_Order__c from BMCRF_Everbridge_Incident_Conditions__c order by BMCRF_Sort_Order__c DESC limit 1];
        maxSortOrder=Integer.valueOf(con.BMCRF_Sort_Order__c);
        
        if(objectName=='Incident')
            EBCondition=[select id,Close_Without_Notification__c, Override_Contact__c,Override_Contact_Group__c,Everbridge_Template_ID__c,Query_JSON__c,Everbridge_Template__c,BMCRF_Sort_Order__c from BMCRF_Everbridge_Incident_Conditions__c where Object_Name__c= 'Incident' AND Active__c=true];
        else if(objectName=='Change Request')
            EBCondition=[select id,Close_Without_Notification__c, Override_Contact__c,Override_Contact_Group__c,Everbridge_Template_ID__c,Query_JSON__c,Everbridge_Template__c,BMCRF_Sort_Order__c from BMCRF_Everbridge_Incident_Conditions__c where Object_Name__c = 'Change Request' AND Active__c=true];
    }
    
    public Map<String,String> evaluateCondition(Map<String,String> map_IncValues)
    {
        String EBTemplateID;
        boolean closeWithoutNotification;
        Map<String,String> EBData=new Map<String,String>();
        map_IncidentValues=map_IncValues;
        Map<Integer,String> ebTemplateIds=new Map<integer,String>();
        Map<Integer,Boolean> overrideContact=new Map<integer,Boolean>();
        Map<Integer,Boolean> overrideContactGroup=new Map<integer,Boolean>();
        
        for(Integer x=0;x<EBCondition.size();x++)
        {    
            
            JSONString=EBCondition[x].Query_JSON__c;
            conditionParser=(BMCRF_Model_Condition) JSON.deserialize(JSONString,BMCRF_Model_Condition.class);
            expressionsList = conditionParser.expressions;
            System.debug(expressionsList);
            System.debug(map_IncidentValues);
            
           // if (true) { String foo = null; foo.trim(); } // force execption for debugging
            
            logicalsList = conditionParser.logicals;
            boolAND=NULL;
            boolOR=NULL;
            for(integer i=0;i<expressionsList.size();i++)
            {
               String value1=map_IncidentValues.get(expressionsList[i].attribute);
               String value2=expressionsList[i].value;
               System.debug(value1+' '+value2);
            
               if((i==expressionsList.size()-1 && logicalsList[i].value=='') || (i==expressionsList.size()-1 && logicalsList[i].value=='AND'))
               {
                   ANDCondition(expressionsList[i].operator,value1,value2);
               }              
               else if(i==expressionsList.size()-1 && logicalsList[i].value=='OR')
               {
                   ORCondition(expressionsList[i].operator,value1,value2);
                       
                   if(boolAND==NULL)
                       boolAND=boolOR;
                   else
                       boolAND=boolAND && boolOR;
               }
               else
               {
                   if((logicalsList[i].value=='AND' || logicalsList[i].value=='') && logicalsList[i+1].value!='OR')
                   {
                       ANDCondition(expressionsList[i].operator,value1,value2);
                   }
                   else if(logicalsList[i+1].value != 'AND')
                   {
                       ORCondition(expressionsList[i].operator,value1,value2);
                   }
                   else
                   {
                       //System.debug('ODD');
                       ORCondition(expressionsList[i].operator,value1,value2);
                       if(boolOR != NULL)
                       {
                           if(boolAND==NULL)
                               boolAND=boolOR;
                           else
                               boolAND = boolAND && boolOR;
                       }
                       boolOR=NULL;
                   
                   }
                }
                System.debug('Boolean For ' +boolAND);
            }
             System.debug('Boolean ' +boolAND);
             if(boolAND==true)
             {
             
                 EBTemplateID=EBCondition[x].Everbridge_Template_ID__c;
                 closeWithoutNotification = EBCondition[x].Close_Without_Notification__c;
                 Integer sortOrder=Integer.valueOf(EBCondition[x].BMCRF_Sort_Order__c);
                 ebTemplateIds.put(sortOrder,EBTemplateID);
                 overrideContact.put(sortOrder,EBCondition[x].Override_Contact__c);
                 overrideContactGroup.put(sortOrder,EBCondition[x].Override_Contact_Group__c);
               
             }
             else
                 EBTemplateID='Not found';
         }
         for(integer i=1;i<=maxSortOrder;i++)
         {
             if(ebTemplateIds.containsKey(i))
             {
                 EBTemplateID=ebTemplateIds.get(i);
                 Boolean EBOverrideContact=overrideContact.get(i);
                 Boolean EBOverrideContactGroup=overrideContactGroup.get(i);
                 EBData.put('TemplateId',EBTemplateID);
                 EBData.put('closeWithoutNotification', closeWithoutNotification+'');
                 if(EBOverrideContact)
                     EBData.put('OverrideContact','true');
                 else
                     EBData.put('OverrideContact','false');
                     
                 if(EBOverrideContactGroup)
                     EBData.put('OverrideContactGroup','true');
                 else
                     EBData.put('OverrideContactGroup','false');
                     
                break;
             }
         }
         return EBData;
    }
    
    public void ANDCondition(String op, String value1, String value2)
    {
       
        System.debug('v1=' + value1);
        System.debug('v2=' + value2);
        
        if (value1 == null) value1 = '';
        if (value2 == null) value2 = '';
        
        value1=value1.trim();
        value2=value2.trim();        
        if((value1==value2 && op.equals('Equals'))
            || (value1 != value2 && op=='Not Equals')
            || (value1.startsWithIgnoreCase(value2) && op=='Begins With')
            || (value1.containsIgnoreCase(value2) && op=='Contains'))
        {
            if(boolAND==NULL)
                 boolAND=true;
            else
            {
                 if(boolOR != NULL)
                     boolAND = boolAND && boolOR;
                            
                 boolAND=boolAND && true;
                 boolOR=NULL;
            }
        }
        else
        {   
            boolAND=false;
        }
    }
    
    public void ORCondition(String op, String value1, String value2)
    {
        value1=value1.trim();
        value2=value2.trim();
        if((value1==value2 && op.equals('Equals'))
            || (value1 != value2 && op=='Not Equals')
            || (value1.startsWithIgnoreCase(value2) && op=='Begins With')
            || (value1.containsIgnoreCase(value2) && op=='Contains'))
        {
            if(boolOR==NULL)
                boolOR=true;
            else
                boolOR=boolOR || true;
        }
        else
        {
            if(boolOR==NULL)
                boolOr=false;
            else
                boolOR=boolOR || false;
        }
    }
}