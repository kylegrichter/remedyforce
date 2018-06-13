public class BMCRF_NotificationDetailsParser {
        public result result;
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
    public class result{
        public String status;
        public String createdName;
        public Decimal id;
        public String notificationStatus;
        public String type;
        public String productSource;
        public Decimal organizationId;
        public String priority;
        public Boolean transformed;
        public Integer oldAwareCAMPID;
        public Decimal endDate;
        public Decimal createdDate;
        public incidentPhase incidentPhase;
        public Boolean hasNotification;
        public publicMessages publicMessages;
        public String launchtype;
        public message message;
        public Decimal resourceBundleId;
        public Integer batchNotificationId;
        public String notificationName;
        public Integer stoppedBy;
        public String source;
        public Decimal lastModifiedDate;
        public Integer sourceTemplateId;
        public Decimal lastModifiedId;
        public broadcastSettings broadcastSettings;
        public Decimal createdId;
        public notificationResult notificationResult;
        public String processedBy;
        public broadcastContacts broadcastContacts;
        public String lastModifiedName;
        public Decimal accountId;
        public incident incident;
        public Decimal startDate;
    }
    public class responseSetting{
        public String profileId;
        public String type;
    }
    public class phaseTemplate{
        public formTemplate formTemplate;
        public list<phaseDefinitions> phaseDefinitions;
        public broadcastTemplate broadcastTemplate;
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
        public Integer seq;
        public String status;
        public String incidentStatus;
        public Boolean isDefault;
        public Integer id;
        public String name;
        public String phaseNodeType;
    }
    public class notificationResult{
        public Integer notificationId;
        public Integer confirmedLateCount;
        public Integer totalCount;
        public Integer notConfirmedCount;
        public Integer confirmedCount;
        public list<allDetails> allDetails;
        public Integer unreachableCount;
    }
    public class message{
        public Decimal accountId;
        public String rtfContent;
        public Decimal organizationId;
        public String lastModifiedName;
        public String contentType;
        public Decimal createdId;
        public Integer id;
        public Decimal lastModifiedId;
        public String title;
        public Decimal lastModifiedDate;
        public String textMessage;
        public Decimal resourceBundleId;
        public Integer conferenceBridgeId;
        public String status;
        public Decimal createdDate;
        public String createdName;
        
    }
    public class incidentPhase{
        public Decimal createdDate;
        public String name;
        public Decimal lastModifiedDate;
        public phaseTemplate phaseTemplate;
        public Decimal lastModifiedId;
        public phaseDefinition phaseDefinition;
        public Decimal organizationId;
        public Decimal resourceBundleId;
        public Integer id;
        public String status;
        public Integer notificationId;
        public Decimal accountId;
        public Decimal createdId;
        public Decimal incidentId;
        public String lastModifiedName;
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
    public class callResultByPaths{
        public String path;
        public String pathText;
        public Integer cycleSeq;
        public String callResult;
        public Integer waitTime;
        public String firstName;
        public Decimal attemptTime;
        public String lastName;
        public Integer attemptOrder;
        public Boolean confirmed;
        public Integer journalId;
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
        public Boolean recipientApp;
        public Boolean confirm;
        public String deliveryPathOrder;
        public String senderEmail;
        public responseSetting responseSetting;
        public String language;
        public String voiceMailOption;
        public Integer contactCycles;
        public Integer throttlDefaultAmount;
        public list<senderCallerInfos> senderCallerInfos;
        public Boolean throttle;
        public Integer duration;
        public list<deliverPaths> deliverPaths;
        public Integer cycleInterval;
        public Boolean requirePinForMessage;
        public Boolean bookConference;
        public Integer deliveryMethodInterval;
        
    }
    public class broadcastContacts{
        public String contactSearchType;
        public list<String> groupIds;
        public list<String> groupNames;
    }
    public class allDetails{
        public Decimal notificationId;
        public Integer confirmedPathId;
        public String confirmedPath;
        public String lastName;
        public String confirmedPathValue;
        public String firstName;
        public Decimal confirmedDate;
        public String fullName;
        public Integer attempt;
        public Decimal firstAttemptTime;
        public String externalId;
        public Decimal attemptTime;
        public Decimal createdId;
        public String result;
        public list<callResultByPaths> callResultByPaths;
        public Decimal contactId;
        public Boolean confirmed;
        public Decimal id;
    }
    public class publicMessages {
    }
    public static BMCRF_NotificationDetailsParser parse(String json) {
        return (BMCRF_NotificationDetailsParser) System.JSON.deserialize(json, BMCRF_NotificationDetailsParser.class);
    }
}