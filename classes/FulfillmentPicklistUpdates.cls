global class FulfillmentPicklistUpdates implements Schedulable {
    global void execute(SchedulableContext SC) {
        sos_picklists();
        ror_approver_picklists();
        queue_picklists();
        queue_picklists_2();
        prdctrl_picklists();
        infra_monitoring_picklists();
        dba_picklists();
        additional_access_applications_questions_picklists();
        additional_access_applications_no_questions_picklists();
        additional_access_vast_profiles_picklists();
        additional_access_kgen_profiles_picklists();
        notification_groups_picklists();
    }
    public void sos_picklists() {
        List<BMCServiceDesk__BMC_BaseElement__c> items = [SELECT Id, Name, BMCServiceDesk__InstanceID__c FROM BMCServiceDesk__BMC_BaseElement__c WHERE SOS_SR_Picklist__c = true AND BMCServiceDesk__MarkAsDeleted__c = false ORDER BY Name];
        String inputvalue = '';
        for(BMCServiceDesk__BMC_BaseElement__c a: items){
            inputvalue += a.Name + '||' + a.Name + '||false{}';
        }
        inputvalue = inputvalue.left(inputvalue.length()-2);
        List<BMCServiceDesk__SRM_FulfillmentInputs__c> records = [SELECT Id FROM BMCServiceDesk__SRM_FulfillmentInputs__c WHERE Update_Process_Name__c = 'SOS Fulfillment' AND BMCServiceDesk__ResponseType__c = 'Picklist'];
        List<BMCServiceDesk__SRM_FulfillmentInputs__c> updates = new List<BMCServiceDesk__SRM_FulfillmentInputs__c>{};
            for(BMCServiceDesk__SRM_FulfillmentInputs__c a: records){
                a.Update_Picklist__c=true;
                a.InputValue_Staging__c=inputvalue;
                updates.add(a);
            }
        update updates;
    }
    public void ror_approver_picklists() {
        List<User> items = [SELECT Id, Name FROM User where (Title like '%Real Estate%' OR Title like '%Workplace Solution%') and isActive = true ORDER BY Name];
        String inputvalue = '';
        for(User a: items){
            inputvalue += a.Name + '||' + a.Id + '||false{}';
        }
        inputvalue = inputvalue.left(inputvalue.length()-2);
        List<BMCServiceDesk__SRM_FulfillmentInputs__c> records = [SELECT Id FROM BMCServiceDesk__SRM_FulfillmentInputs__c WHERE Update_Process_Name__c = 'ROR Approver Fulfillment' AND BMCServiceDesk__ResponseType__c = 'Picklist'];
        List<BMCServiceDesk__SRM_FulfillmentInputs__c> updates = new List<BMCServiceDesk__SRM_FulfillmentInputs__c>{};
            for(BMCServiceDesk__SRM_FulfillmentInputs__c a: records){
                a.Update_Picklist__c=true;
                a.InputValue_Staging__c=inputvalue;
                updates.add(a);
            }
        update updates;
    }
    public void queue_picklists() {
        List<Group> items = [SELECT Name, DeveloperName FROM Group WHERE Type = 'Queue' and NAME NOT IN('Pending Approval','IT Governance','1300 Extended Support') ORDER BY Name];
        String inputvalue = '';
        for(Group a: items){
            inputvalue += a.Name + '||' + a.DeveloperName + '||false{}';
        }
        inputvalue = inputvalue.left(inputvalue.length()-2);
        List<BMCServiceDesk__SRM_FulfillmentInputs__c> records = [SELECT Id FROM BMCServiceDesk__SRM_FulfillmentInputs__c WHERE Update_Process_Name__c = 'Queue Fulfillment' AND BMCServiceDesk__ResponseType__c = 'Picklist'];
        List<BMCServiceDesk__SRM_FulfillmentInputs__c> updates = new List<BMCServiceDesk__SRM_FulfillmentInputs__c>{};
            for(BMCServiceDesk__SRM_FulfillmentInputs__c a: records){
                a.Update_Picklist__c=true;
                a.InputValue_Staging__c=inputvalue;
                updates.add(a);
            }
        update updates;
    }
    public void queue_picklists_2() {
        List<Group> items = [SELECT Name, DeveloperName FROM Group WHERE Type = 'Queue' and NAME NOT IN('Pending Approval','IT Governance','1300 Extended Support') ORDER BY Name];
        String inputvalue = '';
        for(Group a: items){
            inputvalue += a.Name + '||' + a.Name + '||false{}';
        }
        inputvalue = inputvalue.left(inputvalue.length()-2);
        List<BMCServiceDesk__SRM_FulfillmentInputs__c> records = [SELECT Id FROM BMCServiceDesk__SRM_FulfillmentInputs__c WHERE Update_Process_Name__c = 'Queue 2 Fulfillment' AND BMCServiceDesk__ResponseType__c = 'Picklist'];
        List<BMCServiceDesk__SRM_FulfillmentInputs__c> updates = new List<BMCServiceDesk__SRM_FulfillmentInputs__c>{};
            for(BMCServiceDesk__SRM_FulfillmentInputs__c a: records){
                a.Update_Picklist__c=true;
                a.InputValue_Staging__c=inputvalue;
                updates.add(a);
            }
        update updates;
    }
    public void prdctrl_picklists() {
        List<BMCServiceDesk__BMC_BaseElement__c> items = [SELECT Id, Name, BMCServiceDesk__InstanceID__c FROM BMCServiceDesk__BMC_BaseElement__c WHERE BMCServiceDesk__MarkAsDeleted__c = false AND PrdCtrl_SR_Picklist__c = true ORDER BY Name];
        String inputvalue = '';
        String value;
        for(BMCServiceDesk__BMC_BaseElement__c a: items){
            value = a.Name.replaceAll('-Application','');
            value = value.replaceAll('-Batch','');
            value = value.replaceAll('-INST_.*','');
            value = value.replaceAll('&','and');
            inputvalue += value + '||' + value + '||false{}';
        }
        inputvalue = inputvalue.left(inputvalue.length()-2);
        List<BMCServiceDesk__SRM_FulfillmentInputs__c> records = [SELECT Id FROM BMCServiceDesk__SRM_FulfillmentInputs__c WHERE Update_Process_Name__c = 'PrdCtrl Fulfillment' AND BMCServiceDesk__ResponseType__c = 'Picklist'];
        List<BMCServiceDesk__SRM_FulfillmentInputs__c> updates = new List<BMCServiceDesk__SRM_FulfillmentInputs__c>{};
            for(BMCServiceDesk__SRM_FulfillmentInputs__c a: records){
                a.Update_Picklist__c=true;
                a.InputValue_Staging__c=inputvalue;
                updates.add(a);
            }
        update updates;
    }
    public void infra_monitoring_picklists() {
        List<Group> items = [select Id, Name from Group where (NOT Name like 'Do Not Use%') AND Type = 'Queue' AND Id IN ( select QueueId from QueueSobject where SobjectType = 'BMCServiceDesk__Incident__c') ORDER BY Name];
        String inputvalue = '';
        for(Group a: items){
            inputvalue += a.Name + '||' + a.Name + '||false{}';
        }
        inputvalue = inputvalue.left(inputvalue.length()-2);
        List<BMCServiceDesk__SRM_FulfillmentInputs__c> records = [SELECT Id FROM BMCServiceDesk__SRM_FulfillmentInputs__c WHERE Update_Process_Name__c = 'Infra Monitoring' AND BMCServiceDesk__ResponseType__c = 'Picklist'];
        List<BMCServiceDesk__SRM_FulfillmentInputs__c> updates = new List<BMCServiceDesk__SRM_FulfillmentInputs__c>{};
            for(BMCServiceDesk__SRM_FulfillmentInputs__c a: records){
                a.Update_Picklist__c=true;
                a.InputValue_Staging__c=inputvalue;
                updates.add(a);
            }
        update updates;
    }
    public void dba_picklists() {
        List<BMCServiceDesk__BMC_BaseElement__c> items = [SELECT Id, Name FROM BMCServiceDesk__BMC_BaseElement__c WHERE BMCServiceDesk__ClassName__c = 'BMC_Database' AND BMCServiceDesk__MarkAsDeleted__c = false ORDER BY Name];
        String inputvalue = '';
        String value;
        for(BMCServiceDesk__BMC_BaseElement__c a: items){
            value = a.Name.replaceAll('- DataBase','');
            value = value.replaceAll('-INST_.*','');
            inputvalue += value + '||' + value + '||false{}';
        }
        inputvalue = inputvalue.left(inputvalue.length()-2);
        List<BMCServiceDesk__SRM_FulfillmentInputs__c> records = [SELECT Id FROM BMCServiceDesk__SRM_FulfillmentInputs__c WHERE Update_Process_Name__c = 'DBA Fulfillment' AND BMCServiceDesk__ResponseType__c = 'Picklist'];
        List<BMCServiceDesk__SRM_FulfillmentInputs__c> updates = new List<BMCServiceDesk__SRM_FulfillmentInputs__c>{};
            for(BMCServiceDesk__SRM_FulfillmentInputs__c a: records){
                a.Update_Picklist__c=true;
                a.InputValue_Staging__c=inputvalue;
                updates.add(a);
            }
        update updates;
    }
    public void additional_access_applications_questions_picklists() {
        List<BMCServiceDesk__BMC_BaseElement__c> items = [SELECT Id, Name, Post_Approval_Queue_Assignment__c, Additional_System_Access_Label__c, Additional_System_Access_Value__c FROM BMCServiceDesk__BMC_BaseElement__c WHERE Additional_System_Access__c = 'Application With Questions' ORDER BY Additional_System_Access_Label__c];
        String inputvalue = '';
        String value;
        for(BMCServiceDesk__BMC_BaseElement__c a: items){
            inputvalue += a.Additional_System_Access_Label__c + '||' + a.Additional_System_Access_Value__c + '||false{}';
        }
        inputvalue = inputvalue.left(inputvalue.length()-2);
        inputvalue = inputvalue += '{}None||None||false';
        List<BMCServiceDesk__SRM_FulfillmentInputs__c> records = [SELECT Id FROM BMCServiceDesk__SRM_FulfillmentInputs__c WHERE Update_Process_Name__c = 'Additional Access Apps With Questions' AND BMCServiceDesk__ResponseType__c = 'Picklist'];
        List<BMCServiceDesk__SRM_FulfillmentInputs__c> updates = new List<BMCServiceDesk__SRM_FulfillmentInputs__c>{};
            for(BMCServiceDesk__SRM_FulfillmentInputs__c a: records){
                a.Update_Picklist__c=true;
                a.InputValue_Staging__c=inputvalue;
                updates.add(a);
            }
        update updates;
    }
    public void additional_access_applications_no_questions_picklists() {
        List<BMCServiceDesk__BMC_BaseElement__c> items = [SELECT Id, Name, Post_Approval_Queue_Assignment__c, Additional_System_Access_Label__c, Additional_System_Access_Value__c FROM BMCServiceDesk__BMC_BaseElement__c WHERE Additional_System_Access__c = 'Application Without Questions' ORDER BY Additional_System_Access_Label__c];
        String inputvalue = 'None||None||true{}';
        String value;
        for(BMCServiceDesk__BMC_BaseElement__c a: items){
            inputvalue += a.Additional_System_Access_Label__c + '||' + a.Additional_System_Access_Value__c + '||false{}';
        }
        inputvalue = inputvalue.left(inputvalue.length()-2);
        List<BMCServiceDesk__SRM_FulfillmentInputs__c> records = [SELECT Id FROM BMCServiceDesk__SRM_FulfillmentInputs__c WHERE Update_Process_Name__c = 'Additional Access Apps Without Questions' AND BMCServiceDesk__ResponseType__c = 'Picklist'];
        List<BMCServiceDesk__SRM_FulfillmentInputs__c> updates = new List<BMCServiceDesk__SRM_FulfillmentInputs__c>{};
            for(BMCServiceDesk__SRM_FulfillmentInputs__c a: records){
                a.Update_Picklist__c=true;
                a.InputValue_Staging__c=inputvalue;
                updates.add(a);
            }
        update updates;
    }
    public void additional_access_vast_profiles_picklists() {
        List<BMCServiceDesk__BMC_BaseElement__c> items = [SELECT Id, Name, Post_Approval_Queue_Assignment__c, Additional_System_Access_Label__c, Additional_System_Access_Value__c FROM BMCServiceDesk__BMC_BaseElement__c WHERE Additional_System_Access__c = 'Vast Profile' ORDER BY Additional_System_Access_Label__c];
        String inputvalue = '';
        String value;
        for(BMCServiceDesk__BMC_BaseElement__c a: items){
            inputvalue += a.Additional_System_Access_Label__c + '||' + a.Additional_System_Access_Value__c + '||false{}';
        }
        inputvalue = inputvalue.left(inputvalue.length()-2);
        List<BMCServiceDesk__SRM_FulfillmentInputs__c> records = [SELECT Id FROM BMCServiceDesk__SRM_FulfillmentInputs__c WHERE Update_Process_Name__c = 'Additional Access Vast Profiles' AND BMCServiceDesk__ResponseType__c = 'Picklist'];
        List<BMCServiceDesk__SRM_FulfillmentInputs__c> updates = new List<BMCServiceDesk__SRM_FulfillmentInputs__c>{};
            for(BMCServiceDesk__SRM_FulfillmentInputs__c a: records){
                a.Update_Picklist__c=true;
                a.InputValue_Staging__c=inputvalue;
                updates.add(a);
            }
        update updates;
    }
    public void additional_access_kgen_profiles_picklists() {
        List<BMCServiceDesk__BMC_BaseElement__c> items = [SELECT Id, Name, Post_Approval_Queue_Assignment__c, Additional_System_Access_Label__c, Additional_System_Access_Value__c FROM BMCServiceDesk__BMC_BaseElement__c WHERE Additional_System_Access__c = 'kGen Profile' ORDER BY Additional_System_Access_Label__c];
        String inputvalue = '';
        String value;
        for(BMCServiceDesk__BMC_BaseElement__c a: items){
            inputvalue += a.Additional_System_Access_Label__c + '||' + a.Additional_System_Access_Value__c + '||false{}';
        }
        inputvalue = inputvalue.left(inputvalue.length()-2);
        List<BMCServiceDesk__SRM_FulfillmentInputs__c> records = [SELECT Id FROM BMCServiceDesk__SRM_FulfillmentInputs__c WHERE Update_Process_Name__c = 'Additional Access kGen Profiles' AND BMCServiceDesk__ResponseType__c = 'Picklist'];
        List<BMCServiceDesk__SRM_FulfillmentInputs__c> updates = new List<BMCServiceDesk__SRM_FulfillmentInputs__c>{};
            for(BMCServiceDesk__SRM_FulfillmentInputs__c a: records){
                a.Update_Picklist__c=true;
                a.InputValue_Staging__c=inputvalue;
                updates.add(a);
            }
        update updates;
    }
    public void notification_groups_picklists() {
        List<BMCServiceDesk__BMC_BaseElement__c> items = [select Id, BMCServiceDesk__Name__c FROM BMCServiceDesk__BMC_BaseElement__c WHERE BMCServiceDesk__ClassName__c = 'BMC_Notification_Group' order by BMCServiceDesk__Name__c];
        String inputvalue = '';
        String value;
        for(BMCServiceDesk__BMC_BaseElement__c a: items){
            value = a.BMCServiceDesk__Name__c.replaceAll('-XMATP','');
            value = value.replaceAll('-INST_.*','');
            inputvalue += value + '||' + value + '||false{}';
        }
        inputvalue = inputvalue.left(inputvalue.length()-2);
        List<BMCServiceDesk__SRM_FulfillmentInputs__c> records = [SELECT Id FROM BMCServiceDesk__SRM_FulfillmentInputs__c WHERE Update_Process_Name__c = 'Notification Groups Picklists' AND BMCServiceDesk__ResponseType__c = 'Picklist'];
        List<BMCServiceDesk__SRM_FulfillmentInputs__c> updates = new List<BMCServiceDesk__SRM_FulfillmentInputs__c>{};
            for(BMCServiceDesk__SRM_FulfillmentInputs__c a: records){
                a.Update_Picklist__c=true;
                a.InputValue_Staging__c=inputvalue;
                updates.add(a);
            }
        update updates;
    }
}