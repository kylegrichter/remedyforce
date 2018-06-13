public class send2Xmatters {
    @future (callout=true)
    public static void postTicketID( string TicketID ){
      
      string orgID = UserInfo.getOrganizationId();
      string Prod_OrgID = '00DE0000000caBtMAI';

      //Test for Prod
      //orgID = Prod_OrgID; 
      
      string endpointurl;

      HttpRequest req = new HttpRequest();
      HttpResponse res = new HttpResponse();
      Http http = new Http();
     
      endpointurl = 'https://xmatrf.supermedia.com/agent'; 

      if ( orgID != Prod_OrgID ) {
        endpointurl = 'https://xmatrf-qa.supermedia.com/agent';      
      }
      
      req.setEndpoint(endpointurl);
      req.setMethod('POST');
      req.setBody('mapdata=remedyforce&mapdata='+EncodingUtil.urlEncode( TicketID, 'UTF-8')+'&mapdata=testpass');
      //req.setCompressed(true); // otherwise we hit a limit of 32000
      string msg;
      
        try {
            res = http.send(req);
        } catch(System.CalloutException e) {
            System.debug('Callout error: '+ e);
            System.debug(res.toString());
            msg = e.getMessage();
        }
        string response = res.getBody();     
      //Add action to Ticket History        
      ID ActionID = [SELECT Id 
                     FROM BMCServiceDesk__Action__c 
                     WHERE Name = 'Message sent to XMatters'].Id;
      ID APIUserID = '005E00000027kY3IAI'; // RemForce API      
      
      BMCServiceDesk__IncidentHistory__c IRHistory 
           = new BMCServiceDesk__IncidentHistory__c ( BMCServiceDesk__FKIncident__c = TicketID,
                                                      BMCServiceDesk__FKAction__c   = ActionID,
                                                      BMCServiceDesk__FKUser__c     = APIUserID,
                                                      BMCServiceDesk__note__c       = 'Sent TicketID: ' + orgID + ' to X-Matters url: ' + endpointurl + ' Exc -> ' + msg + ' Resp -> ' + response 
                                                     );
     insert IRHistory; 
    }
    

}