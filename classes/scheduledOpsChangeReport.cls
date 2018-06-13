global class scheduledOpsChangeReport implements Schedulable {
    global void execute(SchedulableContext SC) {
        sendmail();
    }
    public void sendmail() {
        Id templateId = [select Id from EmailTemplate where name = 'Change Report: Daily'].id;
        Id contactId = [select Id from Contact where name = 'DL-IT Operations'].id;
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setTargetObjectId(contactId);
        mail.setTemplateId(templateId);
        mail.saveAsActivity = false;
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail },false);
    }
}