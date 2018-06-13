public class BMCRF_Model_Contact{

    public class GisLocation {
        public Double lon;
        public Integer lat;
    }

    public class Paths {
        public Long pathId;
        public String value;
        public String countryCode;
        //public Integer waitTime;
        //public Integer priority;
    }
    
    public class Address {
        public String streetAddress;
        public String state;
        public String country;
        public String locationName;
        public GisLocation gisLocation;
        public String source;
    }

    public String status;
    public Integer createdId;
    public String createdName;
    public Long lastModifiedId;
    public String lastModifiedName;
    public Long createdDate;
    public Long lastModifiedDate;
    public Long organizationId;
    public Long id;
    public String firstName;
    public String lastName;
    public Long recordTypeId;
//    public String recordTypeName;
    public String externalId;
    public List<Paths> paths;
    public List<Long> groups;
    public List<Address> address;
    //public List<Address> geoSearchAddress;
    public Boolean uploadProcessing;
    public List<Long> topics;
    public Long individualAccountId;
    public Long lastModifiedTime;

    public static BMCRF_Model_Contact parse(String json) {
        return (BMCRF_Model_Contact) System.JSON.deserialize(json, BMCRF_Model_Contact.class);
    }
}