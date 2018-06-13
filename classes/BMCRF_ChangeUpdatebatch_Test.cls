@isTest
public class BMCRF_ChangeUpdatebatch_Test
{
    static testMethod void testStart()
    {
        Test.startTest();
        BMCRF_ChangeUpdatebatch batch=new BMCRF_ChangeUpdatebatch();
        Database.BatchableContext bc;
        batch.start(bc);
        Test.stopTest();
    }
    static testMethod void testExecute()
    {
        Test.startTest();
        BMCRF_ChangeUpdatebatch batch=new BMCRF_ChangeUpdatebatch();
        Database.BatchableContext bc;
        batch.execute(bc,new List<BMCServiceDesk__Change_Request__c>());
        Test.stopTest();
    }
}