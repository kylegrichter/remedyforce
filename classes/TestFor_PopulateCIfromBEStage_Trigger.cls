@isTest (SeeAllData = true) 
public class TestFor_PopulateCIfromBEStage_Trigger {
    public static testmethod void TestTriggers1(){
        Id APIUser = [SELECT Id FROM USER WHERE Name = 'RemForce API'].Id;
        Id OtherUser = [SELECT Id FROM USER WHERE Name = 'RemedyForceSystemUse Only'].Id;
        string DBA_ServiceID = [SELECT Id FROM BMCServiceDesk__BMC_BaseElement__c WHERE Name = 'Database Administration' limit 1].Id;
        BMCServiceDesk__BMC_BaseElement__c BaseElement = new BMCServiceDesk__BMC_BaseElement__c (
            Name = 'TEST',
            BMCServiceDesk__InstanceID__c = 'INST-1',
            BMCServiceDesk__Name__c = 'TEST',
            FKTrustee_ID_1__c = APIUser,
            FKTrustee_ID_2__c = APIUser                                                     
        ); 
        Insert BaseElement;                                                     
        BMCServiceDesk__Category__c CATEGORY = new BMCServiceDesk__Category__c ( 
            Name = 'TEST',
            BMCServiceDesk__AvailableForIncidents__c = true
        );
        Insert CATEGORY;
        BMCServiceDesk__Impact__c IMPACT = new BMCServiceDesk__Impact__c ( Name = 'TEST' );                                           
        Insert IMPACT;
        BMCServiceDesk__Urgency__c URGENCY = new BMCServiceDesk__Urgency__c ( Name = 'TEST' );                                           
        INSERT URGENCY;                                     
        BMCServiceDesk__Incident__c IR1 = new BMCServiceDesk__Incident__c ( 
            BMCServiceDesk__FKCategory__c        = CATEGORY.Id,
            BMCServiceDesk__FKImpact__c          = IMPACT.Id,
            BMCServiceDesk__FKUrgency__c         = URGENCY.Id,
            BMCServiceDesk__FKBusinessService__c = DBA_ServiceID,
            Base_Element_Stage__c                = 'TEST',
            On_Behalf_Of_Client__c = OtherUser
        );
        Insert IR1;
    }
    public static testmethod void TestTriggers2(){
        Id OtherUser = [SELECT Id FROM USER WHERE Name = 'RemedyForceSystemUse Only'].Id;
        string PrdCrtl_ServiceID = [SELECT Id FROM BMCServiceDesk__BMC_BaseElement__c WHERE Name = 'Production Control Tech Svs' limit 1].Id;
        BMCServiceDesk__BMC_BaseElement__c Batch_BaseElement = new BMCServiceDesk__BMC_BaseElement__c ( 
            Name = 'PrdCrtlTEST-Batch',
            BMCServiceDesk__Name__c = 'PrdCrtlTEST-Batch'
        ); 
        Insert Batch_BaseElement; 
        BMCServiceDesk__Category__c CATEGORY = new BMCServiceDesk__Category__c ( 
            Name = 'TEST',
            BMCServiceDesk__AvailableForIncidents__c = true
        );
        Insert CATEGORY;
        BMCServiceDesk__Impact__c IMPACT = new BMCServiceDesk__Impact__c ( Name = 'TEST' );                                           
        Insert IMPACT;
        BMCServiceDesk__Urgency__c URGENCY = new BMCServiceDesk__Urgency__c ( Name = 'TEST' );                                           
        INSERT URGENCY;                                     
        BMCServiceDesk__Incident__c IR2 = new BMCServiceDesk__Incident__c ( 
            BMCServiceDesk__FKCategory__c        = CATEGORY.Id,
            BMCServiceDesk__FKImpact__c          = IMPACT.Id,
            BMCServiceDesk__FKUrgency__c         = URGENCY.Id,
            BMCServiceDesk__FKBusinessService__c = PrdCrtl_ServiceID,
            Base_Element_Stage__c                = 'PrdCrtlTEST',
            On_Behalf_Of_Client__c = OtherUser
        );
        Insert IR2;
    }
    public static testmethod void TestTriggers3(){
        Id APIUser = [SELECT Id FROM USER WHERE Name = 'RemForce API'].Id;
        Id OtherUser = [SELECT Id FROM USER WHERE Name = 'RemedyForceSystemUse Only'].Id;
        string PrdCrtl_ServiceID = [SELECT Id FROM BMCServiceDesk__BMC_BaseElement__c WHERE Name = 'Production Control Tech Svs' limit 1].Id;
        BMCServiceDesk__BMC_BaseElement__c BaseElement3 = new BMCServiceDesk__BMC_BaseElement__c (
            Name = 'TEST3-Batch',
            BMCServiceDesk__InstanceID__c = 'INST-3',
            BMCServiceDesk__Name__c = 'TEST3-Batch',
            FKTrustee_ID_1__c = APIUser
        );
        Insert BaseElement3;
        BMCServiceDesk__Category__c CATEGORY = new BMCServiceDesk__Category__c ( 
            Name = 'TEST',
            BMCServiceDesk__AvailableForIncidents__c = true
        );
        Insert CATEGORY;
        BMCServiceDesk__Impact__c IMPACT = new BMCServiceDesk__Impact__c ( Name = 'TEST' );                                           
        Insert IMPACT;
        BMCServiceDesk__Urgency__c URGENCY = new BMCServiceDesk__Urgency__c ( Name = 'TEST' );                                           
        INSERT URGENCY;                                     
        BMCServiceDesk__Incident__c IR3 = new BMCServiceDesk__Incident__c ( 
            BMCServiceDesk__FKCategory__c        = CATEGORY.Id,
            BMCServiceDesk__FKImpact__c          = IMPACT.Id,
            BMCServiceDesk__FKUrgency__c         = URGENCY.Id,
            BMCServiceDesk__FKBusinessService__c = PrdCrtl_ServiceID,
            Base_Element_Stage__c                = 'TEST3',
            On_Behalf_Of_Client__c = OtherUser
        );
        Insert IR3;
    }
    public static testmethod void TestTriggers4(){
        Id OtherUser = [SELECT Id FROM USER WHERE Name = 'RemedyForceSystemUse Only'].Id;
        string PrdCrtl_ServiceID = [SELECT Id FROM BMCServiceDesk__BMC_BaseElement__c WHERE Name = 'Production Control Tech Svs' limit 1].Id;
        BMCServiceDesk__BMC_BaseElement__c BaseElement4 = new BMCServiceDesk__BMC_BaseElement__c (
            Name = 'TEST\\\\TEST4-Batch',
            BMCServiceDesk__InstanceID__c = 'INST-4',
            BMCServiceDesk__Name__c = 'TEST\\\\TEST4-Batch'                                              
        ); 
        Insert BaseElement4;
        BMCServiceDesk__Category__c CATEGORY = new BMCServiceDesk__Category__c ( 
            Name = 'TEST',
            BMCServiceDesk__AvailableForIncidents__c = true
        );
        Insert CATEGORY;
        BMCServiceDesk__Impact__c IMPACT = new BMCServiceDesk__Impact__c ( Name = 'TEST' );                                           
        Insert IMPACT;
        BMCServiceDesk__Urgency__c URGENCY = new BMCServiceDesk__Urgency__c ( Name = 'TEST' );                                           
        INSERT URGENCY;                                     
        BMCServiceDesk__Incident__c IR4 = new BMCServiceDesk__Incident__c ( 
            BMCServiceDesk__FKCategory__c        = CATEGORY.Id,
            BMCServiceDesk__FKImpact__c          = IMPACT.Id,
            BMCServiceDesk__FKUrgency__c         = URGENCY.Id,
            BMCServiceDesk__FKBusinessService__c = PrdCrtl_ServiceID,
            Base_Element_Stage__c                = 'TEST\\TEST4',
            On_Behalf_Of_Client__c = OtherUser
        );
        Insert IR4;
    }
}