public class BMCRF_EBResponse {
    public String message;
    public String id;
    public String baseUri;
    public String instanceUri;       
    
     public static BMCRF_EBResponse  parse(String json){
        return (BMCRF_EBResponse ) System.JSON.deserialize(json, BMCRF_EBResponse .class);
    }
    
}