@IsTest
public class BMCRF_Model_RecordType_Test {
    
    static testMethod void testParse() {
        String json = '{'+
        '\"status\": \"A\",'+
        '\"createdId\": 233109349990401,'+
        '\"createdName\": \"Everbridge Admin\",'+
        '\"lastModifiedId\": 233109349990401,'+
        '\"lastModifiedName\": \"Everbridge Admin\",'+
        '\"createdDate\": 1347679012909,'+
        '\"lastModifiedDate\": 1347679012909,'+
        '\"organizationId\": 8800387989534,'+
        '\"id\": 8800387989534,'+
        '\"Name\": \"Employee\",'+
        '\"recordType\": \"DEFAULT\"'+
        '}';
        BMCRF_Model_RecordType obj = BMCRF_Model_RecordType.parse(json);
        System.assert(obj != null);
    }
}