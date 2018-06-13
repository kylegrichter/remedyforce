@IsTest
public class BMCRF_Model_IncidentTemplate_Test{
    
    static testMethod void testParse() {
        String json = '{'+
        '  \"message\" : \"OK\",'+
        '  \"firstPageUri\" : \"https://api.everbridge.net/rest/incidentTemplates/453003085612786/?page1Number=1\",'+
        '  \"lastPageUri\" : \"https://api.everbridge.net/rest/incidentTemplates/453003085612786/?page1Number=1\",'+
        '  \"page1\" : {'+
        '    \"page1Size\" : 10,'+
        '    \"start\" : 0,'+
        '    \"data\" : [ {'+
        '      \"id\" : 1323816294812794,'+
        '      \"name\" : \"External Service Outage (Client Notification)\",'+
        '      \"templateStatus\" : \"Live\",'+
        '      \"accountId\" : 892807736722576,'+
        '      \"status\" : \"A\",'+
        '      \"createdId\" : 3083034899266633,'+
        '      \"createdName\" : \"Lisa Radley_ITADemo\",'+
        '      \"lastModifiedId\" : 3083034899266633,'+
        '      \"lastModifiedName\" : \"Lisa Radley_ITADemo\",'+
        '      \"createdDate\" : 1444919498023,'+
        '      \"lastModifiedDate\" : 1444920262778,'+
        '      \"organizationId\" : 453003085612786,'+
        '      \"resourceBundleId\" : 453003085613479,'+
        '      \"category\" : {'+
        '        \"id\" : 1323816294810222,'+
        '        \"name\" : \"Outage\"'+
        '      }'+
        '    }, {'+
        '      \"id\" : 444206992589693,'+
        '      \"name\" : \"Integration Template\",'+
        '      \"templateStatus\" : \"Live\",'+
        '      \"accountId\" : 892807736722576,'+
        '      \"status\" : \"A\",'+
        '      \"createdId\" : 3083034899266633,'+
        '      \"createdName\" : \"Lisa Radley_ITADemo\",'+
        '      \"lastModifiedId\" : 3083034899266633,'+
        '      \"lastModifiedName\" : \"Lisa Radley_ITADemo\",'+
        '      \"createdDate\" : 1441111671161,'+
        '      \"lastModifiedDate\" : 1444923321539,'+
        '      \"organizationId\" : 453003085612786,'+
        '      \"resourceBundleId\" : 453003085613479,'+
        '      \"category\" : {'+
        '        \"id\" : 444206992589006,'+
        '        \"name\" : \"ITSM\"'+
        '      }'+
        '    }, {'+
        '      \"id\" : 1323816294812792,'+
        '      \"name\" : \"Internal Service Outage (Company-wide Notification)\",'+
        '      \"templateStatus\" : \"Live\",'+
        '      \"accountId\" : 892807736722576,'+
        '      \"status\" : \"A\",'+
        '      \"createdId\" : 3083034899266633,'+
        '      \"createdName\" : \"Lisa Radley_ITADemo\",'+
        '      \"lastModifiedId\" : 3083034899266633,'+
        '      \"lastModifiedName\" : \"Lisa Radley_ITADemo\",'+
        '      \"createdDate\" : 1444917742093,'+
        '      \"lastModifiedDate\" : 1444918026572,'+
        '      \"organizationId\" : 453003085612786,'+
        '      \"resourceBundleId\" : 453003085613479,'+
        '      \"category\" : {'+
        '        \"id\" : 1323816294810222,'+
        '        \"name\" : \"Outage\"'+
        '      }'+
        '    }, {'+
        '      \"id\" : 1323816294812793,'+
        '      \"name\" : \"Office Closing Notice\",'+
        '      \"templateStatus\" : \"Live\",'+
        '      \"accountId\" : 892807736722576,'+
        '      \"status\" : \"A\",'+
        '      \"createdId\" : 3083034899266633,'+
        '      \"createdName\" : \"Lisa Radley_ITADemo\",'+
        '      \"lastModifiedId\" : 3083034899266633,'+
        '      \"lastModifiedName\" : \"Lisa Radley_ITADemo\",'+
        '      \"createdDate\" : 1444918671480,'+
        '      \"lastModifiedDate\" : 1444918671480,'+
        '      \"organizationId\" : 453003085612786,'+
        '      \"resourceBundleId\" : 453003085613479,'+
        '      \"category\" : {'+
        '        \"id\" : 1323816294810223,'+
        '        \"name\" : \"Office Status\"'+
        '      }'+
        '    } ],'+
        '    \"totalCount\" : 4,'+
        '    \"totalPageCount\" : 1,'+
        '    \"currentPageNo\" : 1'+
        '  }'+
        '}';
        BMCRF_Model_IncidentTemplate obj = BMCRF_Model_IncidentTemplate.parse(json);
        System.assert(obj != null);
    }
}