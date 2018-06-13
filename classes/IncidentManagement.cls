public class IncidentManagement {
    public Decimal getrange(){ return range; }
    public void setrange(Decimal range){ this.range = range; }
    public Decimal range;
    
    public List<SelectOption> getranges(){
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('.75', 'Default (18hrs.)'));
		options.add(new SelectOption('1','1 Day'));
        options.add(new SelectOption('2','2 Days'));
        options.add(new SelectOption('3','3 Days'));
        options.add(new SelectOption('4','4 Days'));
        options.add(new SelectOption('5','5 Days'));
        options.add(new SelectOption('6','6 Days'));
        options.add(new SelectOption('7','7 Days'));
        options.add(new SelectOption('8','8 Days'));
        options.add(new SelectOption('9','9 Days'));
        options.add(new SelectOption('10','10 Days'));
        return options;
    }
    
    public List<BMCServiceDesk__Incident__c> getopsIncidents(){
        List<BMCServiceDesk__Incident__c> incidents;
        Map<String, Schema.SObjectField> fldObjMap = schema.SObjectType.BMCServiceDesk__Incident__c.fields.getMap();
        Map<String, Schema.SObjectField> fldObjMap2 = schema.SObjectType.BMCServiceDesk__IncidentHistory__c.fields.getMap();
        List<Schema.SObjectField> fldObjMapValues = fldObjMap.values();
        List<Schema.SObjectField> fldObjMapValues2 = fldObjMap2.values();
        System.debug('getopsIncidents starting' );
        
        if (string.isNotBlank(ApexPages.currentPage().getParameters().get('range')) && ApexPages.currentPage().getParameters().get('print')=='yes'){
            range = decimal.valueof(ApexPages.currentPage().getParameters().get('range'));
        } else {
        	if(range == null){
                range = .75;
            }    
        }
        Datetime opsMonitorTime = Datetime.now()-range;
        
        String theQuery = 'SELECT ';
        for(Schema.SObjectField s : fldObjMapValues){
            String theName = s.getDescribe().getName();
            theQuery += theName + ',';
        }
        theQuery += ' (SELECT ';
        for(Schema.SObjectField s : fldObjMapValues2){
            String theName = s.getDescribe().getName();
            theQuery += theName + ',';
        }
        theQuery += 'BMCServiceDesk__FKUser__r.Name FROM BMCServiceDesk__Incident_Histories__r ORDER BY BMCServiceDesk__date__c)';
        theQuery += ' FROM BMCServiceDesk__Incident__c WHERE ';
        theQuery += ' ( Ops_Monitor__c = True OR Ops_Monitor_Time__c >= ' + opsMonitorTime.format('yyyy-MM-dd\'T\'HH:mm:ss.SSS\'Z\'') +' )';
        theQuery += ' AND BMCServiceDesk__Type__c = \'Incident\'';
        theQuery += ' AND BMCServiceDesk__inactive__c != True';
        theQuery += ' AND BMCServiceDesk__Priority_ID__c < \'4\'';
        theQuery += ' ORDER BY Ops_Monitor_Time__c, BMCServiceDesk__openDateTime__c';
        incidents = Database.query(theQuery);
        return incidents;
    }
    
    public List<AggregateResult> getcountsMonitored(){
		List<AggregateResult> count;
        count = [SELECT COUNT(ID) MyCount FROM BMCServiceDesk__Incident__c WHERE Ops_Monitor__c = True AND BMCServiceDesk__Type__c = 'Incident' AND BMCServiceDesk__inactive__c != True AND BMCServiceDesk__Priority_ID__c < '4'];
        return count;
    }
    public List<AggregateResult> getcountsTotal(){
		List<AggregateResult> count;
        if (string.isNotBlank(ApexPages.currentPage().getParameters().get('range')) && ApexPages.currentPage().getParameters().get('print')=='yes'){
            range = decimal.valueof(ApexPages.currentPage().getParameters().get('range'));
        } else {
        	if(range == null){
                range = .75;
            }    
        }
        Datetime opsMonitorTime = Datetime.now()-range;
        count = [SELECT COUNT(ID) MyCount FROM BMCServiceDesk__Incident__c WHERE (Ops_Monitor__c = True OR Ops_Monitor_Time__c >= :opsMonitorTime) AND BMCServiceDesk__Type__c = 'Incident' AND BMCServiceDesk__inactive__c != True AND BMCServiceDesk__Priority_ID__c < '4'];
        return count;
    }
}