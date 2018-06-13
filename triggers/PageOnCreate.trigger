trigger PageOnCreate on BMCServiceDesk__Incident__c ( after insert ) {
	/*
    for ( BMCServiceDesk__Incident__c IR : Trigger.new ){
         // We only wan't this overhead for tickets created by Spectrum 
         if ( IR.BMCServiceDesk__contactType__c == 'Spectrum' ){
              //Get Impact and Urgency ID for High/High  
                Id HighImpact = [SELECT Id FROM BMCServiceDesk__Impact__c        
                                 where Name = 'HIGH' limit 1].Id;
                Id HighUrgency = [SELECT Id FROM BMCServiceDesk__Urgency__c        
                                  where Name = 'HIGH' limit 1].Id;
                string Owner = IR.OwnerID;
               //This makes sure owner is a Queue not a user. All QueueID start with 00G
               if ( IR.BMCServiceDesk__FKImpact__c == HighImpact && IR.BMCServiceDesk__FKUrgency__c == HighUrgency &&
                    Owner.startsWith('00G') ){
                    //Ticket Was created as a P1 Escalation and has Queue defined - Send Message to (X)Matters
                    send2Xmatters.postTicketID(IR.ID);
               }
               else if ( IR.Notification_Group__c != null ) {
                    //Ticket Was created as X Matters notification group was defined. - Send Message to (X)Matters
                    send2Xmatters.postTicketID(IR.ID);
               }
         } 
    }
	*/
}