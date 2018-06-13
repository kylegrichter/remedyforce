@istest (SeeAllData = true)
class QueueExtAttrMonitor_Test {
    static testmethod void test() {
        Test.startTest();
        Group queue = new Group();
        queue.DeveloperName='ApexTestQueue';
        queue.Email=[Select email from User where Id = :UserInfo.getUserId()].email;
        queue.Name='ApexTestQueue';
        queue.Type='Queue';
        User usr = [Select id from User where Id = :UserInfo.getUserId()];
        System.RunAs(usr){insert queue;}
        String jobId = System.schedule('testBasicScheduledApex', '0 0 0 3 9 ? 2022', new QueueExtAttrMonitor()); // Schedule the test job
        CronTrigger ct = [SELECT Id, CronExpression, TimesTriggered, NextFireTime FROM CronTrigger WHERE id = :jobId]; // Get the information from the CronTrigger API object
        System.assertEquals('0 0 0 3 9 ? 2022', ct.CronExpression); // Verify the expressions are the same
        System.assertEquals(0, ct.TimesTriggered); // Verify the job has not run
        System.assertEquals('2022-09-03 00:00:00', String.valueOf(ct.NextFireTime)); // Verify the next time the job will run
        Test.stopTest();
    }
}