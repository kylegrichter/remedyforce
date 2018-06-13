public class BMCRF_Model_Group {

    public Integer createdId;
    public Integer lastModifiedId;
    public String lastModifiedName;
    public Long lastModifiedDate;
    public Integer organizationId;
    public Long id;
    public String name;
    public Long parentId;
    public Integer lastModifiedTime;
    public Integer lastSynchronizedTime;
    public Boolean dirty;

    
    public static BMCRF_Model_Group parse(String json) {
        return (BMCRF_Model_Group) System.JSON.deserialize(json, BMCRF_Model_Group.class);
    }
}