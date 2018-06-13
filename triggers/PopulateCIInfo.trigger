trigger PopulateCIInfo on BMCServiceDesk__Task__c (before update) {
    System.Debug('START PopulateCIInfo');
    for (BMCServiceDesk__Task__c TK : Trigger.new){
        String TemplateName;
        if(String.isNotBlank(TK.BMCServiceDesk__FKTemplate__c)){
            TemplateName = [select name from BMCServiceDesk__SYSTemplate__c where id = :TK.BMCServiceDesk__FKTemplate__c].name;
            System.Debug('TK.BMCServiceDesk__FKTemplate__c: '+TK.BMCServiceDesk__FKTemplate__c);
            System.Debug('TemplateName: '+TemplateName);
            System.Debug('TK.BMCServiceDesk__FKTemplate__r.Name: '+TK.BMCServiceDesk__FKTemplate__r.Name);
            System.Debug('TK.Configuration_Item__c:'+TK.Configuration_Item__c);
            Id ConfigItem = TK.Configuration_Item__c;
            if(TemplateName.startsWith('ASA-') && String.isNotBlank(TK.Configuration_Item__c)){
                BMCServiceDesk__BMC_BaseElement__c BaseElement = [ SELECT Id, FKTrustee_ID_1__c, FKTrustee_ID_2__c,
                                                                  Post_Approval_Queue_Assignment__c, Post_Approval_Email_Notification__c
                                                                  FROM BMCServiceDesk__BMC_BaseElement__c        
                                                                  WHERE Id = :ConfigItem
                                                                  LIMIT 1 ];
                System.Debug('BaseElement.Post_Approval_Email_Notification__c:'+BaseElement.Post_Approval_Email_Notification__c);
                System.Debug('BaseElement.Post_Approval_Queue_Assignment__c:'+BaseElement.Post_Approval_Queue_Assignment__c);
                TK.Post_Approval_Email_Notification__c = BaseElement.Post_Approval_Email_Notification__c;
                TK.Post_Approval_Queue_Assignment__c = BaseElement.Post_Approval_Queue_Assignment__c;
                TK.User_FKLookup_1__c = BaseElement.FKTrustee_ID_1__c;
                TK.User_FKLookup_2__c = BaseElement.FKTrustee_ID_2__c;
            }
        }
    }
    System.Debug('END PopulateCIInfo');
}