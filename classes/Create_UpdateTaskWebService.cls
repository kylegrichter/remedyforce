/******************************************************************************
Name:  Create_UpdateTaskWebService
Copyright © 2014  DexMedia Inc. 
==============================================================================
Purpose:                                                            
 Creates and Updates Task info from Ralley
==============================================================================
History                                                            
-------                                                            
VERSION     AUTHOR              DATE           DETAIL           FEATURES/CSR/TTP
------      ------              -----         ---------         -----------------
1.0       Guru Vattam          06/04/2014     Initial Development      
*****************************************************************************/

global class Create_UpdateTaskWebService{
  
  
  /******************************************************************************  
 This method is to Create Task through webservice in Remedy
 *****************************************************************************/
  global class CreateTask {
    webservice string OwnerId;
    webservice string Category;
    webservice string Impact;
    webservice string Urgency;
    webservice string UserId;
    webservice string Description;
    webservice boolean IsActive;
    webservice string ConfigurationItem;
    webservice string Status;
    webservice string Release;
    webservice string RallyURL;
    webservice string USNumber;
    
  }
  
  WebService static String CreateTaskinRmdy(CreateTask InsertNewTask) {
    InsertNewTask.UserId = InsertNewTask.UserId.trim();
    BMCServiceDesk__Task__c TaskObj = new BMCServiceDesk__Task__c();
    TaskObj.BMCServiceDesk__taskDescription__c = InsertNewTask.Description.trim();
    TaskObj.BMCServiceDesk__inactive__c = InsertNewTask.IsActive;
        
        
        
        
        /***********User Story**********/
        TaskObj.User_Story__c = InsertNewTask.USNumber!=null?InsertNewTask.USNumber:'';
        /*if(InsertNewTask.USNumber!=null){
        TaskObj.User_Story__c= InsertNewTask.USNumber;
        }else{
        TaskObj.User_Story__c = ''; 
        }*/
        
        
        
        /***********Rally URL**********/
        TaskObj.Rally_URL__c = InsertNewTask.RallyURL!=null?InsertNewTask.RallyURL:'';
        /*if(InsertNewTask.RallyURL!=null){
        TaskObj.Rally_URL__c= InsertNewTask.RallyURL;
        }else{
        TaskObj.Rally_URL__c = '';  
        }*/
        
        
        
        /***********Staff**********/
        if(InsertNewTask.OwnerId!=null){
        Group QueueId = database.query('SELECT Id FROM Group WHERE Type = \'Queue\' AND Name = \''+InsertNewTask.OwnerId.trim()+'\' LIMIT 1 ');      
        system.debug('QueueId.Id --------'+QueueId.Id);
        TaskObj.OwnerId = QueueId.Id; 
        }else{
        TaskObj.OwnerId = '';   
        }
        
        /***********ClientId**********/
        User usrclk = database.query('select id,Name from User where Name like \'%'+InsertNewTask.UserId+'%\' limit 1');
        TaskObj.BMCServiceDesk__FKClient__c = usrclk.Id;
        
        
        /**********Category*******/
        BMCServiceDesk__Category__c cat = database.query('select id from BMCServiceDesk__Category__c where Name=\''+InsertNewTask.Category.trim()+'\' limit 1');
        TaskObj.BMCServiceDesk__FKCategory__c = cat.Id; 
        
        
        /**********Release*******/
        if(InsertNewTask.Release!=null && InsertNewTask.Release!=''){ 
        BMCServiceDesk__Release__c ReleaseObj = database.query('select id from BMCServiceDesk__Release__c where   Name=\''+InsertNewTask.Release.trim()+'\' limit 1');
        TaskObj.BMCServiceDesk__FKRelease__c = ReleaseObj.Id; 
        }else{
        TaskObj.BMCServiceDesk__FKRelease__c = null;   
        } 
        
        
        
        
        
        /**********Impact*******/
        if(InsertNewTask.Impact!=null){ 
        BMCServiceDesk__Impact__c imp = database.query('select id from BMCServiceDesk__Impact__c where   Name=\''+InsertNewTask.Impact.trim()+'\' limit 1');
        TaskObj.BMCServiceDesk__FKImpact__c = imp.Id; 
        }else{
        TaskObj.BMCServiceDesk__FKImpact__c = '';   
        } 
        
        /**********Status*******/
        
        if(InsertNewTask.Status!=null){ 
        BMCServiceDesk__Status__c statusObj = database.query('select id from BMCServiceDesk__Status__c where   Name=\''+InsertNewTask.Status.trim()+'\' limit 1');
        TaskObj.BMCServiceDesk__FKStatus__c = statusObj.Id; 
        }else{
        TaskObj.BMCServiceDesk__FKStatus__c = '';   
        }
        
                
        /**********Urgency*******/
        if(InsertNewTask.Urgency!=null){
        BMCServiceDesk__Urgency__c ugr = database.query('select id from BMCServiceDesk__Urgency__c where Name=\''+InsertNewTask.Urgency.trim()+'\' limit 1');
        TaskObj.BMCServiceDesk__FKUrgency__c = ugr.Id;
        }else{
        TaskObj.BMCServiceDesk__FKUrgency__c = '';  
        }
         
        /**********Configuration Item*******/
        if(InsertNewTask.ConfigurationItem!=null){
        BMCServiceDesk__BMC_BaseElement__c CI = database.query( 'SELECT Id FROM BMCServiceDesk__BMC_BaseElement__c where Name=\''+InsertNewTask.ConfigurationItem.trim()+'\' limit 1');
        TaskObj.Configuration_Item__c = CI.Id;  
        }else{
        TaskObj.Configuration_Item__c = ''; 
        }
         
        insert TaskObj;
         
         
        /**********Return Task Number Through Service*******/
        BMCServiceDesk__Task__c TaskObject = [select Id,Name from BMCServiceDesk__Task__c where id=:TaskObj.Id];
        return string.valueof(TaskObject.Name);
    
    
  }
  
  
  
  /******************************************************************************  
 This method is to Update Task info through webservice
 *****************************************************************************/
    global class UpdateTaskInfo {
          webservice string TskNumber;
          webservice string Category;
          webservice string impact;
          webservice string urgency;
          webservice string description;
          webservice string resolution;
          webservice string status;
          webservice Boolean inactive;
          webservice string configurationItem;
          webservice string Staff;
          webservice string Queue;
          webservice String USNumber;
          webservice String Release;
          webservice String RalleyURL;
          
     }
    WebService static String UpdateTask(UpdateTaskInfo UpdateTask) {
            String TaskImpact ;
            String TaskUrgency ;
            String Taskstatus ; 
            String TaskUSNumber ;
            String TaskRelease ;
            String strReturn = '';
            String TaskNumber = UpdateTask.TskNumber.trim();
            String TaskCategory = UpdateTask.Category.trim();
            if(UpdateTask.Release!=null){
            TaskRelease = UpdateTask.Release.trim();
            }else{
            TaskRelease = '';    
            }
            if(UpdateTask.impact!=null){
            TaskImpact = UpdateTask.impact.trim();
            }else{
            TaskImpact = '';    
            }
            if(UpdateTask.urgency!=null){
            TaskUrgency = UpdateTask.urgency.trim();
            }else{
            TaskUrgency ='';    
            }
            String TaskDescription = UpdateTask.description.trim();
            String TaskResolution = UpdateTask.resolution.trim();
            if(UpdateTask.status!=null){
            Taskstatus = UpdateTask.status.trim();
            }else{
            Taskstatus ='';     
            }
            Boolean Taskinactive = UpdateTask.inactive;
            String TaskconfigurationItem = UpdateTask.configurationItem.trim();
            string TaskStaff = UpdateTask.Staff.trim();
            string TaskQueue = UpdateTask.Queue.trim();
            if(UpdateTask.USNumber!=null){
            TaskUSNumber = UpdateTask.USNumber.trim();
            }else{
            TaskUSNumber ='';   
            }
            String TaskRalleyURL = UpdateTask.RalleyURL.trim();
            
            
            BMCServiceDesk__Task__c TaskObj = [select Id,Name,OwnerId,BMCServiceDesk__FKCategory__c,BMCServiceDesk__FKImpact__c,BMCServiceDesk__FKUrgency__c,BMCServiceDesk__taskDescription__c,
                                               BMCServiceDesk__taskResolution__c,BMCServiceDesk__FKRelease__c,BMCServiceDesk__FKStatus__c,BMCServiceDesk__inactive__c,
                                               Configuration_Item__c,BMCServiceDesk__FKClient__c,User_Story__c,
                                               Rally_URL__c from BMCServiceDesk__Task__c where Name=: TaskNumber];
                                               
          if(TaskObj != null ){
                TaskObj.BMCServiceDesk__taskDescription__c = TaskDescription;
                TaskObj.BMCServiceDesk__taskResolution__c = TaskObj.BMCServiceDesk__taskResolution__c +''+ TaskResolution;
                TaskObj.BMCServiceDesk__inactive__c = Taskinactive;
                TaskObj.User_Story__c = TaskUSNumber;
                TaskObj.Rally_URL__c = TaskRalleyURL;
                TaskObj.BMCServiceDesk__FKCategory__c = [Select id from BMCServiceDesk__Category__c where Name=:TaskCategory limit 1].id;
                TaskObj.BMCServiceDesk__FKImpact__c = [Select id from BMCServiceDesk__Impact__c where Name=:TaskImpact limit 1].id;
                TaskObj.BMCServiceDesk__FKUrgency__c = [select id from BMCServiceDesk__Urgency__c where Name=:TaskUrgency limit 1].id; 
                TaskObj.BMCServiceDesk__FKStatus__c = [select id from BMCServiceDesk__Status__c where  Name=:Taskstatus limit 1].id;
                TaskObj.Configuration_Item__c = [Select id from BMCServiceDesk__BMC_BaseElement__c where Name=:TaskconfigurationItem limit 1].id;
                if (!Test.isRunningTest())
                 {
                if(TaskRelease!=null && TaskRelease!=''){
                TaskObj.BMCServiceDesk__FKRelease__c = [select id from BMCServiceDesk__Release__c where Name=:TaskRelease limit 1].id;
                }
                TaskObj.BMCServiceDesk__FKClient__c = [select id from User where Name like : + '%' + TaskStaff +'%'limit 1].id;
                TaskObj.OwnerId = [SELECT Id FROM Group WHERE Type = 'Queue' AND Name =:TaskQueue limit 1].id;
                 }
            }
            try{
                Database.Saveresult sr=Database.Update(TaskObj);
                if(sr.isSuccess()) {
                strReturn ='PR has been updated sucessfully';      
                }
                return strReturn;
              }
            catch(Exception e){
               return String.ValueOf(e.getMessage());
             }   
            
    } 
     
}