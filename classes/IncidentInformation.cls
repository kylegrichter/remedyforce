/******************************************************************************
Name:  IncidentInformation
Copyright © 2013  DexMedia Inc. 
==============================================================================
Purpose:                                                            
This is the Class is to Host the Service that TIBCO can create an IR,can 
Search by Number,can Search by Description from Service Cloud.
==============================================================================
History                                                            
-------                                                            
VERSION     AUTHOR              DATE           DETAIL           FEATURES/CSR/TTP
------      ------              -----         ---------         -----------------
1.0     Guru R. Vattam    05/08/2013    Initial Development
2.0     Jason D. Boyer    06/17/2013    Per SR#00070198 - Adding Status and Source
                                                                   to Search By Description
3.0     Jason D. Boyer    08/07/2013    Per SR#00113203 - Adding IR Number, Customer ID        <-- See a trend? Somone needs to get their requirments 
                                                                   Closed Date, Resolution                                                                 in order before writing code. As of this entry Service 
                                                                   Support Group, Opened Date                                                         Cloud still has not made a production run and we                                                                           
                                                                   Expected Due Date                                                                           allrady have 2 code revisions. These doesn't address a damn thing 
                                                                                                                                                                                 other than poor planning.
4.0    Guru R. Vattam     05/05/2014        US4949               Adding Vision CompanyId Company Name to the service request.                                                      
*****************************************************************************/


global class IncidentInformation {
     
   //This method is to search the Incident by Incident Number
    global class incidentInfo {
    
        webservice string Description;
        webservice string Status;
        webservice string ClientId;
        webservice string IR_Number;
        webservice string IR_Customer_ID;
        webservice string IR_Company_ID;//4.0
        webservice string IR_Company_Name;//4.0
        webservice string IR_Support_Group;
        webservice string IR_Resolution;        

        webservice Datetime IR_Opened_Date;
        webservice Datetime IR_Expected_Due_Date;
        webservice Datetime IR_Closed_Date;
                        
    }  
       
     WebService static incidentInfo  searchByNumber( string IncidentNo ) {

        string incidentId    = IncidentNo;
        incidentId           = incidentId.trim();
        incidentInfo retInfo = new incidentInfo();
        
        BMCServiceDesk__Incident__c incObj = [ SELECT Id, Name, BMCServiceDesk__FKClient__r.Name, BMCServiceDesk__incidentDescription__c,
                                               BMCServiceDesk__FKStatus__r.Name, Cust_ID__c,Company_ID__c,Business_Name__c, Support_Group__c, BMCServiceDesk__incidentResolution__c, 
                                               BMCServiceDesk__openDateTime__c, Expected_Due_By_Date__c, BMCServiceDesk__closeDateTime__c 
                                               FROM BMCServiceDesk__Incident__c where Name=: incidentId ];                      
        if( incObj.Name != null ){
        
           retInfo.Description            = incObj.BMCServiceDesk__incidentDescription__c;
           retInfo.Status                 = incObj.BMCServiceDesk__FKStatus__r.Name;
           retInfo.ClientId               = incObj.BMCServiceDesk__FKClient__r.Name;
           retInfo.IR_Number              = incObj.Name;
           retInfo.IR_Customer_ID         = incObj.Cust_ID__c;
           retInfo.IR_Company_ID          = incObj.Company_ID__c;//4.0
           retInfo.IR_Company_Name        = incObj.Business_Name__c;//4.0
           retInfo.IR_Support_Group       = incObj.Support_Group__c;
           retInfo.IR_Resolution          = incObj.BMCServiceDesk__incidentResolution__c;
           retInfo.IR_Opened_Date         = incObj.BMCServiceDesk__openDateTime__c;
           retInfo.IR_Expected_Due_Date   = incObj.Expected_Due_By_Date__c;
           retInfo.IR_Closed_Date         = incObj.BMCServiceDesk__closeDateTime__c;
           
        }
        
        return retInfo;  

   }   
   
   //########################################
   //This method is to create a new Incident 
   //########################################    
   global class IncidentInfoFields {
   
      webservice string Category;
      webservice string Impact;
      webservice string Urgency;
      webservice string IncidentSource;
      webservice string OwnerId;
      webservice string FedID;
      webservice String Description;
      webservice string CustomerId;
      webservice string CompanyId;//4.0
      webservice string CompanyName;//4.0
      webservice string IncidentTitle;
      webservice string IR_CI;
      webservice string IR_Code_Group;
      webservice string IR_Support_Group;
      
   }  
    webservice static string InsertNewIncident( IncidentInfoFields ifo ){
    
      BMCServiceDesk__Incident__c inc = new BMCServiceDesk__Incident__c();
        inc.BMCServiceDesk__incidentDescription__c = ifo.Description.trim();     

      BMCServiceDesk__Category__c cat = database.query('select id from BMCServiceDesk__Category__c where Name=\''+ifo.Category.trim()+'\' limit 1');
        inc.BMCServiceDesk__FKCategory__c = cat.Id;
 
      BMCServiceDesk__Impact__c imp = database.query('select id from BMCServiceDesk__Impact__c where   Name=\''+ifo.Impact.trim()+'\' limit 1');
        inc.BMCServiceDesk__FKImpact__c = imp.Id;
        
      BMCServiceDesk__Urgency__c ugr = database.query('select id from BMCServiceDesk__Urgency__c where Name=\''+ifo.Urgency.trim()+'\' limit 1');
        inc.BMCServiceDesk__FKUrgency__c = ugr.Id;
      
      Group QueueId = database.query('SELECT Id FROM Group WHERE Type = \'Queue\' AND Name = \''+ifo.OwnerId.trim()+'\' LIMIT 1 ');      
        system.debug('QueueId.Id --------'+QueueId.Id);
        inc.OwnerId = QueueId.Id; 

        
      User usrclk = database.query('select id,V_Z_ID_del__c from User where V_Z_ID_del__c=\''+ifo.FedID.trim()+'\' limit 1');
        inc.BMCServiceDesk__FKClient__c = usrclk.Id;
   
      //Configuration Item
      BMCServiceDesk__BMC_BaseElement__c CI = database.query( 'SELECT Id FROM BMCServiceDesk__BMC_BaseElement__c where Name=\''+ifo.IR_CI.trim()+'\' limit 1');
        inc.BMCServiceDesk__FKBMC_BaseElement__c = CI.Id;  
      
      //Code Group ifo.IR_Code_Group;
      inc.Code_Group__c = ifo.IR_Code_Group;

      //Support Group ifo.IR_Support_Group;
      inc.Support_Group__c = ifo.IR_Support_Group;
      
      //Source
      inc.BMCServiceDesk__contactType__c = ifo.IncidentSource.trim();
      
      //Cust ID
      inc.Cust_ID__c = ifo.CustomerId;
      
      //Company ID//4.0
      inc.Company_ID__c = ifo.CompanyId;
      
      //Company Name//4.0
      inc.Business_Name__c = ifo.CompanyName;
      
      //Title
      inc.Incident_Title__c = ifo.IncidentTitle;
           
      insert inc;
      
      //Get the IR Number of the ticket that was created
      BMCServiceDesk__Incident__c incno = [select Id,Name from BMCServiceDesk__Incident__c where id=:inc.id];
      return string.valueof(incno.Name);
           
    }
   
    //#################################################    
    // This method is to search Incident By Description
    //#################################################        
    global class IncidentDescriptionList{
      
      webservice string incident_No;
      webservice string Description;
      webservice string Status;
      webservice string Source;
      
      public IncidentDescriptionList ( string no, string descp, string status, string source ){
     
         this.incident_No = no;
         this.Description = descp;
         this.Status = status;
         this.Source = source;
      
      }
      
    }
    webservice static List<IncidentDescriptionList> searchByDescription( string strDescp){
      List<IncidentDescriptionList> retlist = new List<IncidentDescriptionList>();
      
      string str = 'FIND \''+strDescp+'\' IN ALL FIELDS RETURNING BMCServiceDesk__Incident__c( Id, Name, BMCServiceDesk__incidentDescription__c, BMCServiceDesk__Status_ID__c, BMCServiceDesk__contactType__c ) limit 10';
      List<List<BMCServiceDesk__Incident__c>> SearchList = search.query(str);
      
      for( List<BMCServiceDesk__Incident__c> outList : SearchList){ 

         for( BMCServiceDesk__Incident__c inc : outList ){
           retlist.add(new IncidentDescriptionList( inc.Name, inc.BMCServiceDesk__incidentDescription__c, inc.BMCServiceDesk__Status_ID__c, inc.BMCServiceDesk__contactType__c ));
         }
      
      }
      
      return retlist;
    
    }
    
}