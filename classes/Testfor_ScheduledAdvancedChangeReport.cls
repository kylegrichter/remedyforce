@istest (SeeAllData = true)
class Testfor_ScheduledAdvancedChangeReport {
    
    static testmethod void test() {
        Test.startTest();
        
        // Schedule the test job
        
        String jobId = System.schedule('testBasicScheduledApex',
                                       '0 0 0 3 9 ? 2022', 
                                       new scheduledAdvancedChangeReport());
        
        // Get the information from the CronTrigger API object
        CronTrigger ct = [SELECT Id, CronExpression, TimesTriggered, 
                          NextFireTime
                          FROM CronTrigger WHERE id = :jobId];
        
        // Verify the expressions are the same
        System.assertEquals('0 0 0 3 9 ? 2022', 
                            ct.CronExpression);
        
        // Verify the job has not run
        System.assertEquals(0, ct.TimesTriggered);
        
        // Verify the next time the job will run
        System.assertEquals('2022-09-03 00:00:00', 
                            String.valueOf(ct.NextFireTime));
        
        Test.stopTest();
        
    }
}