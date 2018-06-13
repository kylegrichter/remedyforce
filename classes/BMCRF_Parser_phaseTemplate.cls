public class BMCRF_Parser_phaseTemplate {

    public Long id;
    public String Name;
    public String templateStatus;
    public List<PhaseTemplates> phaseTemplates;
    public Long accountId;
    public String status;
    public Long createdId;
    public String createdName;
    public Long lastModifiedId;
    public String lastModifiedName;
    public Long createdDate;
    public Long lastModifiedDate;
    public Long organizationId;
    public Long resourceBundleId;
    
    public class BroadcastTemplate {
        public Integer accountId;
        public BroadcastContacts broadcastContacts;
        public Integer resourceBundleId;
        public Integer organizationId;
        public String type_Z;// in json: type
        public Integer id;
        public Message message;
        public BroadcastSettings broadcastSettings;
        public String priority;
        public Integer lastModifiedId;
        public Integer createdId;

    }
    
    public class Message {
        public Integer accountId;
        public Integer organizationId;
        public String contentType;
        public Integer id;
        public String title;
        public Integer conferenceBridgeId;
        public Integer resourceBundleId;
        public Integer lastModifiedId;
        public Integer createdId;

    }

    public class BroadcastSettings {
        public String voiceMailOption;
        public Integer throttlDefaultAmount;
        public Boolean throttle;
        public MobileSettings mobileSettings;
        public List<DeliverPaths> deliverPaths;
        public Boolean requirePinForMessage;
        public Integer deliveryMethodInterval;
        public Boolean bookConference;
        public Integer cycleInterval;
        public Integer duration;
        public List<SenderCallerInfos> senderCallerInfos;
        public Integer contactCycles;
        public String language;
        public Boolean recipientApp;
        public String senderEmail;
        public Boolean confirm;

    }
    
    public class FormVariableItems {
        public String variableName;
        public Boolean isRequired;
        public Integer seq;
        public Long variableId;
        public List<String> val;

        
    }
    
    public class FormTemplate {
        public String subject;
        public String preMessage;
        public String postMessage;
        public List<FormVariableItems> formVariableItems;

    }
    
    public class BroadcastContacts {
        public List<Long> contactIds;
        public String contactSearchType;
    }
    
    public class MobileSettings {
        public Boolean requestComment;
        public Boolean requestImage;
        public Boolean requestLocation;
        public Boolean allowShare;
        public Boolean requireConfirm;
        public Boolean pushAlertEnabled;

    }
    
    public class DeliverPaths {
        public Integer accountId;
        public Long pathId;
        public Integer organizationId;
        public Integer awarePathId;
        public Long id;
        public Boolean expose;
        public Boolean isDefault;
        public Boolean mandatory;
        public Integer resourceBundleId;
        public Boolean editable;
        public Integer seq;
        public Integer lastModifiedId;
        public Integer createdId;
        public Boolean extRequired;
        public Boolean displayFlag;
        public Boolean default_Z;// in json: default

    }
    
    public class SenderCallerInfos {
        public String countryName;
        public Integer accountId;
        public String countryCode;
        public Integer resourceBundleId;
        public Integer organizationId;
        public Integer id;
        public String callerId;
        public Boolean isDefault;
        public Integer createdId;
        public Integer lastModifiedId;

    }
    
    public class PhaseDefinitions {
        public Integer id;
        public String status;
        public Boolean isDefault;
        public String Name;
        public Integer seq;

    }
    
    public class PhaseTemplates {
        public Integer templateId;
        public String Name;
        public Integer messageFlag;
        public Integer contactsFlag;
        public Integer settingsFlag;
        public List<PhaseDefinitions> phaseDefinitions;
        public FormTemplate formTemplate;
        public BroadcastTemplate broadcastTemplate;

    }
    
    public static BMCRF_Parser_phaseTemplate parse(String json) {
        return (BMCRF_Parser_phaseTemplate) System.JSON.deserialize(json, BMCRF_Parser_phaseTemplate.class);
    }

}