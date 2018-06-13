@isTest
public class BMCRF_HELPER_EvaluateCondition_Test
{
    

    static testMethod void test1()
    {
        List<BMCRF_Everbridge_Incident_Conditions__c> conditionObjList=new List<BMCRF_Everbridge_Incident_Conditions__c>();
        for(Integer i=0;i<6;i++)
        {
            BMCRF_Everbridge_Incident_Conditions__c conditionObj=new BMCRF_Everbridge_Incident_Conditions__c();
            conditionObj.Name__c='Test';
            conditionObj.Active__c=true;
            conditionObj.BMCRF_Sort_Order__c=5;
            conditionObj.Object_Name__c='Incident';
            conditionObj.Everbridge_Template__c='EB Template';
            if(i==0)
                conditionObj.Query_JSON__c='{"expressions":[{"attribute":"BMCServiceDesk__Impact_Id__c","operator":"Equals","value":"HIGH"},{"attribute":"BMCServiceDesk__Impact_Id__c","operator":"Equals","value":"HIGH"},{"attribute":"BMCServiceDesk__Impact_Id__c","operator":"Equals","value":"HIGH"},{"attribute":"BMCServiceDesk__Impact_Id__c","operator":"Equals","value":"HIGH"},{"attribute":"BMCServiceDesk__Impact_Id__c","operator":"Equals","value":"HIGH"},{"attribute":"BMCServiceDesk__Impact_Id__c","operator":"Equals","value":"HIGH"},{"attribute":"BMCServiceDesk__incidentDescription__c","operator":"Contains","value":"Test"},{"attribute":"BMCServiceDesk__Impact_Id__c","operator":"Not Equals","value":"HIGH"},{"attribute":"BMCServiceDesk__Impact_Id__c","operator":"Equals","value":"MEDIUM"},{"attribute":"BMCServiceDesk__incidentDescription__c","operator":"Begins With","value":"Test"},{"attribute":"BMCServiceDesk__Impact_Id__c","operator":"Equals","value":"HIGH"},{"attribute":"BMCServiceDesk__Impact_Id__c","operator":"Equals","value":"HIGH"}],"logicals":[{"value":""},{"value":"AND"},{"value":"OR"},{"value":"OR"},{"value":"AND"},{"value":"OR"},{"value":"OR"},{"value":"AND"},{"value":"OR"},{"value":"OR"},{"value":"AND"},{"value":"AND"}]}';
            if(i==1)
                conditionObj.Query_JSON__c='{"expressions":[{"attribute":"BMCServiceDesk__Impact_Id__c","operator":"Equals","value":"HIGH"},{"attribute":"BMCServiceDesk__incidentDescription__c","operator":"Contains","value":"D"}],"logicals":[{"value":""},{"value":"OR"}]}';
            if(i==2)
                conditionObj.Query_JSON__c='{"expressions":[{"attribute":"BMCServiceDesk__Impact_Id__c","operator":"Equals","value":"HIGH"},{"attribute":"BMCServiceDesk__incidentDescription__c","operator":"Begins With","value":"Test"},{"attribute":"BMCServiceDesk__incidentDescription__c","operator":"Contains","value":"Test"}],"logicals":[{"value":""},{"value":"AND"},{"value":"AND"}]}';
            if(i==3)
                conditionObj.Query_JSON__c='{"expressions":[{"attribute":"BMCServiceDesk__Impact_Id__c","operator":"Equals","value":"HIGH"}],"logicals":[{"value":""}]}';
            if(i==4)
                conditionObj.Query_JSON__c='{"expressions":[{"attribute":"BMCServiceDesk__incidentDescription__c","operator":"Contains","value":"Test"}],"logicals":[{"value":""}]}';
            if(i==5)
                conditionObj.Query_JSON__c='{"expressions":[{"attribute":"BMCServiceDesk__Impact_Id__c","operator":"Not Equals","value":"HIGH"},{"attribute":"BMCServiceDesk__incidentDescription__c","operator":"Begins With","value":"Test"},{"attribute":"BMCServiceDesk__incidentDescription__c","operator":"Begins With","value":"Stet"},{"attribute":"BMCServiceDesk__incidentDescription__c","operator":"Contains","value":"Test"},{"attribute":"BMCServiceDesk__incidentDescription__c","operator":"Contains","value":"Stes"},{"attribute":"BMCServiceDesk__Impact_Id__c","operator":"Equals","value":"LOW"},{"attribute":"BMCServiceDesk__Impact_Id__c","operator":"Equals","value":"HIGH"},{"attribute":"BMCServiceDesk__Impact_Id__c","operator":"Equals","value":"MEDIUM"}],"logicals":[{"value":""},{"value":"OR"},{"value":"OR"},{"value":"OR"},{"value":"OR"},{"value":"OR"},{"value":"OR"},{"value":"OR"}]}';
                
            conditionObjList.add(conditionObj);
        }
        
        insert conditionObjList;
        
        Map<String,String> map_IncidentValues=new Map<String,String>();
        map_IncidentValues.put('BMCServiceDesk__Impact_Id__c','HIGH');
        map_IncidentValues.put('BMCServiceDesk__incidentDescription__c','Test Description');
        map_IncidentValues.put('BMCServiceDesk__Urgency_ID__c','HIGH');
        BMCRF_HELPER_EvaluateCondition obj = new BMCRF_HELPER_EvaluateCondition('Incident');
        Test.startTest();
        obj.evaluateCondition(map_IncidentValues);
        Test.stopTest();
    }
}