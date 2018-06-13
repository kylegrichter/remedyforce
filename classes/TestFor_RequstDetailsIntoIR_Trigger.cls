@isTest (seealldata = true)
public class TestFor_RequstDetailsIntoIR_Trigger {

  public static testmethod void TestTriggers(){
  
                                                 
   
  // Next we need a Request Definition Record to make the IR a SR
     BMCServiceDesk__SRM_RequestDefinition__c RequestDefinition = 
          new BMCServiceDesk__SRM_RequestDefinition__c(Name='ForTest', 
                                                       BMCServiceDesk__serviceRequestTitle__c = 'ForTest'); 
  insert RequestDefinition;
     
  // Need a Request Detail record
     BMCServiceDesk__SRM_RequestDetail__c RequestDetail = 
        new BMCServiceDesk__SRM_RequestDetail__c(BMCServiceDesk__FKRequestDefinition__c = RequestDefinition.Id ); 
        insert RequestDetail;                                                    
 
  
  // Next is create Request Detail Input Record with ReqDefFkId
     BMCServiceDesk__SRM_RequestDetailInputs__c RequestDetailInputs = 
            new BMCServiceDesk__SRM_RequestDetailInputs__c(BMCServiceDesk__Input__c = 'Question',
                BMCServiceDesk__StoredValue__c = 'StoredTest' , 
                BMCServiceDesk__FKRequestDetail__c = RequestDetail.Id
            
                 );
     insert RequestDetailInputs;
                                                        
   //Create the Incident Record
    BMCServiceDesk__Incident__c Incident =
        new BMCServiceDesk__Incident__c(BMCServiceDesk__FKRequestDefinition__c = RequestDefinition.Id,
                                        BMCServiceDesk__FKRequestDetail__c = RequestDetail.Id
                                        
                                        );
    
    insert Incident;
    update Incident;

  }


}