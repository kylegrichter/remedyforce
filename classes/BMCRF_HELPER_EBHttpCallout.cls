public class BMCRF_HELPER_EBHttpCallout
{
    
    BMCRF_EB_Incident_Configuration__c EB_Config;
    
    public BMCRF_HELPER_EBHttpCallout()
    {
        EB_Config = [select ID, BMCRF_Everbridge_Webhook_URL__c, BMCRF_Everbridge_Organization_ID__c, BMCRF_Everbridge_Username__c, 
                           BMCRF_Everbridge_Password__c, BMCRF_Everbridge_API_URL_Base__c, BMCRF_Everbridge_External_ID_Field__c
                              from BMCRF_EB_Incident_Configuration__c limit 1];
                              
    }
    
    
    public String call(String body,String method, String param1,String param2,String param3)
    {
        String JSONString='## HTTP Callout Failed ##';
        String baseuri = EB_Config.BMCRF_Everbridge_API_URL_Base__c;
        String uname_Password = EB_Config.BMCRF_Everbridge_Username__c + ':' + EB_Config.BMCRF_Everbridge_Password__c ;
        Blob toBlob = Blob.valueOf(uname_Password);
        String credentials = 'Basic '+ EncodingUtil.base64Encode(toBlob);
        String OraganizationId = EB_Config.BMCRF_Everbridge_Organization_ID__c;
        
        HttpRequest req = new HttpRequest();
        //set base url based on the parameter passed
        if(String.isEmpty(param2) && String.isEmpty(param3))
            req.setEndpoint(baseuri+'/'+param1+'/'+OraganizationId+'/');    
        else if(String.isEmpty(param3))
            req.setEndpoint(baseuri+'/'+param1+'/'+OraganizationId+'/'+param2);    
        else
            req.setEndpoint(baseuri+'/'+param1+'/'+OraganizationId+'/'+param2+'/'+param3);    
            
        req.setMethod(method);

        if(method=='POST' || method=='PUT')
            req.setBody(body);
            
        req.setHeader('Content-Type', 'application/json');
        req.setHeader('Authorization', credentials);
        req.setHeader('organizationId', OraganizationId);
        req.setTimeout(20000);
        Http h = new Http();
        HttpResponse res = new HttpResponse();
        
        try{
            res = h.send(req);
        }
        catch(Exception e)
        {
            system.debug('## Callout Exception ##'+ res+' excp: '+e );
        }
        if(res.getStatusCode() == 200)
            JSONString=res.getBody();
        else{
            JSONString='## HTTP Callout Failed ##';
            system.debug(JSONString+ res.getBody());
        }
            
        return JSONString;
    }
}