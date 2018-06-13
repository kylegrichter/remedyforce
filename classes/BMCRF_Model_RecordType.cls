public class BMCRF_Model_RecordType {

    public String message;
    public String firstPageUri;
    public String lastPageUri;
    public Page1 Page1;

    public class Data {
        public String createdName;
        public Long accountId;
        public String fillColor;
        public String status;
        public Long resourceBundleId;
        public Long organizationId;
        public Integer cachedContactCount;
        public Long id;
        public String name;
        public Long lastModifiedDate;
        public Long createdId;
        public Long lastModifiedId;
        public String recordType;
        public Long createdDate;
        public String lastModifiedName;
    }

    public class Page1 {
        public Integer pageSize;
        public Integer start;
        public List<Data> data;
        public Integer totalCount;
        public Integer totalPageCount;
        public Integer currentPageNo;
    }

    
    public static BMCRF_Model_RecordType parse(String json) {
        return (BMCRF_Model_RecordType) System.JSON.deserialize(json, BMCRF_Model_RecordType.class);
    }
}