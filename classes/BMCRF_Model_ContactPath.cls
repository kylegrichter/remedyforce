public class BMCRF_Model_ContactPath {
    
    public String message;  //OK
    public String firstPageUri; //https://api.everbridge.net/rest/contactPaths/453003085612786/?pageNumber=1
    public String lastPageUri;  //https://api.everbridge.net/rest/contactPaths/453003085612786/?pageNumber=1
    public page1 page1;
    public class page1 {
        public Integer pageSize;    //6
        public Integer start;   //1
        public data[] data;
        public Integer totalCount;  //6
        public Integer totalPageCount;  //1
        public Integer currentPageNo;   //1
    }
    public class data {
        public Long accountId;   //892807736722576
        public Long pathId;  //241901148045325
        public Long organizationId;  //453003085612786
        public Long awarePathId; //29130309
        public Long id;  //444206992591362
        public boolean expose;
        public boolean isDefault;
        public Long createdDate; //1441111357477
        public String createdName;  //Lisa Radley_ITADemo
        public String status;   //A
        public boolean mandatory;
        public Long resourceBundleId;    //453003085613479
        public boolean editable;
        public Integer seq; //1
        public Long lastModifiedDate;    //1444922318635
        public Long lastModifiedId;  //3083034899266633
        public Long createdId;   //3083034899266633
        public String prompt;   //Mobile App
        public String lastModifiedName; //Lisa Radley_ITADemo
        public String sysPrompt;    //Mobile Member App
        public String code; //RECIP
        public String type; //RECIP
        public Long pathFlag;    //0
        public String messageCode;  //E
        public String confirmType;  //REPLY_TO
        public String formatFlag;   //P
        public String pathDeliveryType; //T
        public boolean extRequired;
        public boolean displayFlag;
        public String pathType; //RECIP
        public boolean default1;
    }
    
    public static BMCRF_Model_ContactPath parse(String json) {
        return (BMCRF_Model_ContactPath) System.JSON.deserialize(json, BMCRF_Model_ContactPath.class);
    }
}