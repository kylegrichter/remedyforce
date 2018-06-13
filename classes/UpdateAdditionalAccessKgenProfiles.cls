public class UpdateAdditionalAccessKgenProfiles {
    @InvocableMethod(label='Update kGen Profile Picklist in ASA SRD' description='Updates the kGen Profile picklist in the ASA form with a current list of profiles.')
    public static list<BMCServiceDesk__SRM_FulfillmentInputs__c> additional_access_kgen_profiles_picklists() {
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
        return updates;
    }
}