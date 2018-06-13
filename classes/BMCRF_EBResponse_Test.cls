@isTest
public class BMCRF_EBResponse_Test
{
    static testMethod void test()
    {    
        String Json='{ "message": "OK", "id": 470595271666991, "baseUri": "https://api.everbridge.net/rest/incidents/453003085612786/", "instanceUri": "https://api.everbridge.net/rest/incidents/453003085612786/470595271666991" }';
        BMCRF_EBResponse.parse(Json);
    }
}