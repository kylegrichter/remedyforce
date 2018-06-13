@IsTest
public class BMCRF_Model_Response_Test {
    
    static testMethod void testParse() {
        String json = '{'+
        '  \"message\": \"OK\",'+
        '  \"id\": 5308485088578357,'+
        '  \"baseUri\": \"https://api.everbridge.net/rest/contacts/453003085612786/\",'+
        '  \"instanceUri\": \"https://api.everbridge.net/rest/contacts/453003085612786/5308485088578357\"'+
        '}';
        BMCRF_Model_Response obj = BMCRF_Model_Response.parse(json);
        System.assert(obj != null);
    }
}