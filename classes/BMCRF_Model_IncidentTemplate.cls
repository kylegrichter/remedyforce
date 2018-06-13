public class BMCRF_Model_IncidentTemplate {

    public class Category {
        public Long id;
        public String name;
    }

    public String message;
    public String firstPageUri;
    public String lastPageUri;
    public List<Data> data;
    public Page1 page1;

    public class Page1 {
        public Integer page1Size;
        public Integer start;
        public List<Data> data;
        public Integer totalCount;
        public Integer totalPageCount;
        public Integer currentPageNo;
    }

    public class Data {
        public Long id;
        public String name;
        public String templateStatus;
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
        public Category category;
    }

    
    public static BMCRF_Model_IncidentTemplate parse(String json) {
        return (BMCRF_Model_IncidentTemplate) System.JSON.deserialize(json, BMCRF_Model_IncidentTemplate.class);
    }

}