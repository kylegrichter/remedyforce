global class scheduledDailyChangeReport implements Schedulable {
    global void execute(SchedulableContext SC) {
        sendmail();
    }
    public void sendmail() {
        Id templateId = [select Id from EmailTemplate where name = 'Change Report: Daily'].id;
        Id contactId = [select Id from Contact where name = 'DL-IT Change Mgmt LT'].id;
        List<String> email = new List<String>();
        for (Contact c : [SELECT Email FROM Contact where Account.Name = 'Daily Change Email']){
            email.add(c.email);
        }
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setTargetObjectId(contactId);
        mail.setTemplateId(templateId);
        mail.saveAsActivity = false;
        mail.setCcAddresses( email );
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail },false);
    }
}