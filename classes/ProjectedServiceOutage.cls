public class ProjectedServiceOutage {
    public List<Change_Weekend__c> act = new List<Change_Weekend__c>();
    public List<String> values = new List<String>();
    public String answer;
    public String extra;
    public String getanswer(){ return answer; }
    public void setanswer(String answer){ this.answer = answer; }
    //Calendar Items
    public String dtFormat = 'EEE, d MMM yyyy HH:mm:ss z';
    public list<calEvent> events {get;set;}
    //End Calendar Items
    
    public List<BMCServiceDesk__Projected_Service_Outage__c> getoutages(){
        TimeZone tz = TimeZone.getTimeZone('America/Chicago');
        String weekendID = ApexPages.currentPage().getParameters().get('wkid');
        if (string.isNotBlank(answer)) {
            /* Do nothing */
        } else if (string.isNotBlank(weekendID)) {
            answer = weekendID;
        } else {
            answer = 'NEXT_N_DAYS:30';
        }
        if (answer.contains('DAYS')) {
            extra = ' OR BMCServiceDesk__Start_Date__c = TODAY )';
        } else {
            extra = ') ';
        }
        List<BMCServiceDesk__Projected_Service_Outage__c> outages = 
            Database.query('SELECT Id, Name, Activity_Reason__c, BMCServiceDesk__Start_Date__c, BMCServiceDesk__End_date__c, Available__c, CreatedDate, LastModifiedDate'
                           + ' FROM BMCServiceDesk__Projected_Service_Outage__c' 
                           + ' WHERE ( BMCServiceDesk__Start_Date__c = ' + answer
                           + extra
                           + ' AND BMCServiceDesk__Inactive__c = FALSE'
                           + ' AND BMCServiceDesk__Display_in_Self_Service__c != TRUE'
                           + ' ORDER BY BMCServiceDesk__Start_Date__c');
        for(BMCServiceDesk__Projected_Service_Outage__c e : outages){
            e.BMCServiceDesk__Start_Date__c =  e.BMCServiceDesk__Start_Date__c.addSeconds(tz.getOffset(e.BMCServiceDesk__Start_Date__c)/1000);
            e.BMCServiceDesk__End_date__c =  e.BMCServiceDesk__End_date__c.addSeconds(tz.getOffset(e.BMCServiceDesk__End_date__c)/1000);
        }
        return outages;
    }
    
    public list<calEvent> getoutagesCal(){
        List<BMCServiceDesk__Projected_Service_Outage__c> outages = 
            Database.query('SELECT Id, Name, Activity_Reason__c, BMCServiceDesk__Start_Date__c, BMCServiceDesk__End_date__c, Available__c, CreatedDate, LastModifiedDate'
                           + ' FROM BMCServiceDesk__Projected_Service_Outage__c' 
                           + ' WHERE ( BMCServiceDesk__Start_Date__c >=  Last_Year AND BMCServiceDesk__Start_Date__c <= Next_Year )'
                           + ' AND BMCServiceDesk__Inactive__c = FALSE'
                           + ' AND BMCServiceDesk__Display_in_Self_Service__c != TRUE'
                           + ' ORDER BY BMCServiceDesk__Start_Date__c');
        events = new list<calEvent>();
        for(BMCServiceDesk__Projected_Service_Outage__c e : outages){
            DateTime startDT = e.BMCServiceDesk__Start_Date__c;
            DateTime endDT = e.BMCServiceDesk__End_date__c;
            calEvent event = new calEvent();
             
            event.title = e.Name;
            event.allDay = false;
            event.startString = startDT.format(dtFormat);
            event.endString = endDT.format(dtFormat);
            event.url = '/' + e.Id;
            event.className = e.Available__c;
            events.add(event);
        }
        return events;
    }
    
    public List<SelectOption> getanswers(){
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('NEXT_N_DAYS:30', 'Next 30 Days'));
        options.add(new SelectOption('NEXT_N_DAYS:45', 'Next 45 Days'));
        options.add(new SelectOption('NEXT_N_DAYS:90', 'Next 90 Days'));
        options.add(new SelectOption('', '--------------'));
        options.add(new SelectOption('THIS_MONTH', 'This Month'));
        options.add(new SelectOption('LAST_MONTH', 'Last Month'));
        options.add(new SelectOption('NEXT_MONTH', 'Next Month'));
        options.add(new SelectOption('', '--------------'));
        options.add(new SelectOption('THIS_YEAR', 'This Year'));
        options.add(new SelectOption('LAST_YEAR', 'Last Year'));
        options.add(new SelectOption('NEXT_YEAR', 'Next Year'));
        return options;
    }
    
    public void SendEmail(){
        Id templateId = [select Id from EmailTemplate where name = 'Downtime Report'].id;
        Id contactId = [select Id from Contact where name = 'DL-System Problems'].id;
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setTargetObjectId(contactId);
        mail.setTemplateId(templateId);
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail },false);
    }
    
    public class calEvent{
        public String title {get;set;}
        public Boolean allDay {get;set;}
        public String startString {get;set;}
        public String endString {get;set;}
        public String url {get;set;}
        public Boolean className {get;set;}
    }
}