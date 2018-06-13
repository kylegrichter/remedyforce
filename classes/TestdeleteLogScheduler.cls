@isTest
private class TestdeleteLogScheduler {
    public static testMethod void testRunAs() {
        
               
            Test.startTest();
            List<LogDb__c> lglst=new List<LogDb__c>();
            LogDb__c lgd=new LogDb__c();
            lgd.errorId__C='TESTABCD';
            lgd.Log_Detail__C='TestDetail';
            lgd.Operation__C='insert';
            lglst.add(lgd);
            database.insert(lglst,false);
            LogDb__c lgc=lglst.get(0);
            system.debug('Papia lgc object:'+lgc);
             //String tstquery = 'select id from LogDb__c where id=:lgc.id';
             String tstquery = 'select id from LogDb__c where LastModifiedDate != LAST_N_DAYS:0';

           deleteLog  ob = new deleteLog(tstquery);
            ob.execute(null,lglst);
            //deleteLog delBatch = new deleteLog (tstquery);
            ob.finish(null);
           ID batchprocessid = Database.executeBatch(ob);
          //ID batchprocessid = Database.executeBatch( deleteLogScheduler, 200);
          deleteLogScheduler dls=new deleteLogScheduler();
          dls.execute(null);
            Test.stopTest();
            }
       }