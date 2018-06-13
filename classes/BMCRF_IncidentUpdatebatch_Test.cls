@isTest
public class BMCRF_IncidentUpdatebatch_Test
{
    static testMethod void testStart()
    {
        Test.startTest();
        BMCRF_IncidentUpdatebatch batch=new BMCRF_IncidentUpdatebatch();
        Database.BatchableContext bc;
        batch.start(bc);
        Test.stopTest();
    }
    static testMethod void testExecute()
    {
        Test.startTest();
        BMCRF_IncidentUpdatebatch batch=new BMCRF_IncidentUpdatebatch();
        Database.BatchableContext bc;
        batch.execute(bc,new List<BMCServiceDesk__Incident__c>());
        Test.stopTest();
    }
}