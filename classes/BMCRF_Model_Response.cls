public class BMCRF_Model_Response {

    public String message;
    public Long id;
    public String baseUri;
    public String instanceUri;
    public String code;
    
    public static BMCRF_Model_Response parse(String json) {
        return (BMCRF_Model_Response) System.JSON.deserialize(json, BMCRF_Model_Response.class);
    }
}