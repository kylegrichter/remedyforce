global class BMCRF_JobRunner implements Schedulable {
   
    Integer intervalMinutes  ;
    public BMCRF_JobRunner () {
        this.intervalMinutes = 30;
    }
    public void execute(SchedulableContext sc) {
        //Re-schedule ourself to run again in "intervalMinutes" time
        DateTime now  = DateTime.now();
        DateTime nextRunTime = now.addSeconds(intervalMinutes);
        String cronString = '' + nextRunTime.second() + ' ' + nextRunTime.minute() + ' ' + 
        nextRunTime.hour() + ' ' + nextRunTime.day() + ' ' + 
        nextRunTime.month() + ' ? ' + nextRunTime.year(); 
        try{
        System.schedule(BMCRF_JobRunner.class.getName() + '-' + now.format('dd/MM/YYYY hh:mm:ss'), cronString, new BMCRF_JobRunner());
        //Abort the current job
        
        Id jobId = sc.getTriggerId();
        System.abortJob(jobId);     
        }
        catch(Exception e){}
        //Launch a batch job or call a future method to do the actual work
        Database.executeBatch(new BMCRF_IncidentUpdatebatch());
        Database.executeBatch(new BMCRF_ChangeUpdatebatch());
    }
}