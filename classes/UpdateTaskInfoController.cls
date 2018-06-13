/******************************************************************************
Name:  UpdateTaskInfoController
Copyright © 2014  DexMedia Inc. 
==============================================================================
Purpose:                                                            
This class to update the Task Info when updated in Remedy
==============================================================================
History                                                            
-------                                                            
VERSION     AUTHOR              DATE           DETAIL           FEATURES/CSR/TTP
------      ------              -----         ---------         -----------------
1.0       Guru Vattam         06/04/2014     Initial Development           
*****************************************************************************/
public with sharing class UpdateTaskInfoController {
     @future(callout =true)
    public static void UpdateTaskInfo(id TaskId,String sessionId,String ServerUrl){
        Id TaskRecID;
        String ServrUrl;
        String userSessionId;
        userSessionId = sessionId;
        ServrUrl = ServerUrl;
        TaskRecID = TaskId;
        String TaskNumber;
        String ProblemSource;
        String Category;
        String Impact;
        String Urgency;
        String Description;
        String Priority;
        String Resolution;
        String Status;
        String Inactive;
        String ConfigurationItem;
        String IncidentId;
        String ChangeRecord;
        String Release;
        String Queue;
        String Staff;
        String USId;
        String DefectID;
        String RallyObjectUrl;
        String hasWarningOrError;
        
        BMCServiceDesk__Task__c TaskObj = [select Id,Name,BMCServiceDesk__FKCategory__r.Name,BMCServiceDesk__FKImpact__r.Name,BMCServiceDesk__FKUrgency__r.Name,BMCServiceDesk__taskDescription__c,
                                           BMCServiceDesk__FKPriority__r.Name,BMCServiceDesk__taskResolution__c,BMCServiceDesk__FKStatus__r.Name,BMCServiceDesk__FKClosedBy__r.Name,BMCServiceDesk__inactive__c,
                                           Configuration_Item__r.Name,BMCServiceDesk__FKIncident__r.Name,BMCServiceDesk__FKChange__r.Name,BMCServiceDesk__FKRelease__r.Name,BMCServiceDesk__FKOpenBy__r.Name,User_Story__c,
                                           BMCServiceDesk__FKProblem__r.Name,Rally_URL__c from BMCServiceDesk__Task__c where id=:TaskRecID] ;
                                               
        //if(TaskObj.BMCServiceDesk__FKCategory__r.Name!=null){
        //    Category = TaskObj.BMCServiceDesk__FKCategory__r.Name;
        //} else{
        //    Category = '';
        //}
        Category = TaskObj.BMCServiceDesk__FKCategory__r.Name!=null?TaskObj.BMCServiceDesk__FKCategory__r.Name:'';
        
        //if(TaskObj.BMCServiceDesk__FKImpact__r.Name!=null){
        //    Impact = TaskObj.BMCServiceDesk__FKImpact__r.Name;
        //} else{
        //    Impact = '';
        //}
        Impact = TaskObj.BMCServiceDesk__FKImpact__r.Name!=null?TaskObj.BMCServiceDesk__FKImpact__r.Name:'';
        //if(TaskObj.BMCServiceDesk__FKUrgency__r.Name!=null){
        //    Urgency = TaskObj.BMCServiceDesk__FKUrgency__r.Name;
        //} else{
        //    Urgency = '';
        //}
        Urgency = TaskObj.BMCServiceDesk__FKUrgency__r.Name!=null?TaskObj.BMCServiceDesk__FKUrgency__r.Name:'';
        
        //if(TaskObj.BMCServiceDesk__FKPriority__r.Name!=null){
        //    Priority = TaskObj.BMCServiceDesk__FKPriority__r.Name;
        //} else{
        //    Priority = '';
        //}
        Priority = TaskObj.BMCServiceDesk__FKPriority__r.Name!=null?TaskObj.BMCServiceDesk__FKPriority__r.Name:'';
        
        //if(TaskObj.BMCServiceDesk__FKStatus__r.Name!=null){
        //    Status = TaskObj.BMCServiceDesk__FKStatus__r.Name;
        //} else{
        //    Status = '';
        //}
        Status = TaskObj.BMCServiceDesk__FKStatus__r.Name!=null?TaskObj.BMCServiceDesk__FKStatus__r.Name:'';
        
        //if(TaskObj.Configuration_Item__r.Name!=null){
        //    ConfigurationItem = TaskObj.Configuration_Item__r.Name;
        //} else{
        //    ConfigurationItem = '';
        //}
        ConfigurationItem = TaskObj.Configuration_Item__r.Name!=null?TaskObj.Configuration_Item__r.Name:'';
        
        //if(TaskObj.BMCServiceDesk__FKIncident__r.Name!=null){
        //    IncidentId = TaskObj.BMCServiceDesk__FKIncident__r.Name;
        //} else{
        //    IncidentId = '';
        //}
        IncidentId = TaskObj.BMCServiceDesk__FKIncident__r.Name!=null?TaskObj.BMCServiceDesk__FKIncident__r.Name:'';
        
        //if(TaskObj.BMCServiceDesk__FKChange__r.Name!=null){
        //    ChangeRecord = TaskObj.BMCServiceDesk__FKChange__r.Name;
        //} else{
        //    ChangeRecord = '';
        //}  
        ChangeRecord = TaskObj.BMCServiceDesk__FKChange__r.Name!=null?TaskObj.BMCServiceDesk__FKChange__r.Name:'';
        
        //if(TaskObj.BMCServiceDesk__FKRelease__r.Name!=null){
        //    Release = TaskObj.BMCServiceDesk__FKRelease__r.Name;
        //} else{
        //    Release = '';
        //} 
        Release = TaskObj.BMCServiceDesk__FKRelease__r.Name!=null?TaskObj.BMCServiceDesk__FKRelease__r.Name:'';
        
        //if(TaskObj.BMCServiceDesk__FKOpenBy__r.Name!=null){
        //    Staff = TaskObj.BMCServiceDesk__FKOpenBy__r.Name;
        //} else{
        //    Staff = '';
        //}
        Staff = TaskObj.BMCServiceDesk__FKOpenBy__r.Name!=null?TaskObj.BMCServiceDesk__FKOpenBy__r.Name:'';
         
        RallyObjectUrl =  TaskObj.Rally_URL__c;
        TaskNumber = TaskObj.Name;
        
        //if(TaskObj.BMCServiceDesk__taskDescription__c!=null){
        //    Description = TaskObj.BMCServiceDesk__taskDescription__c;
        //} else{
        //    Description = '';
        //}
        Description = TaskObj.BMCServiceDesk__taskDescription__c!=null?TaskObj.BMCServiceDesk__taskDescription__c:'';
        
        //if(TaskObj.BMCServiceDesk__taskResolution__c!=null){
        //    Resolution = TaskObj.BMCServiceDesk__taskResolution__c;
        //} else{
        //    Resolution = '';
        //}
        Resolution = TaskObj.BMCServiceDesk__taskResolution__c!=null?TaskObj.BMCServiceDesk__taskResolution__c:'';
        
        //if(TaskObj.BMCServiceDesk__inactive__c==true){
        //    Inactive = 'true';
        //} else{
        //    Inactive = 'false';
        //}
        Inactive = TaskObj.BMCServiceDesk__inactive__c==true?'true':'false';
        
        //if(TaskObj.User_Story__c!=null){
        //    USId = TaskObj.User_Story__c;
        //} else{
        //    USId = '';
        //}
        USId = TaskObj.User_Story__c!=null?TaskObj.User_Story__c:'';
        
        
        
        wwwTibcoComSchemasRallyInterfaceSh.pvEsbSecurityInfo EsbObject = new wwwTibcoComSchemasRallyInterfaceSh.pvEsbSecurityInfo();
        EsbObject.clientSystemId = '';
        EsbObject.esbClientId = 'mpisfdc';
        EsbObject.esbClientPassword = 'djb03y76';
        EsbObject.serverUrl = ServrUrl;
        EsbObject.sessionId = userSessionId;
        EsbObject.sourceAppInfo = 'REMEDYFORCE';
        
        
        wwwTibcoComSchemasRallyInterfaceSh.esbFault TaskEsbFault = new wwwTibcoComSchemasRallyInterfaceSh.esbFault();
        
        List<wwwTibcoComSchemasRallyInterfaceSh.esbFault> TaskEsbFaultList = new List<wwwTibcoComSchemasRallyInterfaceSh.esbFault>();
        
        xmlnsExampleCom1395789827798.prCreatePortTypeEndpoint1 stub = new xmlnsExampleCom1395789827798.prCreatePortTypeEndpoint1();
        stub.endpoint_x = System.Label.CreateUpdatePRTaskEndpoint;
        stub.pvEsbSecurityInfo = EsbObject;
        stub.timeout_x = 60000;
        
        
        wwwTibcoComSchemasRallyInterfaceSh.updateTaskreq ReqObj = new wwwTibcoComSchemasRallyInterfaceSh.updateTaskreq();
        ReqObj.categoy = Category;
        ReqObj.changeRecord = ChangeRecord;
        ReqObj.configurationItem = ConfigurationItem;
        ReqObj.description = Description;
        ReqObj.impact =Impact;
        ReqObj.inactive = Inactive;
        ReqObj.incidentId = IncidentId;
        ReqObj.priority = Priority;
        ReqObj.problemSource = ProblemSource;
        ReqObj.queue = Queue;
        ReqObj.rallyId = USId;
        ReqObj.rallyObjectUrl = RallyObjectUrl;
        ReqObj.release = Release;
        ReqObj.resolution = Resolution;
        ReqObj.staff = Staff;
        ReqObj.status = Status;
        ReqObj.taskId = TaskNumber;
        ReqObj.urgency = Urgency;
        
        wwwTibcoComSchemasRallyInterfaceSh.PRUpdateRes RespObj = new wwwTibcoComSchemasRallyInterfaceSh.PRUpdateRes();
        if(!Test.isRunningTest()) {
        RespObj = stub.taskUpdate(TaskNumber, ProblemSource, Category, Impact, Urgency, Description, Priority, Resolution, Status, Inactive, ConfigurationItem, IncidentId, ChangeRecord, Release, Queue, Staff, USId, RallyObjectUrl);
        } else {
            RespObj= new wwwTibcoComSchemasRallyInterfaceSh.PRUpdateRes();
        }
        system.debug('respObj'+RespObj);
        
        
        if(RespObj!=null){
            if(respObj.hasWarningOrError!=null){
                hasWarningOrError = respObj.hasWarningOrError;
                 if(hasWarningOrError== 'true'){
                  List<BMCServiceDesk__Task__c> TaskRecordObj = new List<BMCServiceDesk__Task__c>();
                    TaskRecordObj = [select id,User_Story__c,Rally_URL__c from BMCServiceDesk__Task__c where id=:TaskRecID];
                    for(BMCServiceDesk__Task__c  UpdateTskObj: TaskRecordObj){
                        UpdateTskObj.User_Story__c = RespObj.rallyId ;
                        UpdateTskObj.Rally_URL__c = RespObj.rallyObjectUrl ;
                        database.update(UpdateTskObj);
                    }
                 }
             }    
        }
                                         
    }

}