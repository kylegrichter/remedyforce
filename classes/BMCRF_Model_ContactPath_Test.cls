@IsTest
public class BMCRF_Model_ContactPath_Test {
    
    // This test method should give 100% coverage
    static testMethod void testParse() {
        String json = '{'+
        '\"status\": \"A\",'+
        '\"createdId\": 8800387989515,'+
        '\"createdName\": \"Misher Yang\",'+
        '\"lastModifiedId\": 4402341478419,'+
        '\"lastModifiedName\": \"orgleader yang\",'+
        '\"createdDate\": 1347679952331,'+
        '\"lastModifiedDate\": 1353658522367,'+
        '\"organizationId\": 8800387989534,'+
        '\"id\": 4402341478438,'+
        '\"awarePathId\": 1682252,'+
        '\"pathId\": 241901148045325,'+
        '\"prompt\": \"Mobile Member App\",'+
        '\"seq\": 1,'+
        '\"isDefault\": true,'+
        '\"expose\": false,'+
        '\"mandatory\": false,'+
        '\"editable\": false,'+
        '\"sysPrompt\": \"Mobile Member App\",'+
        '\"code\": \"RECIP\",'+
        '\"type\": \"RECIP\",'+
        '\"pathFlag\": 0,'+
        '\"messageCode\": \"E\",'+
        '\"confirmType\": \"REPLY_TO\",'+
        '\"formatFlag\": \"P\",'+
        '\"pathDeliveryType\": \"T\",'+
        '\"extRequired\": false,'+
        '\"displayFlag\": true,'+
        '\"pathType\": \"RECIP\",'+
        '\"default\": true'+
        '}';
        BMCRF_Model_ContactPath r = BMCRF_Model_ContactPath.parse(json);
        System.assert(r != null);
    }
}