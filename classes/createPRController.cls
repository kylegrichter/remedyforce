/******************************************************************************
Name:  createPRController
Copyright © 2014  DexMedia Inc. 
==============================================================================
Purpose:                                                            
This class to create a Defect in Ralley when a PR is inserted in Remedy
==============================================================================
History                                                            
-------                                                            
VERSION     AUTHOR              DATE           DETAIL           FEATURES/CSR/TTP
------      ------              -----         ---------         -----------------
1.0       Guru Vattam         04/01/2014     Initial Development           
*****************************************************************************/

public class createPRController {
    @future(callout =true)
    public static void CreatePr(id PRId,String sessionId,String UserName, String ServerUrl){
        Id ProblemRecordId;  
        String ServrUrl;                  
        String ProblemRecord;
        String userSessionId;
        String UsrName;
        String category1;
        String ConfigItem;
        String Impact;
        String priority;
        String GroupName;
        String Urgency;
        String status;  
        String StaffName;
        String changerecord ;
        String checkoutby ;
        String checkoutduration;
        String dependencies ;
        String description;
        String hasWarningOrError;
        String errorSource;
        String migratedBy; 
        userSessionId = sessionId;
        ProblemRecordId = PRId;
        UsrName = UserName;
        ServrUrl = ServerUrl;
        
        
        BMCServiceDesk__Problem__c PRObj = [select id,Name,BMCServiceDesk__FKCategory__r.Name,BMCServiceDesk__FKStaff__r.Name,FKBMC_BaseElement__r.Name,BMCServiceDesk__FKImpact__r.Name,BMCServiceDesk__FKPriority__r.Name,BMCServiceDesk__FKUrgency__r.Name,
                                            Change_Record__c,Checkout_By__c,Checkout_Duration__c,Dependencies__c,BMCServiceDesk__Problem_Description__c,Fallout__c,Migrated_By__c,
                                            Owner_Phase__c,BMCServiceDesk__Problem_Source__c,RCA_Reason_Code__c,RCA_Source__c,Release_Manager_Notes__c,BMCServiceDesk__Problem_Resolution__c,Root_Cause_Analysis__c,
                                            Scrum_Team__c,BMCServiceDesk__FKStatus__r.Name,BMCServiceDesk__Work_Around__c from BMCServiceDesk__Problem__c where id=:ProblemRecordId];
                                            
        if(PRObj.BMCServiceDesk__FKCategory__r.Name!=null){                                    
        category1 = PRObj.BMCServiceDesk__FKCategory__r.Name;
        system.debug(':::::::category'+category1);
        }else{
        category1 = ''; 
        }
        if(PRObj.FKBMC_BaseElement__r.Name!=null){
        ConfigItem = PRObj.FKBMC_BaseElement__r.Name;
        }else{
        ConfigItem = '';    
        }
        if(PRObj.BMCServiceDesk__FKImpact__r.Name!=null){
        Impact = PRObj.BMCServiceDesk__FKImpact__r.Name;
        system.debug('impact'+Impact);
        }else{
        Impact = '';    
        }
        if(PRObj.BMCServiceDesk__FKPriority__r.Name!=null){
        priority = PRObj.BMCServiceDesk__FKPriority__r.Name;
        }else{
        priority = '';
        }
        if(PRObj.BMCServiceDesk__FKUrgency__r.Name!=null){
        Urgency = PRObj.BMCServiceDesk__FKUrgency__r.Name;
        }else{
        Urgency = '';   
        }
        if(PRObj.BMCServiceDesk__FKStatus__r.Name!=null){
        status = PRObj.BMCServiceDesk__FKStatus__r.Name;
        }else{
        status = '';    
        }
        String UserID = UserInfo.getUserId(); 
        String Queuename = '';
        User UserObj = [select Id,Name,UserRole.Name,UserRoleId from User where Name=:UsrName ];
        List<Group> roleGrps = [Select Id from Group where Type='Role' AND RelatedId= : UserObj.UserRoleId];
        for(GroupMember grpM : [Select Group.Name from GroupMember where UserOrGroupId IN: roleGrps]){
        Queuename = grpM.Group.Name;    
        System.debug('Queue Name: ' + grpM.Group.Name);
        }
        
        UserName = UserObj.Name;
         //UserObj.UserRole.Name;
        
        wwwTibcoComSchemasRallyInterfaceSh.pvEsbSecurityInfo EsbObject = new wwwTibcoComSchemasRallyInterfaceSh.pvEsbSecurityInfo();
        EsbObject.clientSystemId = '';
        EsbObject.esbClientId = 'mpisfdc';
        EsbObject.esbClientPassword = 'djb03y76';
        EsbObject.serverUrl = ServrUrl;
        EsbObject.sessionId = userSessionId;
        EsbObject.sourceAppInfo = 'REMEDYFORCE';
        
        wwwTibcoComSchemasRallyInterfaceSh.esbFault PREsbFault = new wwwTibcoComSchemasRallyInterfaceSh.esbFault();
        
        List<wwwTibcoComSchemasRallyInterfaceSh.esbFault> PREsbFaultList = new List<wwwTibcoComSchemasRallyInterfaceSh.esbFault>();
        
        xmlnsExampleCom1395789827798.prCreatePortTypeEndpoint1 stub = new xmlnsExampleCom1395789827798.prCreatePortTypeEndpoint1();
        stub.endpoint_x = System.Label.CreateUpdatePRTaskEndpoint;
        stub.pvEsbSecurityInfo = EsbObject;
        stub.timeout_x = 120000;
        List<wwwTibcoComSchemasRallyInterfaceSh.linkedIncidents_element> ListIncidents = new List<wwwTibcoComSchemasRallyInterfaceSh.linkedIncidents_element>();
        
        wwwTibcoComSchemasRallyInterfaceSh.linkedIncidents_element Incidents = new wwwTibcoComSchemasRallyInterfaceSh.linkedIncidents_element();
        Incidents.action = '';
        Incidents.category = '';
        Incidents.clientName = '';
        Incidents.incidentNo = '';
        Incidents.incidentProblemLink = '';
        Incidents.incidentProblemLinkName = '';
        Incidents.lastQueue = '';
        Incidents.openedDate = '';
        Incidents.slientID = '';
        Incidents.staff = '';
        Incidents.status = '';
        
        ListIncidents.add(Incidents);
        
        wwwTibcoComSchemasRallyInterfaceSh.PRCreate_element createElement =  new wwwTibcoComSchemasRallyInterfaceSh.PRCreate_element();
        createElement.categoy = category1;
        if(PRObj.Change_Record__c!=null){
        changerecord =PRObj.Change_Record__c;
        }else{
        changerecord = '';  
        }
        createElement.changeRecord = changerecord;
        if(PRObj.Checkout_By__c!=null){
        checkoutby = PRObj.Checkout_By__c;
        }else{
        checkoutby = '';    
        }
        createElement.checkoutBy = checkoutby;
        createElement.status = status;
        if(PRObj.Checkout_Duration__c!=null){
        checkoutduration = PRObj.Checkout_Duration__c;
        }else{
        checkoutduration = '';  
        }
        createElement.checkoutDuration = checkoutduration;
        createElement.configurationItem = ConfigItem;
        if(PRObj.Dependencies__c!=null){
        dependencies = PRObj.Dependencies__c;
        }else{
        dependencies = '';  
        }
        createElement.dependencies = dependencies ;
        if(PRObj.BMCServiceDesk__Problem_Description__c!=null){
        description = PRObj.BMCServiceDesk__Problem_Description__c;
        }else{
        description = '';   
        }
        createElement.description = description;
        String fallout = '';
        if(PRObj.Fallout__c == true){
           fallout = 'true';
           
        }else{
           fallout = 'false';
        }
        createElement.fallout = fallout;    
        createElement.impact = Impact;
        if(PRObj.Migrated_By__c!=null){
           migratedBy = PRObj.Migrated_By__c;
           
        }else{
           migratedBy = '';
        }
        createElement.migratedBy = migratedBy;
        String Phase = PRObj.Owner_Phase__c;
        createElement.phase = Phase;
        createElement.priority = priority;
        ProblemRecord = PRObj.Name;
        createElement.problemId = ProblemRecord;
        String PRSource = PRObj.BMCServiceDesk__Problem_Source__c;
        createElement.problemSource = PRSource;
        createElement.queue = Queuename;
        system.debug(':::::'+createElement.queue);
        String reasoncode = PRObj.RCA_Reason_Code__c;
        createElement.rcaReasonCode = reasoncode;
        String rcasource = PRObj.RCA_Source__c;
        createElement.rcaSource = rcasource;
        String releasemangrnotes = PRObj.Release_Manager_Notes__c;
        createElement.releaseManagerNotes = releasemangrnotes;
        String resolution = PRObj.BMCServiceDesk__Problem_Resolution__c;
        createElement.resolution = resolution;
        String rootcauseanalysis = PRObj.Root_Cause_Analysis__c;
        createElement.rootCauseAnalysis = rootcauseanalysis;
        String scrumteam = PRObj.Scrum_Team__c; 
        createElement.scrumTeam = scrumteam;
        if(PRObj.BMCServiceDesk__FKStaff__c!=null){
            StaffName = UserName;
        }else{
            StaffName = '';
        }
       
        createElement.staff = StaffName;
        createElement.urgency = Urgency;
        String workaround = PRObj.BMCServiceDesk__Work_Around__c;
        createElement.workaround = workaround;
        createElement.linkedIncidents = ListIncidents;
        
        
        wwwTibcoComSchemasRallyInterfaceSh.prCreateRequest_element ReqObj = new wwwTibcoComSchemasRallyInterfaceSh.prCreateRequest_element();
        
        ReqObj.PRCreate = createElement;
        
        
        wwwTibcoComSchemasRallyInterfaceSh.PRResponse respObj = new wwwTibcoComSchemasRallyInterfaceSh.PRResponse();
        if(!(Test.isRunningTest()))
        {
        respObj = stub.prCreate(ProblemRecord, PRSource, category1, Impact, Urgency, description, priority, resolution, status, workaround, rootcauseanalysis, Phase, rcaSource, reasoncode, scrumTeam, fallout, ConfigItem, changeRecord, migratedBy, dependencies, releasemangrnotes, checkoutBy, checkoutduration, Queuename, UserName, ListIncidents);
        }
        system.debug('respObj'+respObj);
        
        if(respObj!=null){
            if(respObj.hasWarningOrError!=null){
                hasWarningOrError = respObj.hasWarningOrError;
                 if(hasWarningOrError== 'true'){
                    List<BMCServiceDesk__Problem__c> PRRecordObj = new List<BMCServiceDesk__Problem__c>();
                    PRRecordObj = [select id,RalleyID__c,RalleyURL__c from BMCServiceDesk__Problem__c where id=:ProblemRecordId];
                    for(BMCServiceDesk__Problem__c  UpdatePrObj: PRRecordObj){
                        UpdatePrObj.RalleyID__c = respObj.rallyId ;
                        UpdatePrObj.RalleyURL__c = respObj.rallyObjectUrl ;
                        database.update(UpdatePrObj);
                        
                    }
                    
                    
                 }
                
                
            }
            
        }
        
        
        
        
        
        
        
        
        
    }
    
    
    @future(callout =true)
    public static void UpdatePr(id PRId,String sessionId,String UserName, String ServerUrl){
        Id ProblemRecordId;                    
        String ProblemRecord;
        String UsrName;
        String userSessionId;
        String ServrUrl;
        userSessionId = sessionId;
        system.debug(':::::userSessionId'+userSessionId);
        ProblemRecordId = PRId;
        UsrName = UserName;
        ServrUrl = ServerUrl;
        system.debug(':::::UsrName'+UsrName);
        String problemSource;
        String categoy;
        String impact;
        String urgency;
        String description;
        String priority;
        String resolution;
        String status;
        String workaround;
        String rootCauseAnalysis;
        String phase;
        String rcaSource;
        String rcaReasonCode;
        String scrumTeam;
        String fallout;
        String defectID;
        String configurationItem;
        String changeRecord;
        String migratedBy;
        String dependencies;
        String releaseManagerNotes;
        String checkoutBy;
        String checkoutDuration;
        String queue = '';
        String staff;
        String rallyObjectUrl ;
        
        
        BMCServiceDesk__Problem__c PRObj = [select id,Name,BMCServiceDesk__FKCategory__r.Name,BMCServiceDesk__FKStaff__r.Name,FKBMC_BaseElement__r.Name,BMCServiceDesk__FKImpact__r.Name,BMCServiceDesk__FKPriority__r.Name,BMCServiceDesk__FKUrgency__r.Name,
                                            Change_Record__c,RalleyURL__c,RalleyID__c,Checkout_By__c,Checkout_Duration__c,Dependencies__c,BMCServiceDesk__Problem_Description__c,Fallout__c,Migrated_By__c,Owner_Phase__c,BMCServiceDesk__Problem_Source__c,RCA_Reason_Code__c,RCA_Source__c,
                                            Release_Manager_Notes__c,BMCServiceDesk__Problem_Resolution__c,Root_Cause_Analysis__c,Scrum_Team__c,BMCServiceDesk__FKStatus__r.Name,BMCServiceDesk__Work_Around__c from BMCServiceDesk__Problem__c where id=:ProblemRecordId];
        if(PRObj.BMCServiceDesk__FKCategory__r.Name!=null){                                    
        categoy = PRObj.BMCServiceDesk__FKCategory__r.Name;
        }else{
        categoy = '';   
        }
        if(PRObj.FKBMC_BaseElement__r.Name!=null){
        configurationItem = PRObj.FKBMC_BaseElement__r.Name;
        }else{
        configurationItem = ''; 
        }
        if(PRObj.BMCServiceDesk__FKImpact__r.Name!=null){
        impact = PRObj.BMCServiceDesk__FKImpact__r.Name;
        system.debug('impact'+Impact);
        }else{
        impact = '';    
        }
        if(PRObj.BMCServiceDesk__FKPriority__r.Name!=null){
        priority = PRObj.BMCServiceDesk__FKPriority__r.Name;
        }else{
        priority = '';
        }
        if(PRObj.BMCServiceDesk__FKUrgency__r.Name!=null){
        urgency = PRObj.BMCServiceDesk__FKUrgency__r.Name;
        }else{
        urgency = '';   
        }
        if(PRObj.BMCServiceDesk__FKStatus__r.Name!=null){
        status = PRObj.BMCServiceDesk__FKStatus__r.Name;
        }else{
        status = '';    
        }
                                            
        wwwTibcoComSchemasRallyInterfaceSh.pvEsbSecurityInfo EsbObject = new wwwTibcoComSchemasRallyInterfaceSh.pvEsbSecurityInfo();
        EsbObject.clientSystemId = '';
        EsbObject.esbClientId = 'mpisfdc';
        EsbObject.esbClientPassword = 'djb03y76';
        EsbObject.serverUrl = ServrUrl;
        EsbObject.sessionId = userSessionId;
        EsbObject.sourceAppInfo = 'REMEDYFORCE';
        
        
        xmlnsExampleCom1395789827798.prCreatePortTypeEndpoint1 stub = new xmlnsExampleCom1395789827798.prCreatePortTypeEndpoint1();
        stub.endpoint_x = System.Label.CreateUpdatePRTaskEndpoint;
        stub.pvEsbSecurityInfo = EsbObject;
        stub.timeout_x = 120000;  
        
        List<wwwTibcoComSchemasRallyInterfaceSh.linkedIncidents_element> ListIncidents = new List<wwwTibcoComSchemasRallyInterfaceSh.linkedIncidents_element>();
        
        wwwTibcoComSchemasRallyInterfaceSh.linkedIncidents_element Incidents = new wwwTibcoComSchemasRallyInterfaceSh.linkedIncidents_element();
        Incidents.action = '';
        Incidents.category = '';
        Incidents.clientName = '';
        Incidents.incidentNo = '';
        Incidents.incidentProblemLink = '';
        Incidents.incidentProblemLinkName = '';
        Incidents.lastQueue = '';
        Incidents.openedDate = '';
        Incidents.slientID = '';
        Incidents.staff = '';
        Incidents.status = '';
        
        ListIncidents.add(Incidents);
        
        
        wwwTibcoComSchemasRallyInterfaceSh.prUpdate UpdateObj = new wwwTibcoComSchemasRallyInterfaceSh.prUpdate();
        UpdateObj.categoy = categoy;
        if(PRObj.Change_Record__c!=null){
        changerecord =PRObj.Change_Record__c;
        }else{
        changerecord = '';  
        }
        UpdateObj.changeRecord = changerecord;
        if(PRObj.Checkout_By__c!=null){
        checkoutby = PRObj.Checkout_By__c;
        }else{
        checkoutby = '';    
        }
        UpdateObj.checkoutBy = checkoutby;
        if(PRObj.Checkout_Duration__c!=null){
        checkoutduration = PRObj.Checkout_Duration__c;
        }else{
        checkoutduration = '';  
        }
        UpdateObj.checkoutDuration = checkoutduration;
        UpdateObj.configurationItem = configurationItem;
        if(PRObj.RalleyID__c!=null){
            defectID = PRObj.RalleyID__c;
        }else{
            defectID = '';
        }
        UpdateObj.defectID =  defectID;
        if(PRObj.Dependencies__c!=null){
        dependencies = PRObj.Dependencies__c;
        }else{
        dependencies = '';  
        }
        UpdateObj.dependencies =  dependencies;
        if(PRObj.BMCServiceDesk__Problem_Description__c!=null){
        description = PRObj.BMCServiceDesk__Problem_Description__c;
        }else{
        description = '';   
        }
        UpdateObj.description = description;
        if(PRObj.Fallout__c == true){
           fallout = 'true';
           
        }else{
           fallout = 'false';
        }
        UpdateObj.fallout = fallout;
        UpdateObj.impact = impact;
        if(PRObj.Migrated_By__c!=null){
           migratedBy = PRObj.Migrated_By__c;
           
        }else{
           migratedBy = '';
        }
        UpdateObj.migratedBy = migratedBy;
        if(PRObj.Owner_Phase__c!=null){
            phase = PRObj.Owner_Phase__c;
        }else{
            phase = '';
        }
        
        UpdateObj.phase = phase;
        UpdateObj.priority = priority;
        ProblemRecord = PRObj.Name ;
        UpdateObj.problemId = ProblemRecord;
        if(PRObj.BMCServiceDesk__Problem_Source__c!=null){
            problemSource = PRObj.BMCServiceDesk__Problem_Source__c;
        }else{
            problemSource ='';
        }
        
        UpdateObj.problemSource = problemSource;
        rallyObjectUrl = PRObj.RalleyURL__c;
        UpdateObj.rallyObjectUrl = rallyObjectUrl;
        
        UpdateObj.queue = queue; 
        if(PRObj.RCA_Reason_Code__c!=null){
            rcaReasonCode = PRObj.RCA_Reason_Code__c;
        }
        UpdateObj.rcaReasonCode = rcaReasonCode;
        if(PRObj.RCA_Source__c!=null){
           rcaSource = PRObj.RCA_Source__c;
        }
        UpdateObj.rcaSource = rcaSource;
        releaseManagerNotes = PRObj.Release_Manager_Notes__c;
        UpdateObj.releaseManagerNotes = releaseManagerNotes;
        resolution = PRObj.BMCServiceDesk__Problem_Resolution__c;
        UpdateObj.resolution = resolution;
        if(PRObj.Root_Cause_Analysis__c!=null){
            rootCauseAnalysis = PRObj.Root_Cause_Analysis__c;
        }else{
            rootCauseAnalysis = '';
        }
        
        UpdateObj.rootCauseAnalysis = rootCauseAnalysis;
        scrumTeam = PRObj.Scrum_Team__c;
        UpdateObj.scrumTeam = scrumTeam;
        UpdateObj.staff = UsrName;
        system.debug('$$$$$$$$$$UpdateObj.staff'+UpdateObj.staff);
        UpdateObj.status = status;
        UpdateObj.urgency = urgency;
        workaround = PRObj.BMCServiceDesk__Work_Around__c;
        UpdateObj.workaround = workaround;
        UpdateObj.linkedIncidents = ListIncidents;
        
        
        
        wwwTibcoComSchemasRallyInterfaceSh.PRUpdateRes UpdateRespObj = new wwwTibcoComSchemasRallyInterfaceSh.PRUpdateRes();
        UpdateRespObj = stub.prUpdate(ProblemRecord, problemSource, categoy, impact, urgency, description, priority, resolution, status, workaround, rootCauseAnalysis, phase, rcasource, rcaReasonCode, scrumTeam, fallout, configurationItem, changeRecord, migratedBy, dependencies, releaseManagerNotes, checkoutBy, checkoutDuration, queue, UsrName, defectID, ListIncidents, rallyObjectUrl);
        
        
        system.debug('UpdateRespObj'+UpdateRespObj);
        
        
                                       
                                            
    }
    

}