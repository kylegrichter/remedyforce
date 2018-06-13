trigger GetQueueOwnerAttributes on BMCServiceDesk__Incident__c ( before insert, before update ) {

    for ( BMCServiceDesk__Incident__c IR : Trigger.new ){
       
      
        if ( IR.Queue_Owner_Controller__c != null ){
           
            string QueueDevName = IR.Queue_Owner_Controller__c;
            
            Id APIUser = [SELECT Id
                          FROM USER
                          WHERE Name = 'RemForce API' ].Id;
           
           
            Queue_Extended_Attributes__c QEA = [ SELECT Queue_Name__c, Primary_Contact__c, Secondary_Contact__c 
                                                 FROM Queue_Extended_Attributes__c
                                                 WHERE Queue_Name__c = :QueueDevName 
                                                 LIMIT 1 ];

            if ( QEA.Primary_Contact__c == null ){
                 IR.User_FKLookup_1__c = APIUser;
                 IR.User_FKLookup_2__c = APIUser;
            }
            else if ( QEA.Primary_Contact__c != null && QEA.Secondary_Contact__c == null ){
                 IR.User_FKLookup_1__c = QEA.Primary_Contact__c;
                 IR.User_FKLookup_2__c = QEA.Primary_Contact__c;
            }
            else {
                 IR.User_FKLookup_1__c = QEA.Primary_Contact__c;
                 IR.User_FKLookup_2__c = QEA.Secondary_Contact__c;
            }

            IR.Queue_Owner_Controller__c = '';
            
     
        }   
    
    
    }


}