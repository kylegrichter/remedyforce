@isTest (SeeAllData = true) 
  
public class TestFor_PopulateCIfromBaseElementStage {
          public static testmethod void TestTriggers(){
            string DBA_ServiceID = [SELECT Id FROM BMCServiceDesk__BMC_BaseElement__c        
                        where Name = 'Database Administration' limit 1].Id;

             string PrdCrtl_ServiceID = [SELECT Id FROM BMCServiceDesk__BMC_BaseElement__c        
                            where Name = 'Production Control Tech Svs' limit 1].Id;                         
                            
             string DB_SecurityReqDefID = [SELECT Id FROM BMCServiceDesk__SRM_RequestDefinition__c        
                              where Name = 'Database Security' limit 1].Id;
             
             Id APIUser = [ SELECT Id
                            FROM USER
                            WHERE Name = 'RemForce API'].Id; 
              
              Id BaseElementId= [SELECT id FROM BMCServiceDesk__BMC_BaseElement__c where name like '%DataBase%' limit 1].id;
              //String BMCServiceDesk__FKBusinessService__c= [select BMCServiceDesk__FKBusinessService__c from BMCServiceDesk__Incident__c where BMCServiceDesk__FKBusinessService__c=:BaseElementId].BMCServiceDesk__FKBusinessService__c;
             
              String BEStageName=[select name from BMCServiceDesk__BMC_BaseElement__c where name like '%- DataBase%' limit 1].name;
              }
              
}