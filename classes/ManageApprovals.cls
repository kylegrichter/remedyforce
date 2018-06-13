public class ManageApprovals {
    public Id approvalWorkItem {get;set;}
    
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

    public List<BMCServiceDesk__Incident__c> getincidentspending(){
        Id currentUser = UserInfo.getUserId();
        
        Map<String, Schema.SObjectField> fldObjMap = schema.SObjectType.BMCServiceDesk__Incident__c .fields.getMap();
        List<Schema.SObjectField> fldObjMapValues = fldObjMap.values();
        String theQuery = 'SELECT ';
        for(Schema.SObjectField s : fldObjMapValues){theQuery += s.getDescribe().getName() + ',';}
        theQuery = theQuery.left(theQuery.length()-1);
        theQuery += ' ,Owner.Name,BMCServiceDesk__FKOpenBy__r.Name FROM BMCServiceDesk__Incident__c';
        theQuery += ' WHERE Id IN (';
        String testOutput = 'z';
        for (ProcessInstanceWorkitem piwi : [SELECT ProcessInstance.TargetObjectId FROM ProcessInstanceWorkitem WHERE ActorId = :currentUser]){
            theQuery += '\'' + piwi.ProcessInstance.TargetObjectId + '\',';
            testOutput += piwi.ProcessInstance.TargetObjectId;
            system.debug('testOutput: '+testOutput);
        }
        List<BMCServiceDesk__Incident__c> incidentspending;
        if ( testOutput.length() > 1 ){
            theQuery = theQuery.left(theQuery.length()-1);
            theQuery += ') ORDER BY BMCServiceDesk__openDateTime__c';
            incidentspending = Database.query(theQuery);
            for (BMCServiceDesk__Incident__c a : incidentspending){
                a.BMCServiceDesk__BLANK__c = [SELECT Id FROM ProcessInstanceWorkitem WHERE ProcessInstance.TargetObjectId = :a.Id and ActorId = :currentUser].Id;
            }
        }
        return incidentspending;
    }
    
    public List<BMCServiceDesk__Task__c> gettaskspending(){
        Id currentUser = UserInfo.getUserId();
        
        Map<String, Schema.SObjectField> fldObjMap = schema.SObjectType.BMCServiceDesk__Task__c .fields.getMap();
        List<Schema.SObjectField> fldObjMapValues = fldObjMap.values();
        String theQuery = 'SELECT ';
        for(Schema.SObjectField s : fldObjMapValues){theQuery += s.getDescribe().getName() + ',';}
        theQuery = theQuery.left(theQuery.length()-1);
        theQuery += ' ,Owner.Name,BMCServiceDesk__FKOpenBy__r.Name FROM BMCServiceDesk__Task__c';
        theQuery += ' WHERE Id IN (';
        String testOutput = 'z';
        for (ProcessInstanceWorkitem piwi : [SELECT ProcessInstance.TargetObjectId FROM ProcessInstanceWorkitem WHERE ActorId = :currentUser]){
            theQuery += '\'' + piwi.ProcessInstance.TargetObjectId + '\',';
            testOutput += piwi.ProcessInstance.TargetObjectId;
            system.debug('testOutput: '+testOutput);
        }
        List<BMCServiceDesk__Task__c> taskspending;
        if ( testOutput.length() > 1 ){
            theQuery = theQuery.left(theQuery.length()-1);
            theQuery += ') ORDER BY BMCServiceDesk__openDateTime__c';
            taskspending = Database.query(theQuery);
            for (BMCServiceDesk__Task__c a : taskspending){
                a.BMCServiceDesk__BLANK__c = [SELECT Id FROM ProcessInstanceWorkitem WHERE ProcessInstance.TargetObjectId = :a.Id and ActorId = :currentUser].Id;
            }
        }
        return taskspending;
    }
    
    public void ApproveChange(){
        Id currentUser = UserInfo.getUserId();
        System.debug('Debug: My Approval Item is:' + approvalWorkItem);
        System.debug('Debug: My Actor Id is:' + currentUser);
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
}