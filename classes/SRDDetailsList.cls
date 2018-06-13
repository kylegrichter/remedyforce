public class SRDDetailsList {
    public Id serviceRequestId {get;set;}
    public List<BMCServiceDesk__SRM_RequestDetailInputs__c> getrequestdetailinputsbyir(){
        Map<String, Schema.SObjectField> fldObjMap = schema.SObjectType.BMCServiceDesk__SRM_RequestDetailInputs__c.fields.getMap();
        List<Schema.SObjectField> fldObjMapValues = fldObjMap.values();
        String theQuery = 'SELECT ';
        for(Schema.SObjectField s : fldObjMapValues)
        {
            String theName = s.getDescribe().getName();
            theQuery += theName + ',';
        }
        theQuery = theQuery.subString(0, theQuery.length() - 1);
        theQuery += ' FROM BMCServiceDesk__SRM_RequestDetailInputs__c WHERE BMCServiceDesk__FKRequestDetail__r.BMCServiceDesk__FKIncident__c = \'' + serviceRequestId + '\' AND BMCServiceDesk__FKFulfillmentInputs__r.Exclude_in_Email_Template__c=False AND (BMCServiceDesk__FKFulfillmentInputs__r.BMCServiceDesk__AdditionalInfo__c != 1 OR BMCServiceDesk__FKFulfillmentInputs__r.BMCServiceDesk__AdditionalInfo__c != 0) Order by BMCServiceDesk__FKFulfillmentInputs__r.BMCServiceDesk__Order__c';
        List<BMCServiceDesk__SRM_RequestDetailInputs__c> srdList = Database.query(theQuery);
        return srdList;
    }
}