global class EmailToRecallApproval implements Messaging.InboundEmailHandler {
    global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email, Messaging.InboundEnvelope envelope) {
        Messaging.InboundEmailResult result = new Messaging.InboundEmailresult();

        String recordId = email.subject;
        String comments = email.plainTextBody;
        
        Id approvalWorkItemId = [SELECT Id FROM ProcessInstanceWorkitem WHERE ProcessInstance.TargetObjectId = :recordId limit 1].Id;
        if (!String.isBlank(approvalWorkItemId)){
            Approval.ProcessWorkitemRequest pwr = new Approval.ProcessWorkitemRequest();
            pwr.setAction('Removed');
            pwr.setWorkItemId(approvalWorkItemId);
            pwr.setComments(comments);
            Approval.ProcessResult resultapproval = Approval.process(pwr);
        }
                
        System.debug('====> Recalled Approval for '+recordId);
        return result;
    }
}