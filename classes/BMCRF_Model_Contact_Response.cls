public class BMCRF_Model_Contact_Response {

    public String message;
    public String firstPageUri;
    public String lastPageUri;
    public Page1 page1;
    public List<Data> data;
    
    public class ContactAttributes {
        public List<String> values;
        public Long orgAttrId;
        public String name;
    }

    public class Paths_Y {
        public Integer waitTime;
        public String status;
        public Long pathId;
        public String countryCode;
        public String value;
    }

    

    public class Paths_Z {
        public Integer waitTime;
        public Long pathId;
        public String value;
        public String countryCode;
    }

    public class Data {
        public Long lastModifiedTime;
        public Long organizationId;
        public Long userId;
        public Long createdDate;
        public String createdName;
        public String lastName;
        public String status;
        public Long recordTypeId;
        public String lastModifiedName;
        public Integer accountId;
        public String externalId;
        public Long id;
        public List<Paths> paths;
        public String firstName;
        public Boolean uploadProcessing;
        public Integer resourceBundleId;
        public Long createdId;
        public Long lastModifiedId;
        public Long lastModifiedDate;
        public String country;
        public String registedEmail;
        public String registeredEmail;
        public List<Long> groups;
        public Long registedDate;
        public Long registeredDate;
        public List<ContactAttributes> contactAttributes;
        public Long individualAccountId;
    }

    public class Page1 {
        public Integer pageSize;
        public Integer start;
        public List<Data> data;
        public Integer totalCount;
        public Integer totalPageCount;
        public Integer currentPageNo;
    }

    public class Paths {
        public Integer waitTime;
        public Long pathId;
        public String value;
    }

    
    public static BMCRF_Model_Contact_Response parse(String json) {
        return (BMCRF_Model_Contact_Response) System.JSON.deserialize(json, BMCRF_Model_Contact_Response.class);
    }
}