public class BMCRF_Model_IncidentVariableItems {

    public class ExtProperties {
        public String rows;
        public String cols;
    }

    public String message;
    public String firstPageUri;
    public String nextPageUri;
    public String lastPageUri;
    public Page1 page1;

    public class Data {
        public Long id;
        public String name;
        public Integer seq;
        public String varType;
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
        public ExtProperties extProperties;
        public List<VariableOptions> variableOptions;
    }

    public class Page1 {
        public Integer pageSize;
        public Integer start;
        public List<Data> data;
        public Integer totalCount;
        public Integer totalPageCount;
        public Integer currentPageNo;
    }

    public class VariableOptions {
        public String txt;
        public String val;
        public Integer seq;
        public Boolean isSelected;
    }

    
    public static BMCRF_Model_IncidentVariableItems parse(String json) {
        return (BMCRF_Model_IncidentVariableItems) System.JSON.deserialize(json, BMCRF_Model_IncidentVariableItems.class);
    }
}