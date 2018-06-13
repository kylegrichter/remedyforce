trigger PageOnUpdate on BMCServiceDesk__Incident__c ( before update ) {
	/*
    for ( BMCServiceDesk__Incident__c IR : Trigger.new ){
          string Owner = IR.OwnerID;
          //This makes sure owner is a Queue not a user. All QueueID start with 00G
          if ( Owner.startsWith('00G') ){
              ID oldImpact = trigger.oldMap.get(IR.Id).BMCServiceDesk__FKImpact__c;
              ID newImpact = trigger.newMap.get(IR.Id).BMCServiceDesk__FKImpact__c;  
              ID oldUrgency = trigger.oldMap.get(IR.Id).BMCServiceDesk__FKUrgency__c;
              ID newUrgency = trigger.newMap.get(IR.Id).BMCServiceDesk__FKUrgency__c;  
              ID oldQueue = trigger.oldMap.get(IR.Id).OwnerID;
              ID newQueue = trigger.newMap.get(IR.Id).OwnerID;
              if ( oldImpact != newImpact || oldUrgency != newUrgency || oldQueue != newQueue ){
                  //Get Impact and Urgency ID for High/High  
                  //Id HighImpact = [SELECT Id FROM BMCServiceDesk__Impact__c        
                  //                 where Name = 'HIGH' limit 1].Id;
                  Id HighImpact = 'a1PE0000000D8RjMAK';            
                  //Id HighUrgency = [SELECT Id FROM BMCServiceDesk__Urgency__c        
                  //                  where Name = 'HIGH' limit 1].Id;                           
                  Id HighUrgency = 'a2GE0000000H9qRMAS';
                  if ( IR.BMCServiceDesk__FKImpact__c == HighImpact && IR.BMCServiceDesk__FKUrgency__c == HighUrgency ){
                     //Ticket has been escalated to P1 - Send Message to (X)Matters
                     send2Xmatters.postTicketID(IR.ID);
                  }
              }
         }  
    }
	*/
}