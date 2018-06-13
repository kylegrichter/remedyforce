@isTest
public class BMCRF_JobRunner_Test
{
    static testMethod void testExecute()
    {
        Test.startTest();
        BMCRF_JobRunner jr=new BMCRF_JobRunner();
        SchedulableContext sc;//=new SchedulableContext();
        jr.execute(sc);
        Test.stopTest();
    }
}