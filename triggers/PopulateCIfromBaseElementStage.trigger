trigger PopulateCIfromBaseElementStage on BMCServiceDesk__Incident__c ( before insert, before update ) {
    System.Debug('START PopulateCIfromBaseElementStage');
    List<BMCServiceDesk__Incident__c> IncidentList = new List<BMCServiceDesk__Incident__c>();
    Map<String, BMCServiceDesk__BMC_BaseElement__c> BEMap = new Map<String, BMCServiceDesk__BMC_BaseElement__c>();
    for ( BMCServiceDesk__Incident__c IR : Trigger.new ){
        if ( IR.Base_Element_Stage__c != null ){
            IncidentList.add(IR);
        }
    }
    System.Debug('Loaded IncidentList for Processing');
    if ( IncidentList.size() > 0 ) {
        System.Debug('IncidentList is greater than 0');
        string DBA_ServiceID = [SELECT Id FROM BMCServiceDesk__BMC_BaseElement__c where Name = 'Database Administration' limit 1].Id;
        string PrdCrtl_ServiceID = [SELECT Id FROM BMCServiceDesk__BMC_BaseElement__c where Name = 'Production Control Tech Svs' limit 1].Id;
        string DB_SecurityReqDefID = [SELECT Id FROM BMCServiceDesk__SRM_RequestDefinition__c where Name = 'Database Security' limit 1].Id;
        Id APIUser = [ SELECT Id FROM USER WHERE Name = 'RemForce API'].Id;
        System.Debug('Loading BEMap');
        List<BMCServiceDesk__BMC_BaseElement__c> BaseElementList = [SELECT Id, Name, FKTrustee_ID_1__c, FKTrustee_ID_2__c, Post_Approval_Queue_Assignment__c, Post_Approval_Email_Notification__c FROM BMCServiceDesk__BMC_BaseElement__c WHERE BMCServiceDesk__ClassName__c != 'ASA Application Access'];
        for ( BMCServiceDesk__BMC_BaseElement__c BE : BaseElementList ){
            BEMap.put(BE.Name, BE);
        }
        System.Debug('BEMap Loaded');
        System.Debug('Looping through IncidentList');
        for ( BMCServiceDesk__Incident__c IR : IncidentList ){
            string BEStageName = IR.Base_Element_Stage__c;
            System.debug('BMCServiceDesk__FKBusinessService__c '+IR.BMCServiceDesk__FKBusinessService__c );
            if ( IR.BMCServiceDesk__FKBusinessService__c == PrdCrtl_ServiceID ){
                BEStageName = BEStageName +  '-Batch';
            }
            if(BEStageName.contains('\\')){
                BEStageName=BEStageName.replace('\\','\\\\');
                System.debug(BEStageName.replace('\\','\\\\'));
            }               
            System.debug('BEStageName '+ BEStageName );
            if ( BEMap.containsKey(BEStageName) ){
                IR.BMCServiceDesk__FKBMC_BaseElement__c = BEMap.get(BEStageName).Id;
                if ( BEMap.get(BEStageName).FKTrustee_ID_1__c == null && IR.BMCServiceDesk__FKBusinessService__c != DBA_ServiceID ){
                    IR.User_FKLookup_1__c = APIUser;
                    IR.User_FKLookup_2__c = APIUser;
                } else if ( BEMap.get(BEStageName).FKTrustee_ID_1__c != null && BEMap.get(BEStageName).FKTrustee_ID_2__c == null && IR.BMCServiceDesk__FKBusinessService__c != DBA_ServiceID ){
                    IR.User_FKLookup_1__c = BEMap.get(BEStageName).FKTrustee_ID_1__c;
                    IR.User_FKLookup_2__c = APIUser;
                } else {
                    IR.User_FKLookup_1__c = BEMap.get(BEStageName).FKTrustee_ID_1__c;
                    IR.User_FKLookup_2__c = BEMap.get(BEStageName).FKTrustee_ID_2__c;
                }
                IR.Post_Approval_Email_Notification__c = BEMap.get(BEStageName).Post_Approval_Email_Notification__c;    
                IR.Post_Approval_Queue_Assignment__c = BEMap.get(BEStageName).Post_Approval_Queue_Assignment__c;
                IR.Base_Element_Stage__c = '';
            }
        }
    }
    System.Debug('END PopulateCIfromBaseElementStage');
}