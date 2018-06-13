public class NotifyQueueAssociations {
    public string pattern1 {get;set;}
    public string pattern2 {get;set;}
    public string pattern3 {get;set;}
    public string source {get;set;}
    public string title {get;set;}
    public string description {get;set;}
    public string resultName {get;set;}
    public Id resultId {get;set;}
    public string resultxml {get;set;}
    public boolean opsMonitor {get;set;}
    public string ClientId {get;set;}
    public string queue {get;set;}
    public string impact {get;set;}
    public string urgency {get;set;}
    public string configitem {get;set;}
    public string category {get;set;}
    public string xmatters {get;set;}
    public boolean paramOpsMonitor;
    
    public Queue_Notification_Association__c getCIAssociationRecord() {
        Map<String, Schema.SObjectField> fldObjMap = schema.SObjectType.Queue_Notification_Association__c.fields.getMap();
        List<Schema.SObjectField> fldObjMapValues = fldObjMap.values();
        String theQuery = 'SELECT ';
        for(Schema.SObjectField s : fldObjMapValues){theQuery += s.getDescribe().getName() + ',';}
        theQuery += 'Impact__r.Name,Urgency__r.Name,IR_Category__r.Name,Configuration_Item__r.Name';
        theQuery += ' FROM Queue_Notification_Association__c';
        theQuery += ' WHERE IsActive__c = true';
        Integer[] myInts = new Integer[]{1,2,3};
            String searchParm;
        for (Integer PatternNumber : myInts){
            if (PatternNumber == 1 && pattern1 != null){searchParm = pattern1;}
            else if (PatternNumber == 2 && pattern2 != null){searchParm = pattern2;}
            else if (PatternNumber == 3 && pattern3 != null){searchParm = pattern3;}
            else {continue;}
            theQuery += ' AND Association_Pattern_' + PatternNumber + '__c IN (';
            do {
                theQuery += '\'' + searchParm + '\',';
                searchParm = searchParm.left(searchParm.length()-1);
            } while (searchParm.length() > 0);
            theQuery += ' \'\')';
        }
        theQuery += ' ORDER BY Association_Pattern_2__c DESC NULLS LAST, Association_Pattern_3__c DESC NULLS LAST, Association_Pattern_1__c DESC NULLS LAST LIMIT 1';
        Queue_Notification_Association__c assocrecord = Database.query(theQuery);
        return assocrecord;
    }
    
    public void LookupCreate() {
        string paramTargetObject = ApexPages.currentPage().getParameters().get('targetObject');
        string paramOpsMonitorStr = ApexPages.currentPage().getParameters().get('Ops_Monitor__c');
        string paramSource = ApexPages.currentPage().getParameters().get('BMCServiceDesk__contactType__c');
        string paramCategory = ApexPages.currentPage().getParameters().get('BMCServiceDesk__FKCategory__c');
        string paramLookup = ApexPages.currentPage().getParameters().get('Lookup');
        string paramInstance1 = ApexPages.currentPage().getParameters().get('Instance1');
        string paramInstance2 = ApexPages.currentPage().getParameters().get('Instance2');
        string paramInstance3 = ApexPages.currentPage().getParameters().get('Instance3');
        string paramImpact = ApexPages.currentPage().getParameters().get('BMCServiceDesk__FKImpact__c');
        string paramUrgency = ApexPages.currentPage().getParameters().get('BMCServiceDesk__FKUrgency__c');
        string paramOwner = ApexPages.currentPage().getParameters().get('OwnerId');
        string paramClient = ApexPages.currentPage().getParameters().get('ClientId');
        string paramTitle = ApexPages.currentPage().getParameters().get('Incident_Title__c');
        string paramDescription = ApexPages.currentPage().getParameters().get('Description__c');
        string paramConfig = ApexPages.currentPage().getParameters().get('ConfigItem');
        string paramXMatters = ApexPages.currentPage().getParameters().get('XMatters');
        string paramDueDate = ApexPages.currentPage().getParameters().get('dueDateTime__c');
        Queue_Notification_Association__c assocrecord;
        String queue;
        String impact;
        String urgency;
        String configitem;
        String category;                
        String source;
        String xmatters;
        
        if (string.isBlank(ApexPages.currentPage().getParameters().get('Lookup'))){
            paramLookup = 'FALSE';
        }       
        
        if((((paramLookup.toUpperCase() == 'TRUE') && ((paramTargetObject == null)||(paramTargetObject == 'BMCServiceDesk__Incident__c' &&(paramOpsMonitorStr == null || paramSource == null || paramInstance1 == null || paramTitle == null || paramDescription == null))||(paramTargetObject == 'BMCServiceDesk__Task__c' &&(paramTitle == null || paramDescription == null || paramInstance1 == null))))|| ((paramLookup.toUpperCase() == 'FALSE' || paramLookup == null) && ((paramTargetObject == null)||(paramTargetObject == 'BMCServiceDesk__Incident__c' &&(paramOpsMonitorStr == null || paramSource == null || paramCategory == null || paramImpact == null || paramUrgency == null || paramOwner == null || paramTitle == null || paramDescription == null || paramConfig == null))||(paramTargetObject == 'BMCServiceDesk__Task__c' &&(paramCategory == null || paramImpact == null || paramUrgency == null || paramOwner == null || paramTitle == null || paramDescription == null || paramConfig == null)))))){
            resultxml = '<ERROR>Unable to Generate Ticket - Missing Parameters: ';
            if (paramLookup.toUpperCase() == 'FALSE' && paramTargetObject == null){resultxml += 'targetObject, ';}
            if (paramTargetObject == 'BMCServiceDesk__Incident__c' && paramLookup.toUpperCase() == 'TRUE' && paramOpsMonitorStr == null){resultxml += 'Ops_Monitor__c, ';}
            if (paramTargetObject == 'BMCServiceDesk__Incident__c' && paramLookup.toUpperCase() == 'TRUE' && paramSource == null){resultxml += 'BMCServiceDesk__contactType__c, ';}
            if ((paramTargetObject == 'BMCServiceDesk__Incident__c'  || paramTargetObject == 'BMCServiceDesk__Task__c') && paramLookup.toUpperCase() == 'TRUE' && paramInstance1 == null){resultxml += 'Instance1, ';}
            if ((paramTargetObject == 'BMCServiceDesk__Incident__c'  || paramTargetObject == 'BMCServiceDesk__Task__c') && paramLookup.toUpperCase() == 'TRUE' && paramTitle == null){resultxml += 'Incident_Title__c, ';}
            if ((paramTargetObject == 'BMCServiceDesk__Incident__c'  || paramTargetObject == 'BMCServiceDesk__Task__c') && paramLookup.toUpperCase() == 'TRUE' && paramDescription == null){resultxml += 'Description__c, ';}
            if (paramTargetObject == 'BMCServiceDesk__Incident__c' && paramLookup.toUpperCase() == 'FALSE' && paramOpsMonitorStr == null){resultxml += 'Ops_Monitor__c, ';}
            if (paramTargetObject == 'BMCServiceDesk__Incident__c' && paramLookup.toUpperCase() == 'FALSE' && paramSource == null){resultxml += 'BMCServiceDesk__contactType__c, ';}
            if ((paramTargetObject == 'BMCServiceDesk__Incident__c'  || paramTargetObject == 'BMCServiceDesk__Task__c') && paramLookup.toUpperCase() == 'FALSE' && paramCategory == null){resultxml += 'BMCServiceDesk__FKCategory__c, ';}
            if ((paramTargetObject == 'BMCServiceDesk__Incident__c'  || paramTargetObject == 'BMCServiceDesk__Task__c') && paramLookup.toUpperCase() == 'FALSE' && paramImpact == null){resultxml += 'BMCServiceDesk__FKImpact__c, ';}
            if ((paramTargetObject == 'BMCServiceDesk__Incident__c'  || paramTargetObject == 'BMCServiceDesk__Task__c') && paramLookup.toUpperCase() == 'FALSE' && paramUrgency == null){resultxml += 'BMCServiceDesk__FKUrgency__c, ';}
            if ((paramTargetObject == 'BMCServiceDesk__Incident__c'  || paramTargetObject == 'BMCServiceDesk__Task__c') && paramLookup.toUpperCase() == 'FALSE' && paramOwner == null){resultxml += 'OwnerId, ';}
            if ((paramTargetObject == 'BMCServiceDesk__Incident__c'  || paramTargetObject == 'BMCServiceDesk__Task__c') && paramLookup.toUpperCase() == 'FALSE' && paramTitle == null){resultxml += 'Incident_Title__c, ';}
            if ((paramTargetObject == 'BMCServiceDesk__Incident__c'  || paramTargetObject == 'BMCServiceDesk__Task__c') && paramLookup.toUpperCase() == 'FALSE' && paramDescription == null){resultxml += 'Description__c, ';}
            if ((paramTargetObject == 'BMCServiceDesk__Incident__c'  || paramTargetObject == 'BMCServiceDesk__Task__c') && paramLookup.toUpperCase() == 'FALSE' && paramConfig == null){resultxml += 'ConfigItem, ';}
            resultxml = resultxml.left(resultxml.length()-2);
            resultxml += '</ERROR>';
        }
        else{
			if (paramTargetObject == 'BMCServiceDesk__Incident__c'){
				if (paramLookup == 'TRUE'){
					Map<String, Schema.SObjectField> fldObjMap = schema.SObjectType.Queue_Notification_Association__c.fields.getMap();
					List<Schema.SObjectField> fldObjMapValues = fldObjMap.values();
					String theQuery = 'SELECT ';
					for(Schema.SObjectField s : fldObjMapValues){theQuery += s.getDescribe().getName() + ',';}
					theQuery += 'Impact__r.Name,Urgency__r.Name,IR_Category__r.Name,Configuration_Item__r.Name';
					theQuery += ' FROM Queue_Notification_Association__c';
					theQuery += ' WHERE IsActive__c = true';
					Integer[] myInts = new Integer[]{1,2,3};
						String searchParm;
					for (Integer PatternNumber : myInts){
						if (PatternNumber == 1 && paramInstance1 != null){searchParm = paramInstance1;}
						else if (PatternNumber == 2 && paramInstance2 != null){searchParm = paramInstance2;}
						else if (PatternNumber == 3 && paramInstance3 != null){searchParm = paramInstance3;}
						else {continue;}
						theQuery += ' AND Association_Pattern_' + PatternNumber + '__c IN (';
						do {
							theQuery += '\'' + searchParm + '\',';
							searchParm = searchParm.left(searchParm.length()-1);
						} while (searchParm.length() > 0);
						theQuery += ' \'\')';
					}
					theQuery += ' ORDER BY Association_Pattern_2__c DESC NULLS LAST, Association_Pattern_3__c DESC NULLS LAST, Association_Pattern_1__c DESC NULLS LAST LIMIT 1';
					assocrecord = Database.query(theQuery);
					
					queue = assocrecord.Queue__c;
					impact = assocrecord.Impact__r.Name;
					urgency = assocrecord.Urgency__r.Name;
					configitem = assocrecord.Configuration_Item__r.Name;
					category = assocrecord.IR_Category__r.Name;
					xmatters = assocrecord.X_Matters_Notification_Group__c;
				}
				else {
					queue = paramOwner;
					impact = paramImpact;
					urgency = paramUrgency;
					configitem = paramConfig;
					category = paramCategory;
					xmatters = paramXMatters;
				}
				
				if (paramOpsMonitorStr.toUpperCase() == 'TRUE' ){
					paramOpsMonitor = TRUE;
				} 
				else {
					paramOpsMonitor = FALSE;
				}
				if (paramClient == null){
					ClientId = [SELECT Id From User WHERE Name = 'RemForce API'].id;
				}else {
					ClientId = [SELECT Id From User WHERE Name = :paramClient].id;
				}
				
				source = paramSource;
				String title = paramTitle;
				String description = paramDescription;
				
				Id myqueueId = [SELECT Id FROM Group WHERE DeveloperName = :queue].id;
				Id myimpactId = [SELECT Id FROM BMCServiceDesk__Impact__c WHERE Name = :impact].id;
				Id myurgencyId = [SELECT Id FROM BMCServiceDesk__Urgency__c WHERE Name = :urgency].id;
				Id myconfigitemId = [SELECT Id FROM BMCServiceDesk__BMC_BaseElement__c WHERE Name = :configitem].id;
				Id mycategoryId = [SELECT Id FROM BMCServiceDesk__Category__c WHERE Name = :category].id;
				BMCServiceDesk__Incident__c incident = new BMCServiceDesk__Incident__c (
					BMCServiceDesk__FKClient__c = ClientId,
					BMCServiceDesk__FKCategory__c = mycategoryId,
					BMCServiceDesk__FKBMC_BaseElement__c = myconfigitemId,
					BMCServiceDesk__state__c = true,
					BMCServiceDesk__FKImpact__c = myimpactId,
					BMCServiceDesk__FKUrgency__c = myurgencyId,
					BMCServiceDesk__contactType__c = source,
					X_Matters_Notification_Group__c= xmatters,
					Ops_Monitor__c = paramOpsMonitor,
					Incident_Title__c = title,
					BMCServiceDesk__incidentDescription__c = description,
					OwnerId = myqueueId
				);
				insert incident;
				resultId = incident.id;
				resultName = [select name from BMCServiceDesk__Incident__c where id = :resultId].Name;
				resultxml = '<RECORD_CREATED>';
				resultxml += '<ID>' + resultId + '</ID>';
				resultxml += '<Name>' + resultName + '</Name>';
				resultxml += '</RECORD_CREATED>';
			} else if(paramTargetObject == 'BMCServiceDesk__Task__c'){
				if (paramLookup == 'TRUE'){
					Map<String, Schema.SObjectField> fldObjMap = schema.SObjectType.Queue_Notification_Association__c.fields.getMap();
					List<Schema.SObjectField> fldObjMapValues = fldObjMap.values();
					String theQuery = 'SELECT ';
					for(Schema.SObjectField s : fldObjMapValues){theQuery += s.getDescribe().getName() + ',';}
					theQuery += 'Impact__r.Name,Urgency__r.Name,IR_Category__r.Name,Configuration_Item__r.Name';
					theQuery += ' FROM Queue_Notification_Association__c';
					theQuery += ' WHERE IsActive__c = true';
					Integer[] myInts = new Integer[]{1,2,3};
						String searchParm;
					for (Integer PatternNumber : myInts){
						if (PatternNumber == 1 && paramInstance1 != null){searchParm = paramInstance1;}
						else if (PatternNumber == 2 && paramInstance2 != null){searchParm = paramInstance2;}
						else if (PatternNumber == 3 && paramInstance3 != null){searchParm = paramInstance3;}
						else {continue;}
						theQuery += ' AND Association_Pattern_' + PatternNumber + '__c IN (';
						do {
							theQuery += '\'' + searchParm + '\',';
							searchParm = searchParm.left(searchParm.length()-1);
						} while (searchParm.length() > 0);
						theQuery += ' \'\')';
					}
					theQuery += ' ORDER BY Association_Pattern_2__c DESC NULLS LAST, Association_Pattern_3__c DESC NULLS LAST, Association_Pattern_1__c DESC NULLS LAST LIMIT 1';
					assocrecord = Database.query(theQuery);
					
					queue = assocrecord.Queue__c;
					impact = assocrecord.Impact__r.Name;
					urgency = assocrecord.Urgency__r.Name;
					configitem = assocrecord.Configuration_Item__r.Name;
					category = assocrecord.IR_Category__r.Name;
                    
				}
				else {
					queue = paramOwner;
					impact = paramImpact;
					urgency = paramUrgency;
					configitem = paramConfig;
					category = paramCategory;
				}
				
				if (paramClient == null){
					ClientId = [SELECT Id From User WHERE Name = 'RemForce API'].id;
				}else {
					ClientId = [SELECT Id From User WHERE Name = :paramClient].id;
				}
				
				String title = paramTitle;
				String description = paramDescription;
                DateTime duedate;
                if(paramDueDate != null){
                    DateTime dateInstance = datetime.newInstanceGmt(1970, 1, 1, 0, 0, 0);
                    duedate = dateInstance.addSeconds(Integer.valueOf(paramDueDate));
                }
                
                Id myqueueId = null;
                Id myimpactId = null;
				Id myurgencyId = null;
				Id myconfigitemId = null;
				Id mycategoryId = null;
                
                List<Group> queues = [SELECT Id FROM Group WHERE DeveloperName = :queue LIMIT 1];
                List<BMCServiceDesk__Impact__c> impacts = [SELECT Id FROM BMCServiceDesk__Impact__c WHERE Name = :impact LIMIT 1];
                List<BMCServiceDesk__Urgency__c> urgencies = [SELECT Id FROM BMCServiceDesk__Urgency__c WHERE Name = :urgency LIMIT 1];
                List<BMCServiceDesk__BMC_BaseElement__c> configs = [SELECT Id FROM BMCServiceDesk__BMC_BaseElement__c WHERE Name = :configitem LIMIT 1];
                List<BMCServiceDesk__Category__c> categories = [SELECT Id FROM BMCServiceDesk__Category__c WHERE Name = :category LIMIT 1];
                
                if(!queues.isEmpty()){ myqueueId = queues[0].Id; }
                if(!impacts.isEmpty()){ myimpactId = impacts[0].Id; }
                if(!urgencies.isEmpty()){ myurgencyId = urgencies[0].Id; }
                if(!configs.isEmpty()){ myconfigitemId = configs[0].Id; }
                if(!categories.isEmpty()){ mycategoryId = categories[0].Id; }
                
                if(String.isEmpty(myqueueId) || String.isEmpty(myimpactId) || String.isEmpty(myurgencyId) || String.isEmpty(myconfigitemId) || String.isEmpty(mycategoryId) || duedate < datetime.now()){
                    resultxml = '<ERROR>Unable to Generate Ticket - Missing Valid Data: ';
                    if (String.isEmpty(myqueueId)){resultxml += '\'' + queue + '\' is not a valid queue. 0 Records found. ';}
                    if (String.isEmpty(myimpactId)){resultxml += '\'' + impact + '\' is not a valid impact. 0 Records found. ';}
                    if (String.isEmpty(myurgencyId)){resultxml += '\'' + urgency + '\' is not a valid urgency. 0 Records found. ';}
                    if (String.isEmpty(myconfigitemId)){resultxml += '\'' + configitem + '\' is not a valid config item. 0 Records found. ';}
                    if (String.isEmpty(mycategoryId)){resultxml += '\'' + category + '\' is not a valid category. 0 Records found.';}
                    if (duedate < datetime.now()){resultxml += '\'' + duedate + '\'(' + paramDueDate + ') must be later than the Opened Date.';}
                    resultxml += '</ERROR>';
                } else {
                    myimpactId = [SELECT Id FROM BMCServiceDesk__Impact__c WHERE Name = :impact].id;
                    myurgencyId = [SELECT Id FROM BMCServiceDesk__Urgency__c WHERE Name = :urgency].id;
                    myconfigitemId = [SELECT Id FROM BMCServiceDesk__BMC_BaseElement__c WHERE Name = :configitem].id;
                    mycategoryId = [SELECT Id FROM BMCServiceDesk__Category__c WHERE Name = :category].id;
                    BMCServiceDesk__Task__c task = new BMCServiceDesk__Task__c (
                        BMCServiceDesk__FKClient__c = ClientId,
                        BMCServiceDesk__FKCategory__c = mycategoryId,
                        Configuration_Item__c = myconfigitemId,
                        BMCServiceDesk__state__c = true,
                        BMCServiceDesk__FKImpact__c = myimpactId,
                        BMCServiceDesk__FKUrgency__c = myurgencyId,
                        Task_Title__c = title,
                        BMCServiceDesk__taskDescription__c = description,
                        OwnerId = myqueueId,
                        BMCServiceDesk__dueDateTime__c = duedate
                    );
                    insert task;
                    resultId = task.id;
                    resultName = [select name from BMCServiceDesk__Task__c where id = :resultId].Name;
                    resultxml = '<RECORD_CREATED>';
                    resultxml += '<ID>' + resultId + '</ID>';
                    resultxml += '<Name>' + resultName + '</Name>';
                    resultxml += '</RECORD_CREATED>';   
                }
			}
		}
    }
    
    public void createIR(){
        Id myqueueId = [SELECT Id FROM Group WHERE DeveloperName = :queue].id;
        Id myimpactId = [SELECT Id FROM BMCServiceDesk__Impact__c WHERE Name = :impact].id;
        Id myurgencyId = [SELECT Id FROM BMCServiceDesk__Urgency__c WHERE Name = :urgency].id;
        Id myconfigitemId = [SELECT Id FROM BMCServiceDesk__BMC_BaseElement__c WHERE Name = :configitem].id;
        Id mycategoryId = [SELECT Id FROM BMCServiceDesk__Category__c WHERE Name = :category].id;
        Id myclient = [SELECT Id From User WHERE Name = :ClientId].id;
        BMCServiceDesk__Incident__c incident = new BMCServiceDesk__Incident__c (
            BMCServiceDesk__FKClient__c = myclient,
            BMCServiceDesk__FKCategory__c = mycategoryId,
            BMCServiceDesk__FKBMC_BaseElement__c = myconfigitemId,
            BMCServiceDesk__state__c = true,
            BMCServiceDesk__FKImpact__c = myimpactId,
            BMCServiceDesk__FKUrgency__c = myurgencyId,
            BMCServiceDesk__contactType__c = source,
            Ops_Monitor__c = opsMonitor,
            Incident_Title__c = title,
            BMCServiceDesk__incidentDescription__c = description,
            OwnerId = myqueueId
        );
        insert incident;
        resultId = incident.id;
        resultName = [select name from BMCServiceDesk__Incident__c where id = :resultId].Name;
    }
}