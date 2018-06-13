public class BMCRF_Model_Condition
{
    public list<expressions> expressions;
    public list<logicals> logicals;
    
    public class logicals{
        public String value;
    }
    
    public class expressions{
        public String value;
        public String operator;
        public String attribute;
    }
    public static BMCRF_Model_Condition parse(String json) {
        return (BMCRF_Model_Condition) System.JSON.deserialize(json, BMCRF_Model_Condition.class);
    }
}