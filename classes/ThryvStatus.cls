public class ThryvStatus {
    public Boolean currentCount;
    public Boolean getcurrentCount(){
        List<Thryv_Status__c> current = [Select Id FROM Thryv_Status__c WHERE Date_Time__c > YESTERDAY and Date_Time__c < TOMORROW and Inactive__c = false ORDER BY Date_Time__c];
        if (current.size() > 0) {
            currentCount = true;
        } else {
            currentCount = false;
        }
        return currentCount;
    }
    public void setcurrentCount(Boolean currentCount){
        this.currentCount = currentCount;
    }
    
    public Boolean pastCount;
    public Boolean getpastCount(){
        List<Thryv_Status__c> past = [Select Id FROM Thryv_Status__c WHERE Date_Time__c < YESTERDAY and Date_Time__c > LAST_WEEK and Inactive__c = false ORDER BY Date_Time__c Desc limit 1];
        if (past.size() > 0) {
            pastCount = true;
        } else {
            pastCount = false;
        }
        return pastCount;
    }
    public void setpastCount(Boolean pastCount){
        this.pastCount = pastCount;
    }
    
    public Boolean upcomingCount;
    public Boolean getupcomingCount(){
        List<Thryv_Status__c> upcoming = [Select Id FROM Thryv_Status__c WHERE Date_Time__c > TOMORROW and Inactive__c = false ORDER BY Date_Time__c limit 2];
        if (upcoming.size() > 0) {
            upcomingCount = true;
        } else {
            upcomingCount = false;
        }
        return upcomingCount;
    }
    public void setupcomingCount(Boolean upcomingCount){
        this.upcomingCount = upcomingCount;
    }
    
    public List<Thryv_Status__c> getcurrent() {       
        Map<String, Schema.SObjectField> fldObjMap = schema.SObjectType.Thryv_Status__c.fields.getMap();
        List<Schema.SObjectField> fldObjMapValues = fldObjMap.values();
        String theQuery = 'SELECT ';
        for(Schema.SObjectField s : fldObjMapValues) {
            String theName = s.getDescribe().getName();
            theQuery += theName + ',';
        }
        theQuery += ' Owner.Name FROM Thryv_Status__c WHERE Date_Time__c > YESTERDAY and Date_Time__c < TOMORROW and Inactive__c = false ORDER BY Date_Time__c';
        List<Thryv_Status__c> current = Database.query(theQuery);
        if (current.size() > 0) {
            return current;
        } else {
            return null;
        }
    }
    public List<Thryv_Status__c> getpast() {       
        Map<String, Schema.SObjectField> fldObjMap = schema.SObjectType.Thryv_Status__c.fields.getMap();
        List<Schema.SObjectField> fldObjMapValues = fldObjMap.values();
        String theQuery = 'SELECT ';
        for(Schema.SObjectField s : fldObjMapValues) {
            String theName = s.getDescribe().getName();
            theQuery += theName + ',';
        }
        theQuery += ' Owner.Name FROM Thryv_Status__c WHERE Date_Time__c < YESTERDAY and Date_Time__c > LAST_WEEK and Inactive__c = false ORDER BY Date_Time__c Desc limit 1';
        List<Thryv_Status__c> past = Database.query(theQuery);
        if (past.size() > 0) {
            pastCount = true;
            return past;
        } else {
            pastCount = false;
            return null;
        }
    }
    public List<Thryv_Status__c> getupcoming() {       
        Map<String, Schema.SObjectField> fldObjMap = schema.SObjectType.Thryv_Status__c.fields.getMap();
        List<Schema.SObjectField> fldObjMapValues = fldObjMap.values();
        String theQuery = 'SELECT ';
        for(Schema.SObjectField s : fldObjMapValues) {
            String theName = s.getDescribe().getName();
            theQuery += theName + ',';
        }
        theQuery += ' Owner.Name FROM Thryv_Status__c WHERE Date_Time__c > TOMORROW and Inactive__c = false ORDER BY Date_Time__c limit 2';
        List<Thryv_Status__c> upcoming = Database.query(theQuery);
        if (upcoming.size() > 0) {
            upcomingCount = true;
            return upcoming;
        } else {
            upcomingCount = false;
            return null;
        }
    }
}