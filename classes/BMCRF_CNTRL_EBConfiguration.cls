public class BMCRF_CNTRL_EBConfiguration {

    public string recordID{get;set;}
    public List<SelectOption> getExtIDs() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('Username','Username'));
        options.add(new SelectOption('Federation ID','Federation ID'));
        options.add(new SelectOption('Record ID','Record ID'));
        return options;
    }
    public String checkResult {get; set;}
    public String displayMessage{get; set;}
    
    public BMCRF_EB_Incident_Configuration__c  ebConfig;
    public BMCRF_EB_Incident_Configuration__c ebConfig2;
    
    public String getVersionNumber() {
        return '1.0.0';
    }
    
    public BMCRF_CNTRL_EBConfiguration (ApexPages.StandardController controller) {
    
        ebConfig = [select ID, BMCRF_Everbridge_Webhook_URL__c, BMCRF_Everbridge_Organization_ID__c, BMCRF_Everbridge_Username__c, 
                                                               BMCRF_Everbridge_Password__c, BMCRF_Everbridge_API_URL_Base__c, BMCRF_Everbridge_External_ID_Field__c
                                                            from BMCRF_EB_Incident_Configuration__c limit 1];
        recordID = ebConfig.id;
        
        this.ebConfig2 = (BMCRF_EB_Incident_Configuration__c)controller.getRecord();
        

    }
    
    public void testConnection(){

        String state = 'insert';
        String baseuri = ebConfig2.BMCRF_Everbridge_API_URL_Base__c;
        String uname_Password = ebConfig2.BMCRF_Everbridge_Username__c + ':' + ebConfig2.BMCRF_Everbridge_Password__c ;
        Blob toBlob = Blob.valueOf(uname_Password);
        String credentials = EncodingUtil.base64Encode(toBlob);
        String OraganizationId = ebConfig2.BMCRF_Everbridge_Organization_ID__c;
        
        //Create a new HTTP instance
        Http h = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint(baseuri+'/incidents/'+OraganizationId+'/');    
        req.setMethod('GET');
        req.setHeader('Content-Type', 'application/json');
        req.setHeader('Authorization', 'Basic '+credentials);
        req.setHeader('organizationId', OraganizationId);
        HttpResponse res = new HttpResponse();
        try{
        res = h.send(req);
        }catch(Exception e){System.debug('EXCEPTION IN HTTP CALLOUT::::'+e);}

        if(res.getStatusCode() == 200){
            this.displayMessage = 'Connection Successfull!';
            
        }
        else{
            this.displayMessage = 'Connection Failed!';    
        }

        
    }
    
    public PageReference save(){
        try{
            if(ebConfig2.BMCRF_Auto_Assignment__c)
            {
                List<CronJobDetail> scheduledjobs = [SELECT Id, Name, JobType FROM CronJobDetail where name like 'BMCRF_JobRunner%'];
                if(scheduledjobs==NULL || scheduledjobs.size()==0)
                {
                    DateTime currentTime = system.now();
                    DateTime newTime = currentTime + 0.003455/4;//0.00691; //10 Minutes.        
                    String day = string.valueOf(newTime.day());
                    String month = string.valueOf(newTime.month());
                    String hour = string.valueOf(newTime.hour());
                    String minute = string.valueOf(newTime.minute());
                    String second = string.valueOf(newTime.second());
                    String year = string.valueOf(newTime.year());
                    String strJobName = 'BMCRF_JobRunner-' + second + '_' + minute + '_' + hour + '_' + day + '_' + month + '_' + year; //Schedule job name as per your requirement.
                    String strSchedule = '0 ' + minute + ' ' + hour + ' ' + day + ' ' + month + ' ?' + ' ' + year;
                    system.debug('strSchedule:-----' + strSchedule);
                    System.schedule(strJobName, strSchedule, new BMCRF_JobRunner());

                }
            }
            if(!ebConfig2.BMCRF_Auto_Assignment__c)
            {
                list<BMCServiceDesk__Incident__c> incList = [select id,BMCRF_Assigned_By_EB__c from BMCServiceDesk__Incident__c where BMCRF_Assigned_By_EB__c = false and BMCServiceDesk__state__c =true];
                list<BMCServiceDesk__Change_Request__c> crList = [select id,BMCRF_Assigned_By_EB__c from BMCServiceDesk__Change_Request__c where BMCRF_Assigned_By_EB__c = false and BMCServiceDesk__state__c =true];
                list<BMCServiceDesk__Incident__c> upInc = new list<BMCServiceDesk__Incident__c>();
                list<BMCServiceDesk__Change_Request__c> upCr = new list<BMCServiceDesk__Change_Request__c>();
                
                for(BMCServiceDesk__Incident__c inc :incList){
                    inc.BMCRF_Assigned_By_EB__c = true;
                    upInc.add(inc);
                }
                
                for(BMCServiceDesk__Change_Request__c cr :crList){
                    cr.BMCRF_Assigned_By_EB__c = true;
                    upCr.add(cr);
                }
                update upInc;
                update upCr;
            }
            update ebConfig2;
            }catch(Exception e){System.debug('EXCEPTION IN INSERT OPERATION OF SAVE METHOD::::'+e);}
        PageReference currentPage = ApexPages.currentPage();
        return currentPage;
    }
    
    public void getConnectionStatus(){
        
    }
    
}