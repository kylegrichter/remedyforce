global class EmailToSystemApproval implements Messaging.InboundEmailHandler {
    
    global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail inbound, Messaging.InboundEnvelope envelope) {
        
        Messaging.InboundEmailResult result = new Messaging.InboundEmailresult();
        String subject = inbound.subject;
        String[] replyTo = New String[]{inbound.replyTo};
        
        Messaging.SingleEmailMessage outbound = new Messaging.SingleEmailMessage();
        outbound.setToAddresses(replyTo);
        outbound.setSubject(subject);
        outbound.setPlainTextBody('Approved \n' + inbound.plainTextBody);
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { outbound },false);
        
        return result;        
    }
    
}