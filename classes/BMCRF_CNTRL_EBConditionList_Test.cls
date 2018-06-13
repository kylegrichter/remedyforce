@isTest
public class BMCRF_CNTRL_EBConditionList_Test
{
    static testMethod void testGetconditionList()
    {
        BMCRF_CNTRL_EBConditionList.CondListWrapper innerClass=new BMCRF_CNTRL_EBConditionList.CondListWrapper();
        
        BMCRF_Everbridge_Incident_Conditions__c condition=new BMCRF_Everbridge_Incident_Conditions__c();
        condition.Active__c=true;
        condition.Everbridge_Template__c='Test';
        condition.Everbridge_Template_ID__c='Test';
        condition.Name__c='Test';
        condition.Object_Name__c='Test';
        condition.Short_Description__c='Test';
        insert condition;
        
        BMCRF_CNTRL_EBConditionList conditionList=new BMCRF_CNTRL_EBConditionList();
        conditionList.getconditionList();
    }
    static testMethod void testGetcolumnHeaders()
    {
        BMCRF_CNTRL_EBConditionList conditionList=new BMCRF_CNTRL_EBConditionList();
        conditionList.getcolumnHeaders();
    }
    static testMethod void testGetFields()
    {
        BMCRF_CNTRL_EBConditionList conditionList=new BMCRF_CNTRL_EBConditionList();
        conditionList.getFields();
    }
    static testMethod void testNewCondition()
    {
        BMCRF_CNTRL_EBConditionList conditionList=new BMCRF_CNTRL_EBConditionList();
        conditionList.newCondition();
    }
    
    
}