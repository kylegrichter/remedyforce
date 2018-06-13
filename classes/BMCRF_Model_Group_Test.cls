@IsTest
public class BMCRF_Model_Group_Test {
    
    static testMethod void testParse() {
        String json = '{'+
        '\"createdId\": 0,'+
        '\"lastModifiedId\": 0,'+
        '\"lastModifiedName\": \"Misher Yang\",'+
        '\"lastModifiedDate\": 1350539824820,'+
        '\"organizationId\": 0,'+
        '\"id\": 241896853078067,'+
        '\"Name\": \"This group is rad\",'+
        '\"parentId\": 241896853078066,'+
        '\"lastModifiedTime\": 0,'+
        '\"lastSynchronizedTime\": 0,'+
        '\"checked\": false,'+
        '\"dirty\": true'+
        '}';
        BMCRF_Model_Group obj = BMCRF_Model_Group.parse(json);
        System.assert(obj != null);
    }
}