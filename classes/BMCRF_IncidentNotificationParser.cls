public class BMCRF_IncidentNotificationParser{
        public String lastPageUri;
        public String firstPageUri;
        public pageName pageName;
        public String message;
    public class senderCallerInfos{
        public String countryName;
        public Integer lastModifiedId;
        public Integer accountId;
        public Integer createdId;
        public String countryCode;
        public Boolean isDefault;
        public Integer resourceBundleId;
        public String callerId;
        public Integer organizationId;
        public Integer id;
        
    }
    public class responseSetting{
        public String type;
        public String profileId;
        
    }
    public class phaseTemplate{
        public broadcastTemplate broadcastTemplate;
        public list<phaseDefinitions> phaseDefinitions;
        public formTemplate formTemplate;
        public Boolean evaluateAll;
        public Integer messageFlag;
        public Integer contactsFlag;
        public String name;
        public Integer settingsFlag;
        public String templateName;
        public Boolean ignoreVariable;
        public Decimal templateId;
    }
    public class phaseStatus{
        public String phaseNodeType;
        public Boolean isDefault;
        public String status;
        public String name;
        public String incidentStatus;
        public Integer seq;
        public Integer id;
    }
    public class phaseDefinitions{
        public Integer seq;
        public String status;
        public Boolean isDefault;
        public Integer id;
    }
    public class phaseDefinition{
        public String phaseNodeType;
        public String name;
        public Boolean isDefault;
        public Integer seq;
        public String status;
        public String incidentStatus;
        public Integer id;
    }
    public class pageName{
        public list<data> data;
        public Integer totalCount;
        public Integer totalPageCount;
        public Integer start;
        public Integer currentPageNo;
        public Integer pageSize;
    }
    public class notificationResult{
        public Integer confirmedCount;
        public Integer unreachableCount;
        public Integer totalCount;
        public Decimal notificationId;
        public Integer confirmedLateCount;
        public Integer notConfirmedCount;
    }
    public class message{
        public String rtfContent;
        public String lastModifiedName;
        public Decimal accountId;
        public Decimal createdId;
        public Decimal organizationId;
        public Decimal lastModifiedId;
        public String contentType;
        public Decimal lastModifiedDate;
        public Integer id;
        public Decimal resourceBundleId;
        public String title;
        public String status;
        public String textMessage;
        public String createdName;
        public Integer conferenceBridgeId;
        public Decimal createdDate;
        
    }
    public class incidentPhase{
        public phaseDefinition phaseDefinition;
        public Decimal createdId;
        public Decimal createdDate;
        public Decimal lastModifiedId;
        public String lastModifiedName;
        public Decimal lastModifiedDate;
        public Decimal organizationId;
        public Decimal resourceBundleId;
        public Integer id;
        public String status;
        public Integer notificationId;
        public Decimal accountId;
        public phaseTemplate phaseTemplate;
        public Decimal incidentId;
        public String name;
        public String createdName;
    }
    public class incident{
        public Decimal accountId;
        public Decimal createdDate;
        public Boolean hasJournal;
        public String name;
        public String createdName;
        public String incidentStatus;
        public String status;
        public Decimal id;
        public Decimal resourceBundleId;
        public Decimal organizationId;
        public Integer duration;
        public Decimal createdId;
        public Decimal lastModifiedId;
        public String lastModifiedName;
        public phaseStatus phaseStatus;
        public String incidentAction;
        public Decimal lastModifiedDate;
    }
    public class formVariableItems{
        public Decimal variableId;
        public Boolean isRequired;
        public String variableName;
        public Integer seq;
        public list<String> val;
    }
    public class formTemplate{
        public list<formVariableItems> formVariableItems;
        public String subject;
    }
    public class deliverPaths{
        public Decimal accountId;
        public Boolean defaultValue;
        public Decimal pathId;
        public Boolean displayFlag;
        public Decimal organizationId;
        public Boolean extRequired;
        public Integer awarePathId;
        public String lastModifiedName;
        public Decimal id;
        public String prompt;
        public Boolean expose;
        public Decimal createdId;
        public Boolean isDefault;
        public Decimal lastModifiedId;
        public Decimal createdDate;
        public Decimal lastModifiedDate;
        public String createdName;
        public Integer seq;
        public String status;
        public Boolean editable;
        public Boolean mandatory;
        public Decimal resourceBundleId;
        
    }
    public class data{
        public incidentPhase incidentPhase;
        public String priority;
        public String productSource;
        public Integer oldAwareCAMPID;
        public String notificationStatus;
        public Decimal createdDate;
        public Decimal id;
        public Boolean hasNotification;
        public String type;
        public String createdName;
        public Decimal organizationId;
        public String status;
        public Boolean transformed;
        public notificationResult notificationResult;
        public Decimal endDate;
        public Decimal resourceBundleId;
        public String notificationName;
        public Integer batchNotificationId;
        public String source;
        public Integer stoppedBy;
        public Integer sourceTemplateId;
        public Decimal lastModifiedDate;
        public broadcastSettings broadcastSettings;
        public Decimal lastModifiedId;
        public message message;
        public Decimal createdId;
        public publicMessages publicMessages;
        public String processedBy;
        public String launchtype;
        public String lastModifiedName;
        public Decimal accountId;
        public incident incident;
        public Decimal startDate;
    }
    public class broadcastTemplate{
        public Integer createdId;
        public Integer id;
        public String type;
        public message message;
        public Integer organizationId;
        public broadcastSettings broadcastSettings;
        public Integer resourceBundleId;
        public String priority;
        public broadcastContacts broadcastContacts;
        public Integer lastModifiedId;
        public Integer accountId;
    }
    public class broadcastSettings{
        public String senderEmail;
        public responseSetting responseSetting;
        public String deliveryPathOrder;
        public String voiceMailOption;
        public Boolean confirm;
        public Integer throttlDefaultAmount;
        public Boolean recipientApp;
        public Boolean throttle;
        public String language;
        public list<deliverPaths> deliverPaths;
        public Integer contactCycles;
        public Boolean requirePinForMessage;
        public list<senderCallerInfos> senderCallerInfos;
        public Integer deliveryMethodInterval;
        public Integer duration;
        public Boolean bookConference;
        public Integer cycleInterval;
        
    }
    public class publicMessages{
    }
    public class broadcastContacts{
        public String contactSearchType;
        public list<String> groupNames;
        public list<String> groupIds;
    }
     public static BMCRF_IncidentNotificationParser parse(String json) {
        return (BMCRF_IncidentNotificationParser) System.JSON.deserialize(json, BMCRF_IncidentNotificationParser.class);
    }
}