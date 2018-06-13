@IsTest
public class BMCRF_Model_Contact_Test {
    
    static testMethod void testParse() {
        String json = '{'+
        '\"status\": \"A\",'+
        '\"createdId\": 999,'+
        '\"createdName\": \"misher\",'+
        '\"lastModifiedId\": 4402341478419,'+
        '\"lastModifiedName\": \"orgleader yang\",'+
        '\"createdDate\": 1347680995522,'+
        '\"lastModifiedDate\": 1347683401632,'+
        '\"organizationId\": 8800387989534,'+
        '\"id\": 13198434500612,'+
        '\"firstName\": \"misher\",'+
        '\"lastName\": \"yang\",'+
        '\"recordTypeId\": 8800387989534,'+
        '\"recordTypeName\": \"Employee\",'+
        '\"externalId\": \"8061531088291120750\",'+
        '\"paths\": ['+
        '{'+
        '\"pathId\": 241901148045319,'+
        '\"value\": \"15910631550\",'+
        '\"countryCode\": \"CN\",'+
        '\"waitTime\": 0,'+
        '\"priority\": 0'+
        '},'+
        '{'+
        '\"pathId\": 241901148045316,'+
        '\"value\": \"misher@hypersun.com\",'+
        '\"waitTime\": 0,'+
        '\"priority\": 0'+
        '},'+
        '{'+
        '\"pathId\": 241901148045325,'+
        '\"value\": \"yes\",'+
        '\"waitTime\": 0,'+
        '\"priority\": 0'+
        '}]'+
        ','+
        '\"groups\": ['+
        '4402341478403,'+
        '4402341478404,'+
        '4402341478405'+
        '],'+
        '\"address\": ['+
        '{'+
        '\"streetAddress\": \"a\",'+
        '\"state\": \"Arizona\",'+
        '\"country\": \"US\",'+
        '\"locationName\": \"Home\",'+
        '\"gisLocation\": {'+
        '\"lon\": 77.9,'+
        '\"lat\": 38'+
        '},'+
        '\"source\": \"MANUAL\"'+
        '}]'+
        ','+
        '\"geoSearchAddress\": ['+
        '{'+
        '\"streetAddress\": \"a\",'+
        '\"state\": \"Arizona\",'+
        '\"country\": \"US\",'+
        '\"locationName\": \"Home\",'+
        '\"gisLocation\": {'+
        '\"lon\": 77.9,'+
        '\"lat\": 38'+
        '},'+
        '\"source\": \"MANUAL\"'+
        '}]'+
        ','+
        '\"uploadProcessing\": false,'+
        '\"topics\": ['+
        '4402341478419,'+
        '4402341478420,'+
        '4402341478421,'+
        '4402341478422,'+
        '4402341478423,'+
        '4402341478424,'+
        '4402341478425,'+
        '4402341478426,'+
        '4402341478427,'+
        '4402341478428,'+
        '4402341478429'+
        '],'+
        '\"individualAccountId\": 13198434500612,'+
        '\"lastModifiedTime\": 1347682437292'+
        '}';
        BMCRF_Model_Contact obj = BMCRF_Model_Contact.parse(json);
        System.assert(obj != null);
    }
}