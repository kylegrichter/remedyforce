global class QueueExtAttrMonitor implements Schedulable {
    global void execute(SchedulableContext SC) {
        sendEmail();
    }
    public void sendEmail() {
        Map<String, Schema.SObjectField> fldObjMap = schema.SObjectType.Group .fields.getMap();
        List<Schema.SObjectField> fldObjMapValues = fldObjMap.values();
        String theQuery = 'SELECT ';
        for(Schema.SObjectField s : fldObjMapValues){theQuery += s.getDescribe().getName() + ',';}
        theQuery = theQuery.left(theQuery.length()-1);
        theQuery += ' FROM Group WHERE Type = \'Queue\'';
        theQuery += ' AND DeveloperName NOT IN (';
        for (Queue_Extended_Attributes__c qea : [SELECT Queue_Name__c FROM Queue_Extended_Attributes__c ORDER BY Queue_Name__c]){
            theQuery += '\'' + qea.Queue_Name__c + '\',';
        }
        theQuery = theQuery.left(theQuery.length()-1);
        theQuery += ') ORDER BY DeveloperName';
        List<Group> assocrecord = Database.query(theQuery);
        if (assocrecord.size() > 0){
            String missing = '';
            for (Group a: assocrecord){
                missing += a.Name + '(' + a.DeveloperName + '), ';
            }
            missing = missing.left(missing.length()-2);            
            OrgWideEmailAddress[] owea = [select Id from OrgWideEmailAddress where DisplayName = 'RemedyForceTeam'];            
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            mail.setPlainTextBody(
                'The following queues do not have corresponding attribute record(s).\n'
                +missing);
            mail.setSubject('QEA Monitor: RemedyForce Queues Missing Extended Attributes');
            mail.setToAddresses(new String[] {'DL-ITRemedyForce@dexmedia.com'});
            mail.setOrgWideEmailAddressId(owea.get(0).Id);
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail },false);
        }
    }
}