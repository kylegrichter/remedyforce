@isTest
public class BMCRF_Model_IncidentVariableItems_Test
{
    static testMethod void test()
    {
        String json='{ "message": "OK", "firstPageUri": "https://api.everbridge.net/rest/incidentVariableItems/453003085612786/?pageNumber=1", "nextPageUri": "https://api.everbridge.net/rest/incidentVariableItems/453003085612786/?pageNumber=2", "lastPageUri": "https://api.everbridge.net/rest/incidentVariableItems/453003085612786/?pageNumber=3", "page": { "pageSize": 10, "start": 0, "data": [   { "id": 10002, "name": "Notification Status", "seq": 0, "varType": "Textbox", "variableOptions": [ { "txt": "{phaseStatus}", "val": "{phaseStatus}", "seq": 0, "isSelected": false } ], "accountId": 0, "status": "A", "createdId": 0, "lastModifiedId": 0, "organizationId": -1, "resourceBundleId": 0 }  ], "totalCount": 26, "totalPageCount": 3, "currentPageNo": 1 } }';
        Test.startTest();
        BMCRF_Model_IncidentVariableItems.parse(json);
        Test.stopTest();
    }
}