public class ChangeManagement {
    public Id changeId {get;set;}
    public String emailSent {get;set;}
    public String emailTem {get;set;}
    public String getanswer(){ return answer; }
    public void setanswer(String answer){ this.answer = answer; }
    public List<Change_Weekend__c> act = new List<Change_Weekend__c>();
    public List<String> values = new List<String>();
    public String answer;
    public String offset {get;set;}
    public list<calEvent> events {get;set;}
    public String answerCal{get;set;}
    public String getanswerCal(){ return answerCal; }
    public void setanswerCal(String answer){ this.answerCal = answerCal; }
    public String view{get;set;}
    public String getview(){ return view; }
    public void setview(String view){ this.view = view; }
    public List<Group> grp = new List<Group>();
    public Integer rangeNum {get;set;}
    public Id changeRecord = ApexPages.currentPage().getParameters().get('crid');
    public Id approvalWorkItem {get;set;}
    
    public List<BMCServiceDesk__Incident__c> getincidentsbycr()
    {
        List<BMCServiceDesk__Incident__c> incidents;
        if (changeID != null){
            incidents = [
                SELECT Id, Name, BMCServiceDesk__Type__c,
                BMCServiceDesk__incidentDescription__c, Owner.Name
                FROM BMCServiceDesk__Incident__c
                WHERE Id IN (SELECT BMCServiceDesk__FKIncident__c FROM BMCServiceDesk__Incident_Change_Link__c WHERE BMCServiceDesk__FKChange__c = :changeID)
                ORDER BY Owner.Name
            ];
        } else {
            incidents = [
                SELECT Id, Name, BMCServiceDesk__Type__c,
                BMCServiceDesk__incidentDescription__c, Owner.Name
                FROM BMCServiceDesk__Incident__c
                WHERE Id IN (SELECT BMCServiceDesk__FKIncident__c FROM BMCServiceDesk__Incident_Change_Link__c WHERE BMCServiceDesk__FKChange__c = :changeRecord)
                ORDER BY Owner.Name
            ];
        }
        return incidents;
    }
    
    public List<BMCServiceDesk__Problem__c> getproblemsbycr()
    {
        List<BMCServiceDesk__Problem__c> problems;
        if (changeID != null){
            problems = [
                SELECT Id, Name, BMCServiceDesk__Problem_Description__c, Owner.Name, FKBMC_BaseElement__r.name
                FROM BMCServiceDesk__Problem__c
                WHERE Id IN (SELECT BMCServiceDesk__FKProblem__c FROM BMCServiceDesk__Change_Problem_Link__c WHERE BMCServiceDesk__FKChange__c = :changeID)
                ORDER BY FKBMC_BaseElement__c
            ];
        } else {
            problems = [
                SELECT Id, Name, BMCServiceDesk__Problem_Description__c, Owner.Name, FKBMC_BaseElement__r.name
                FROM BMCServiceDesk__Problem__c
                WHERE Id IN (SELECT BMCServiceDesk__FKProblem__c FROM BMCServiceDesk__Change_Problem_Link__c WHERE BMCServiceDesk__FKChange__c = :changeRecord)
                ORDER BY FKBMC_BaseElement__c
            ];
        }
        return problems;
    }
    
    public List<BMCServiceDesk__Task__c> gettasksbycr()
    {
        List<BMCServiceDesk__Task__c> tasks;
        if (changeID != null){
            tasks = [
                SELECT Id, Name, BMCServiceDesk__FKChange__c, BMCServiceDesk__Scheduled_Start_Date__c,
                BMCServiceDesk__Scheduled_End_Date__c, BMCServiceDesk__taskDescription__c, Owner.Name, 
                Description_Rich_Text__c, BMCServiceDesk__taskResolution__c, BMCServiceDesk__FKStatus__r.Name
                FROM BMCServiceDesk__Task__c
                WHERE BMCServiceDesk__FKChange__c = :changeID
                ORDER BY BMCServiceDesk__Scheduled_Start_Date__c
            ];
        } else {
            tasks = [
                SELECT Id, Name, BMCServiceDesk__FKChange__c, BMCServiceDesk__Scheduled_Start_Date__c,
                BMCServiceDesk__Scheduled_End_Date__c, BMCServiceDesk__taskDescription__c, Owner.Name, 
                Description_Rich_Text__c, BMCServiceDesk__taskResolution__c, BMCServiceDesk__FKStatus__r.Name
                FROM BMCServiceDesk__Task__c
                WHERE BMCServiceDesk__FKChange__c = :changeRecord
                ORDER BY BMCServiceDesk__Scheduled_Start_Date__c
            ];
        }
        return tasks;
    }
    
    public List<BMCServiceDesk__Change_Request__c> getchangesDaily(){
        Datetime starter;
        Datetime ender;
        Datetime extra;
        if (rangeNum == 1 || rangeNum == 2 || rangeNum == 3){
            starter = System.now()-.25;
            ender = System.now()+2.25;
            extra = System.now()-1000;
        } else if (rangeNum == 4){
            starter = System.now()-.25;
            ender = System.now()+1.25;
            extra = System.now()-1000;
        } else if (rangeNum == 5){
            starter = System.now()+4;
            ender = System.now()+5;
            extra = System.now()+2;
        } else {
            starter = System.now()-1;
            ender = System.now()+2;
            extra = System.now()-1000;
        }
        List<BMCServiceDesk__Change_Request__c> changes;
        changes = [
            SELECT Id, Name, BMCServiceDesk__Status__c, BMCServiceDesk__Change_Type__c, BMCServiceDesk__Category__c, BMCServiceDesk__Priority__c, 
            Title__c, BMCServiceDesk__Change_Description__c, Owner.Name, BMCServiceDesk__Scheduled_Start_Date__c, BMCServiceDesk__Scheduled_End_Date__c, 
            BMCServiceDesk__Roll_Out_Plan_Details__c, BMCServiceDesk__Roll_Out_Plan__c, BMCServiceDesk__Back_out_Plan_Details__c,BMCServiceDesk__Back_out_Plan__c,
            Number_of_Linked_Tasks__c, Linked_IRs__c, Linked_PRs__c, Linked_Releases__c, BMCServiceDesk__Change_Category__c, Environment__c, 
            BMCServiceDesk__Reason_for_Change_Details__c, Affected_Systems_Applications__c, BMCServiceDesk__ClosureCategory__c, BMCServiceDesk__Close_Comments__c
            FROM BMCServiceDesk__Change_Request__c
            WHERE 
            (
                (
                    BMCServiceDesk__Scheduled_Start_Date__c >= :starter
                    AND BMCServiceDesk__Scheduled_End_Date__c <= :ender 
                    AND BMCServiceDesk__Scheduled_End_Date__c > :extra
                )
                OR (
                    BMCServiceDesk__Scheduled_Start_Date__c <= :ender
                    AND BMCServiceDesk__Scheduled_End_Date__c >= :starter
                    AND BMCServiceDesk__Scheduled_End_Date__c > :extra
                )
            )
            AND (BMCServiceDesk__Closed_Date_Time__c >= :starter OR BMCServiceDesk__Closed_Date_Time__c = null)
            ORDER BY BMCServiceDesk__Scheduled_Start_Date__c
        ];
        return changes;
    }
    
    public Change_Weekend__c getweekend() {
        if (string.isNotBlank(ApexPages.currentPage().getParameters().get('wkid'))){
            answer = ApexPages.currentPage().getParameters().get('wkid');
        }
        
        Map<String, Schema.SObjectField> fldObjMap = schema.SObjectType.Change_Weekend__c.fields.getMap();
        List<Schema.SObjectField> fldObjMapValues = fldObjMap.values();
        String theQuery = 'SELECT ';
        for(Schema.SObjectField s : fldObjMapValues)
        {
            String theName = s.getDescribe().getName();
            theQuery += theName + ',';
        }
        theQuery = theQuery.subString(0, theQuery.length() - 1);
        
        if (string.isNotBlank(answer)) {
            theQuery += ' FROM Change_Weekend__c WHERE Id = \'' + answer + '\'';
        } else {
            theQuery += ' FROM Change_Weekend__c WHERE End_Date_Time__c > TODAY ORDER BY Start_Date_Time__c LIMIT 1';
        }
        
        Change_Weekend__c weekend = Database.query(theQuery);
        return weekend;
    }
    
    public List<BMCServiceDesk__Task__c> gettasks(){
        if (string.isNotBlank(ApexPages.currentPage().getParameters().get('wkid'))){
            answer = ApexPages.currentPage().getParameters().get('wkid');
        }
        Change_Weekend__c weekend;
        if (string.isNotBlank(answer)) {
            weekend = [
                SELECT Start_Date_Time__c, End_Date_Time__c
                FROM Change_Weekend__c
                WHERE Id = :answer
            ];
        } else {
            weekend = [
                SELECT Start_Date_Time__c, End_Date_Time__c
                FROM Change_Weekend__c
                WHERE End_Date_Time__c > TODAY
                ORDER BY Start_Date_Time__c
                LIMIT 1
            ];
        }
        List<BMCServiceDesk__Task__c> tasks;
        tasks = [
            SELECT Id, Name, BMCServiceDesk__FKChange__r.id, BMCServiceDesk__FKChange__r.Name, BMCServiceDesk__Scheduled_Start_Date__c,
            BMCServiceDesk__Scheduled_End_Date__c, BMCServiceDesk__taskDescription__c,
            BMCServiceDesk__taskResolution__c, Task_Title__c, Description_Rich_Text__c
            FROM BMCServiceDesk__Task__c
            WHERE ((BMCServiceDesk__Scheduled_Start_Date__c >= :weekend.Start_Date_Time__c
                    AND BMCServiceDesk__Scheduled_End_Date__c <= :weekend.End_Date_Time__c)
                   OR (BMCServiceDesk__Scheduled_Start_Date__c <= :weekend.End_Date_Time__c
                       AND BMCServiceDesk__Scheduled_End_Date__c >= :weekend.Start_Date_Time__c))
            AND (BMCServiceDesk__closeDateTime__c >= :weekend.Start_Date_Time__c
                 OR BMCServiceDesk__closeDateTime__c = null)
            AND Owner.Name = 'IT Operations'
            ORDER BY BMCServiceDesk__Scheduled_Start_Date__c
        ];
        return tasks;
    }
    
    public List<BMCServiceDesk__Change_Request__c> getchanges(){
        if (string.isNotBlank(ApexPages.currentPage().getParameters().get('wkid'))){
            answer = ApexPages.currentPage().getParameters().get('wkid');
        }
        Change_Weekend__c weekend;
        if (string.isNotBlank(answer)) {
            weekend = [
                SELECT Start_Date_Time__c, End_Date_Time__c
                FROM Change_Weekend__c
                WHERE Id = :answer
            ];
        } else {
            weekend = [
                SELECT Start_Date_Time__c, End_Date_Time__c
                FROM Change_Weekend__c
                WHERE End_Date_Time__c > TODAY
                ORDER BY Start_Date_Time__c
                LIMIT 1
            ];
        }
        List<BMCServiceDesk__Change_Request__c> changes;
        
        Map<String, Schema.SObjectField> fldObjMap = schema.SObjectType.BMCServiceDesk__Change_Request__c .fields.getMap();
        List<Schema.SObjectField> fldObjMapValues = fldObjMap.values();
        String theQuery = 'SELECT ';
        for(Schema.SObjectField s : fldObjMapValues){if(s.getDescribe().getName() != 'Approval_User_1__c'||s.getDescribe().getName() != 'Approval_User_2__c'){theQuery += s.getDescribe().getName() + ',';}}
        theQuery = theQuery.left(theQuery.length()-1);
        theQuery += ',Owner.Name,BMCServiceDesk__FKStaff__r.Name FROM BMCServiceDesk__Change_Request__c WHERE';
        theQuery += ' ((BMCServiceDesk__Scheduled_Start_Date__c >= '+weekend.Start_Date_Time__c.format('yyyy-MM-dd\'T\'HH:mm:ss.SSSZ')+' AND BMCServiceDesk__Scheduled_End_Date__c <= '+weekend.End_Date_Time__c.format('yyyy-MM-dd\'T\'HH:mm:ss.SSSZ')+')';
        theQuery += ' OR (BMCServiceDesk__Scheduled_Start_Date__c <= ' + weekend.End_Date_Time__c.format('yyyy-MM-dd\'T\'HH:mm:ss.SSSZ') + ' AND BMCServiceDesk__Scheduled_End_Date__c >= ' + weekend.Start_Date_Time__c.format('yyyy-MM-dd\'T\'HH:mm:ss.SSSZ') + '))';
        theQuery += ' AND (BMCServiceDesk__Closed_Date_Time__c >= ' + weekend.Start_Date_Time__c.format('yyyy-MM-dd\'T\'HH:mm:ss.SSSZ') + ' OR BMCServiceDesk__Closed_Date_Time__c = null)';
        theQuery += ' AND (BMCServiceDesk__Category__c != \'Firecall - Finance\'';
        theQuery += ' AND ((((BMCServiceDesk__Category__c = \'Server-Decommission\' AND BMCServiceDesk__Approved__c = false) OR (BMCServiceDesk__Category__c != \'Server-Decommission\'';
        theQuery += ' )) AND ((BMCServiceDesk__Category__c = \'DB Decommission\' AND BMCServiceDesk__Approved__c = false) OR (BMCServiceDesk__Category__c != \'DB Decommission\'))))) ';
        theQuery += ' ORDER BY BMCServiceDesk__Scheduled_Start_Date__c';
        system.Debug('Debug-Query:'+theQuery);
        changes = Database.query(theQuery);
        
        return changes;
    }
    
    public List<BMCServiceDesk__Change_Request__c> getchangesserverdecom(){
        List<BMCServiceDesk__Change_Request__c> forecast;
        
        Datetime CurrentDateTime = System.now();
        
        Map<String, Schema.SObjectField> fldObjMap = schema.SObjectType.BMCServiceDesk__Change_Request__c .fields.getMap();
        List<Schema.SObjectField> fldObjMapValues = fldObjMap.values();
        
        String theQuery = 'SELECT ';
        for(Schema.SObjectField s : fldObjMapValues){theQuery += s.getDescribe().getName() + ',';}
        theQuery = theQuery.left(theQuery.length()-1);
        theQuery += ',Owner.Name,BMCServiceDesk__FKStaff__r.Name FROM BMCServiceDesk__Change_Request__c WHERE';
        theQuery += ' ((BMCServiceDesk__Scheduled_Start_Date__c >= TODAY AND BMCServiceDesk__Scheduled_End_Date__c <= NEXT_N_DAYS:14 )';
        theQuery += ' OR (BMCServiceDesk__Scheduled_Start_Date__c <= NEXT_N_DAYS:14 AND BMCServiceDesk__Scheduled_End_Date__c >= TODAY ))';
        theQuery += ' AND (BMCServiceDesk__Closed_Date_Time__c >= :CurrentDateTime OR BMCServiceDesk__Closed_Date_Time__c = null)';
        theQuery += ' AND (BMCServiceDesk__Category__c = \'Server-Decommission\' OR BMCServiceDesk__Category__c = \'DB Decommission\')';
        theQuery += ' ORDER BY BMCServiceDesk__Scheduled_Start_Date__c';
        system.Debug('Debug-Query:'+theQuery);
        forecast = Database.query(theQuery);
        
        return forecast;
    }
    
    public List<BMCServiceDesk__Change_Request__c> getchangespending(){
        Id currentUser = UserInfo.getUserId();
        
        Map<String, Schema.SObjectField> fldObjMap = schema.SObjectType.BMCServiceDesk__Change_Request__c .fields.getMap();
        List<Schema.SObjectField> fldObjMapValues = fldObjMap.values();
        String theQuery = 'SELECT ';
        for(Schema.SObjectField s : fldObjMapValues){theQuery += s.getDescribe().getName() + ',';}
        theQuery = theQuery.left(theQuery.length()-1);
        theQuery += ' ,Owner.Name,BMCServiceDesk__FKStaff__r.Name FROM BMCServiceDesk__Change_Request__c';
        theQuery += ' WHERE Id IN (';
        String testOutput = 'z';
        for (ProcessInstanceWorkitem piwi : [SELECT ProcessInstance.TargetObjectId FROM ProcessInstanceWorkitem WHERE ActorId = :currentUser]){
            theQuery += '\'' + piwi.ProcessInstance.TargetObjectId + '\',';
            testOutput += piwi.ProcessInstance.TargetObjectId;
            system.debug('testOutput: '+testOutput);
        }
        List<BMCServiceDesk__Change_Request__c> changespending;
        if ( testOutput.length() > 1 ){
            theQuery = theQuery.left(theQuery.length()-1);
            theQuery += ') ORDER BY BMCServiceDesk__Scheduled_Start_Date__c';
            changespending = Database.query(theQuery);
            for (BMCServiceDesk__Change_Request__c a : changespending){
                a.BLANK1__c = [SELECT Id FROM ProcessInstanceWorkitem WHERE ProcessInstance.TargetObjectId = :a.Id and ActorId = :currentUser].Id;
            }
        }
        return changespending;
    }
    
    public void ApproveChange(){
        Id currentUser = UserInfo.getUserId();
        Id approvalWorkItemId = [SELECT Id FROM ProcessInstanceWorkitem WHERE ProcessInstance.TargetObjectId = :approvalWorkItem and ActorId = :currentUser].Id;
        if (!String.isBlank(approvalWorkItemId)){
            Approval.ProcessWorkitemRequest req = new Approval.ProcessWorkitemRequest();
            req.setAction('Approve');
            req.setWorkitemId(approvalWorkItemId);
            Approval.ProcessResult result =  Approval.process(req);    
        }
    }
    
    public void RejectChange(){
        Id currentUser = UserInfo.getUserId();
        Id approvalWorkItemId = [SELECT Id FROM ProcessInstanceWorkitem WHERE ProcessInstance.TargetObjectId = :approvalWorkItem and ActorId = :currentUser].Id;
        if (!String.isBlank(approvalWorkItemId)){
            Approval.ProcessWorkitemRequest req = new Approval.ProcessWorkitemRequest();
            req.setAction('Reject');
            req.setWorkitemId(approvalWorkItemId);
            Approval.ProcessResult result =  Approval.process(req);    
        }
    }
    
    public List<BMCServiceDesk__Change_Request__c> getforecast(){
        List<BMCServiceDesk__Change_Request__c> forecast;
        
        Datetime CurrentDateTime = System.now();
        
        Map<String, Schema.SObjectField> fldObjMap = schema.SObjectType.BMCServiceDesk__Change_Request__c .fields.getMap();
        List<Schema.SObjectField> fldObjMapValues = fldObjMap.values();
        
        String theQuery = 'SELECT ';
        for(Schema.SObjectField s : fldObjMapValues){theQuery += s.getDescribe().getName() + ',';}
        theQuery = theQuery.left(theQuery.length()-1);
        theQuery += ',Owner.Name,BMCServiceDesk__FKStaff__r.Name FROM BMCServiceDesk__Change_Request__c WHERE';
        theQuery += ' ((BMCServiceDesk__Scheduled_Start_Date__c >= TODAY AND BMCServiceDesk__Scheduled_End_Date__c <= NEXT_N_DAYS:14 )';
        theQuery += ' OR (BMCServiceDesk__Scheduled_Start_Date__c <= NEXT_N_DAYS:14 AND BMCServiceDesk__Scheduled_End_Date__c >= TODAY ))';
        theQuery += ' AND (BMCServiceDesk__Closed_Date_Time__c >= :CurrentDateTime OR BMCServiceDesk__Closed_Date_Time__c = null)';
        theQuery += ' AND (BMCServiceDesk__Category__c != \'Firecall - Finance\'';
        theQuery += ' AND ((((BMCServiceDesk__Category__c = \'Server-Decommission\' AND BMCServiceDesk__Approved__c = false) OR (BMCServiceDesk__Category__c != \'Server-Decommission\'';
        theQuery += ' )) AND ((BMCServiceDesk__Category__c = \'DB Decommission\' AND BMCServiceDesk__Approved__c = false) OR (BMCServiceDesk__Category__c != \'DB Decommission\'))))) ';
        theQuery += ' ORDER BY BMCServiceDesk__Scheduled_Start_Date__c';
        system.Debug('Debug-Query:'+theQuery);
        forecast = Database.query(theQuery);
        
        return forecast;
    }
    
    public List<BMCServiceDesk__Task__c> getreleasetasks(){
        Id weekendID = ApexPages.currentPage().getParameters().get('wkid');
        Change_Weekend__c weekend;
        weekend = [
            SELECT Start_Date_Time__c, End_Date_Time__c, Change_Request__c
            FROM Change_Weekend__c
            WHERE Start_Date_Time__c = THIS_WEEK
            AND Weekend_Type__c includes ('Release')
            ORDER BY Start_Date_Time__c
            LIMIT 1
        ];
        List<BMCServiceDesk__Task__c> tasks;
        tasks = [
            SELECT Id, Name, BMCServiceDesk__FKChange__r.id, BMCServiceDesk__FKChange__r.Name, BMCServiceDesk__Scheduled_Start_Date__c,
            BMCServiceDesk__Scheduled_End_Date__c, BMCServiceDesk__taskDescription__c,
            BMCServiceDesk__taskResolution__c, Task_Title__c, Description_Rich_Text__c
            FROM BMCServiceDesk__Task__c
            WHERE BMCServiceDesk__FKChange__c = :weekend.Change_Request__c
            ORDER BY BMCServiceDesk__Scheduled_Start_Date__c
        ];
        return tasks;
    }
    public List<SelectOption> getanswers(){
        String sql = 'SELECT Id, Name, Weekend_Type__c, Start_Date_Time__c, End_Date_Time__c, Release_Code__c, Change_Request__c FROM Change_Weekend__c ORDER BY Start_Date_Time__c';
        act = Database.Query(sql);
        List<SelectOption> options = new List<SelectOption>();
        if (string.isBlank(answer)) {
            options.add(new SelectOption('', ''));
        }
        for(Change_Weekend__c a:act){
            options.add(new SelectOption(a.Id, a.Start_Date_Time__c.format('M/d/yy')));
        }     
        return options;
    }
    public List<SelectOption> getanswersshort(){
        String sql = 'SELECT Id, Name, Weekend_Type__c, Start_Date_Time__c, End_Date_Time__c, Release_Code__c, Change_Request__c FROM Change_Weekend__c WHERE Start_Date_Time__c = LAST_N_DAYS:45 OR Start_Date_Time__c = NEXT_N_DAYS:45 OR Start_Date_Time__c = TODAY ORDER BY Start_Date_Time__c';
        act = Database.Query(sql);
        List<SelectOption> options = new List<SelectOption>();
        if (string.isBlank(answer)) {
            options.add(new SelectOption('', ''));
        }
        for(Change_Weekend__c a:act){
            options.add(new SelectOption(a.Id, a.Start_Date_Time__c.format('M/d/yy')));
        }     
        return options;
    }
    public void SendEmail(){
        ID weekendId = [
            SELECT Id
            FROM Change_Weekend__c
            WHERE End_Date_Time__c > TODAY
            ORDER BY Start_Date_Time__c
            LIMIT 1
        ].id;
        Id templateId = [select Id from EmailTemplate where name = :emailTem].id;
        Id contactId = [select Id from Contact where name = 'DL-IT Weekend Activities'].id;
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setTargetObjectId(contactId);
        mail.setTemplateId(templateId);
        mail.setWhatId(weekendId);
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail },false);
        Change_Weekend__c weekend = [SELECT Pre_Change_Email_Sent__c, First_Draft_Email_Sent__c, Second_Draft_Email_Sent__c, Final_Email_Sent__c, Pre_Change_Task_Email_Sent__c, Final_Task_Email_Sent__c FROM Change_Weekend__c WHERE Start_Date_Time__c >= TODAY ORDER BY Start_Date_Time__c LIMIT 1];
        String emailSent = ApexPages.currentPage().getParameters().get('emailSent');
        if (emailTem.contains('Pre-Change')){
            Id templateIdTasks = [select Id from EmailTemplate where name = 'Weekend Tasks'].id;
            Id contactIdOps = [select Id from Contact where name = 'DL-IT Operations'].id;
            Messaging.SingleEmailMessage mailTask = new Messaging.SingleEmailMessage();
            mailTask.setTargetObjectId(contactIdOps);
            mailTask.setTemplateId(templateIdTasks);
            mailTask.setWhatId(weekendId);
            mailTask.setCcAddresses(new String[] {'DL-ITProductionControl@dexmedia.com', 'dl-dcchangemanagement@dexmedia.com'});
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mailTask },false);
            weekend.Pre_Change_Task_Email_Sent__c = true;
            weekend.Pre_Change_Email_Sent__c = true;
            update weekend;
        } else if (emailTem.contains('1st Draft')){
            weekend.First_Draft_Email_Sent__c = true;
            update weekend;
        } else if (emailTem.contains('2nd Draft')) {
            weekend.Second_Draft_Email_Sent__c = true;
            update weekend;
        } else if (emailTem.contains('Final')){
            Id templateIdTasks = [select Id from EmailTemplate where name = 'Weekend Tasks'].id;
            Id contactIdOps = [select Id from Contact where name = 'DL-IT Operations'].id;
            Messaging.SingleEmailMessage mailTask = new Messaging.SingleEmailMessage();
            mailTask.setTargetObjectId(contactIdOps);
            mailTask.setTemplateId(templateIdTasks);
            mailTask.setWhatId(weekendId);
            mailTask.setCcAddresses(new String[] {'DL-ITProductionControl@dexmedia.com', 'dl-dcchangemanagement@dexmedia.com'});
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mailTask },false);
            weekend.Final_Email_Sent__c = true;
            weekend.Final_Task_Email_Sent__c = true;
            update weekend;
            for (Change_Weekend__c relCode : [SELECT Release_Code__c FROM Change_Weekend__c WHERE Start_Date_Time__c = THIS_WEEK AND Weekend_Type__c includes ('Release') ORDER BY Start_Date_Time__c]) {
                Id templateRelId = [select Id from EmailTemplate where name = 'Weekend Tasks - Release'].id;
                Id contactRelId = [select Id from Contact where name = 'DL-Environment Team'].id;
                Messaging.SingleEmailMessage mailRel = new Messaging.SingleEmailMessage();
                mailRel.setTargetObjectId(contactRelId);
                mailRel.setTemplateId(templateRelId);
                mailRel.setWhatId(weekendId);
                mailRel.setCcAddresses(new String[] {'DL-ITReleaseManagementTeam@dexmedia.com'});
                Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mailRel },false);
            }
        }
    }
    
    public list<calEvent> getchangesCal(){
        events = new list<calEvent>();
        Id crID = ApexPages.currentPage().getParameters().get('id');
        if (string.isNotBlank(ApexPages.currentPage().getParameters().get('answer'))){
            answer = ApexPages.currentPage().getParameters().get('answer');
        }
        BMCServiceDesk__Change_Request__c mainCR;
        Datetime mainStart;
        Datetime mainEnd;
        if (crID == null){
            mainStart = system.now().addMonths(-3);
            mainEnd = system.now().addMonths(3);
        } else {
            mainCR = [SELECT BMCServiceDesk__Scheduled_Start_Date__c, BMCServiceDesk__Scheduled_End_Date__c FROM BMCServiceDesk__Change_Request__c WHERE Id = :crID];
            mainStart = mainCR.BMCServiceDesk__Scheduled_Start_Date__c.addDays(-7);
            mainEnd = mainCR.BMCServiceDesk__Scheduled_End_Date__c.addDays(7);
        }
        if (string.isNotBlank(answer)){
            for(BMCServiceDesk__Change_Request__c evnt: [
                SELECT Id,Name,BMCServiceDesk__Status__c,Title__c,Owner.Name,BMCServiceDesk__Scheduled_Start_Date__c,BMCServiceDesk__Scheduled_End_Date__c,Environment__c
                FROM BMCServiceDesk__Change_Request__c
                WHERE ((BMCServiceDesk__Scheduled_Start_Date__c >= :mainStart AND BMCServiceDesk__Scheduled_End_Date__c <= :mainEnd) OR (BMCServiceDesk__Scheduled_Start_Date__c <= :mainEnd AND BMCServiceDesk__Scheduled_End_Date__c >= :mainStart))
                AND (BMCServiceDesk__Closed_Date_Time__c >= :mainStart OR BMCServiceDesk__Closed_Date_Time__c = null)
                AND BMCServiceDesk__Category__c != 'Firecall - Finance'
                AND BMCServiceDesk__queueName__c = :answer
                ORDER BY BMCServiceDesk__Scheduled_Start_Date__c
            ]){
                DateTime endDT = evnt.BMCServiceDesk__Scheduled_End_Date__c;
                DateTime startDT = evnt.BMCServiceDesk__Scheduled_Start_Date__c;
                Boolean allDayFlag;
                if (endDT < startDT.addHours(1)){endDT = startDT.addHours(1);}
                if (endDT >= startDT.addHours(36)){allDayFlag = true;} else {allDayFlag = false;}
                calEvent myEvent = new calEvent();
                myEvent.title = evnt.Title__c;
                myEvent.allDay = allDayFlag;
                myEvent.startString = startDT.format('yyyy-MM-dd HH:mm:ss','America/Chicago');
                myEvent.endString = endDT.format('yyyy-MM-dd HH:mm:ss','America/Chicago');
                myEvent.url = '/' + evnt.Id;
                myEvent.className = evnt.Environment__c;
                myEvent.status = evnt.BMCServiceDesk__Status__c;
                myEvent.owner = evnt.Owner.Name;
                events.add(myEvent);
            }            
        } else {
            for(BMCServiceDesk__Change_Request__c evnt: [
                SELECT Id,Name,BMCServiceDesk__Status__c,Title__c,Owner.Name,BMCServiceDesk__Scheduled_Start_Date__c,BMCServiceDesk__Scheduled_End_Date__c,Environment__c
                FROM BMCServiceDesk__Change_Request__c
                WHERE ((BMCServiceDesk__Scheduled_Start_Date__c >= :mainStart AND BMCServiceDesk__Scheduled_End_Date__c <= :mainEnd) OR (BMCServiceDesk__Scheduled_Start_Date__c <= :mainEnd AND BMCServiceDesk__Scheduled_End_Date__c >= :mainStart))
                AND (BMCServiceDesk__Closed_Date_Time__c >= :mainStart OR BMCServiceDesk__Closed_Date_Time__c = null)
                AND BMCServiceDesk__Category__c != 'Firecall - Finance'
                ORDER BY BMCServiceDesk__Scheduled_Start_Date__c
            ]){
                DateTime endDT = evnt.BMCServiceDesk__Scheduled_End_Date__c;
                DateTime startDT = evnt.BMCServiceDesk__Scheduled_Start_Date__c;
                Boolean allDayFlag;
                if (endDT < startDT.addHours(1)){endDT = startDT.addHours(1);}
                if (endDT >= startDT.addHours(36)){allDayFlag = true;} else {allDayFlag = false;}
                calEvent myEvent = new calEvent();
                myEvent.title = evnt.Title__c;
                myEvent.allDay = allDayFlag;
                myEvent.startString = startDT.format('yyyy-MM-dd HH:mm:ss','America/Chicago');
                myEvent.endString = endDT.format('yyyy-MM-dd HH:mm:ss','America/Chicago');
                myEvent.url = '/' + evnt.Id;
                myEvent.className = evnt.Environment__c;
                myEvent.status = evnt.BMCServiceDesk__Status__c;
                myEvent.owner = evnt.Owner.Name;
                events.add(myEvent);
            }
        }
        return events;
    }
    
    public DateTime getdefaultDate(){
        Id crID = ApexPages.currentPage().getParameters().get('id');
        BMCServiceDesk__Change_Request__c mainCR;
        Datetime mainStart;
        if (crID == null){
            mainStart = system.now();
        } else {
            mainCR = [SELECT BMCServiceDesk__Scheduled_Start_Date__c, BMCServiceDesk__Scheduled_End_Date__c FROM BMCServiceDesk__Change_Request__c WHERE Id = :crID];
            mainStart = mainCR.BMCServiceDesk__Scheduled_Start_Date__c;
        }
        DateTime defaultDate = mainStart;        
        return defaultDate;
    }
    
    public class calEvent{
        public String title {get;set;}
        public Boolean allDay {get;set;}
        public String startString {get;set;}
        public String endString {get;set;}
        public String url {get;set;}
        public String className {get;set;}
        public String status {get;set;}
        public String owner {get;set;}
    }
    
    public List<SelectOption> getanswersCal(){
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('', 'Show All'));
        options.add(new SelectOption('', '--------------------'));
        for(Group a:[select Id, Name from Group where Type = 'Queue' AND Id IN ( select QueueId from QueueSobject where SobjectType = 'BMCServiceDesk__Change_Request__c') and (NOT Name like 'Do Not Use%') Order By Name])
        {
            options.add(new SelectOption(a.Name, a.Name));
        }     
        return options;
    }
}