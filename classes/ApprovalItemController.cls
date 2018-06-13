public with sharing class ApprovalItemController {
    public String relatedRecordId {get;set;}
    //===========================================================//
    //Main method called by the controller
    //==========================================================//
    public List<ApprovalStep> getAllApprovalStep() {
        List<ApprovalStep> lstApprovalStep = new List<ApprovalStep>();
        List<ProcessInstance> processInstance = getProcessInstance();
        
        for(ProcessInstance processInstanceRow : processInstance){
            
            Map<Id,ProcessNode> mpProcessNode = getProcessNode(processInstanceRow);
            if(processInstanceRow == null) return lstApprovalStep;
            for(ProcessInstanceStep stepInstance : processInstanceRow.Steps){
                ApprovalStep approvalStep = new ApprovalStep(stepInstance,mpProcessNode.get(stepInstance.StepNodeID));
                lstApprovalStep.add(approvalStep);
            }
            
        }
        
        
        return lstApprovalStep;
    }
    //=====================================================================
    //get All Process Nodes attached to Process Instance
    //==================================================================//
    public Map<Id,ProcessNode> getProcessNode(ProcessInstance processInstance){
        if(processInstance == null) return null;
        return new Map<Id,ProcessNode>([SELECT Id,Name FROM ProcessNode
                                        WHERE ProcessDefinitionId = :processInstance.ProcessDefinitionId]);
    }
    //======================================================================
    //Get the Process Instance Attached to the Record    
    //======================================================================
    private List<ProcessInstance> getProcessInstance(){
        List<ProcessInstance> lstProcessInstance = [SELECT Id, ProcessDefinitionID,
                                                    (Select StepStatus,StepNodeId, OriginalActor.Name,ActorId, Actor.Name, Comments,
                                                     CreatedDate, CreatedById,CreatedBy.Name FROM Steps WHERE StepStatus != 'NoResponse' ORDER BY CreatedDate ASC)
                                                    FROM ProcessInstance
                                                    WHERE TargetObjectId = :relatedRecordId];
        if(lstProcessInstance.size() == 0) {
            return null;
        }
        return lstProcessInstance;
    }
    //======================================================================
    //Inner Class : Approval Process Step that holds the Step Notes and Approver Comments and Details
    //===================================================================//
    public class ApprovalStep {
        public ProcessInstanceStep instanceStep {get;set;}
        public ProcessNode nodeStep {get;set;}
        public ApprovalStep(ProcessInstanceStep instanceStep,ProcessNode node){
            this.instanceStep = instanceStep;
            this.nodeStep = node;
        }
    }
}