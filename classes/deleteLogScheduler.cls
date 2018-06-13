global class deleteLogScheduler implements Schedulable{

    global void execute(SchedulableContext sc){

        String query = 'select id from LogDb__c where LastModifiedDate != LAST_N_DAYS:5';

        deleteLog delBatch = new deleteLog (query);

        Id BatchProcessId = Database.ExecuteBatch(delBatch);

    }

}