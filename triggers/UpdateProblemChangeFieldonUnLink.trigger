trigger UpdateProblemChangeFieldonUnLink on BMCServiceDesk__Change_Problem_Link__c ( after delete ) {
   
   for ( BMCServiceDesk__Change_Problem_Link__c LINK : Trigger.old ){
         Id ChangeId = LINK.BMCServiceDesk__FKChange__c;
         Id ProblemID = LINK.BMCServiceDesk__FKProblem__c;
         
         BMCServiceDesk__Change_Request__c ChangeNumber = [ SELECT Name 
                                                            FROM BMCServiceDesk__Change_Request__c
                                                            WHERE Id = :ChangeId ];
                 
         List<BMCServiceDesk__Problem__c> ProblemArray = [ SELECT Id, Name, Change_Record__c  
                                                           FROM BMCServiceDesk__Problem__c
                                                           WHERE Id = :ProblemID ];
         
         if (!ProblemArray.isEmpty()) {
             BMCServiceDesk__Problem__c ProblemTicket=ProblemArray[0];
      
             if ( ProblemTicket.Change_Record__c == ChangeNumber.Name ){
                  ProblemTicket.Change_Record__c = '';
                  ProblemTicket.CR_Release_Code__c = '';
                  update ProblemTicket;
             }
      
         }
     
          
     } 


}