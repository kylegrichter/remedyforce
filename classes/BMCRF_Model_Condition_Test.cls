@isTest
public class BMCRF_Model_Condition_Test
{
    static testMethod void test()
    {
        String json='{"expressions":[{"attribute":"BMCServiceDesk__Impact_Id__c","operator":"Equals","value":"MEDIUM"}],"logicals":[{"value":""}]}';
        Test.startTest();
        
        BMCRF_Model_Condition.parse(json);
        Test.stopTest();
        
    }
}