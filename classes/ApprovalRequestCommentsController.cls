/**
 * As of Winter '14 release, email templates used with approval processes can
 * include {!ApprovalRequest.field_name} merge fields.
 * For example, {!ApprovalRequest.Comments} merge field returns the most recently
 * entered comment in emails for an approval step.
 * 
 * However, the merge fields do not work in visualforce email templates.
 * Thankfully, Pradeep on Developer Forums came up with a solution to use
 * a visualforce component in the template backed by controller that queries
 * the approval step information.
 * 
 * This class represents the controller in this workaround solution.
 * Also see ApprovalRequestComments visualforce component.
 * 
 * Inspired by https://developer.salesforce.com/forums/ForumsMain?id=906F00000008xjUIAQ 
 * 
 * http://docs.releasenotes.salesforce.com/en-us/winter14/release-notes/rn_186_forcecom_process_approval_comment_merge_fields.htm
 */
public class ApprovalRequestCommentsController {
 
    // ID of the record whose most recent approval process comments to retrieve
    public ID targetObjectId { get; set; }
    
    // The most recent approval process comments
    // Could show in visualforce email template, for example
    public String comments {
        get {
            if ( comments == null ) {
            	ProcessInstanceStep lastStep = getLastApprovalStep();
            	comments = ( lastStep != null ) ? lastStep.Comments : '';
            }
            return comments;
        }
        private set;
    }
    
    public String stepstatus {
        get {
            if ( stepstatus == null ) {
            	ProcessInstanceStep lastStep = getLastApprovalStep();
            	stepstatus = ( lastStep != null ) ? lastStep.StepStatus : '';
            }
            return stepstatus;
        }
        private set;
    }
    
    public Id actorid {
        get {
            if ( actorid == null ) {
            	ProcessInstanceStep lastStep = getLastApprovalStep();
            	actorid = ( lastStep != null ) ? lastStep.ActorId : null;
            }
            return actorid;
        }
        private set;
    }
    
    public String actorname {
        get {
            if ( actorname == null ) {
            	ProcessInstanceStep lastStep = getLastApprovalStep();
            	actorname = ( lastStep != null ) ? lastStep.actor.name : null;
            }
            return actorname;
        }
        private set;
    }
    
    public String actorphone {
        get {
            if ( actorphone == null ) {
            	ProcessInstanceStep lastStep = getLastApprovalStep();
            	actorphone = ( lastStep != null ) ? lastStep.actor.phone : null;
            }
            return actorphone;
        }
        private set;
    }
    
    public Id originalactorid {
        get {
            if ( originalactorid == null ) {
            	ProcessInstanceStep lastStep = getLastApprovalStep();
            	originalactorid = ( lastStep != null ) ? lastStep.OriginalActorId : null;
            }
            return originalactorid;
        }
        private set;
    }
    
    public String originalactorname {
        get {
            if ( originalactorname == null ) {
            	ProcessInstanceStep lastStep = getLastApprovalStep();
            	originalactorname = ( lastStep != null ) ? lastStep.originalactor.name : null;
            }
            return originalactorname;
        }
        private set;
    }
    
    public String originalactorphone {
        get {
            if ( originalactorphone == null ) {
            	ProcessInstanceStep lastStep = getLastApprovalStep();
            	originalactorphone = ( lastStep != null ) ? lastStep.originalactor.phone : null;
            }
            return originalactorphone;
        }
        private set;
    }
    
    public Id processinstanceid {
        get {
            if ( processinstanceid == null ) {
            	ProcessInstanceStep lastStep = getLastApprovalStep();
            	processinstanceid = ( lastStep != null ) ? lastStep.ProcessInstanceId : null;
            }
            return processinstanceid;
        }
        private set;
    }
    
    public Id stepnodeid {
        get {
            if ( stepnodeid == null ) {
            	ProcessInstanceStep lastStep = getLastApprovalStep();
            	stepnodeid = ( lastStep != null ) ? lastStep.StepNodeId : null;
            }
            return stepnodeid;
        }
        private set;
    }
    
    public ApprovalRequestCommentsController() {}
    
    // Queries the most recent approval process step for the target record
    private ProcessInstanceStep getLastApprovalStep() {
        List<ProcessInstanceStep> steps = new List<ProcessInstanceStep>([
            SELECT
            	ActorId,Actor.Name,Actor.Phone,Comments,OriginalActor.Name,OriginalActor.Phone,OriginalActorId,ProcessInstanceId,StepNodeId,StepStatus
            FROM
            	ProcessInstanceStep
            WHERE
            	ProcessInstance.TargetObjectId = :targetObjectId
            ORDER BY
            	SystemModStamp DESC
            LIMIT
            	1
        ]);
        return ( steps.size() > 0 ) ? steps[0] : null;
    }
    
}