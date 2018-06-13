trigger ChangeTaskCount on BMCServiceDesk__Task__c (after insert, after delete, after update) {
    ID ChangeID;
    ID OldChgID;
    ID NewChgID;
    Integer TotalTasks = 0;
    
    if (Trigger.isDelete) {
        for (BMCServiceDesk__Task__c TK : Trigger.old){
            ChangeID = TK.BMCServiceDesk__FKChange__c;
            OldChgID = TK.BMCServiceDesk__FKChange__c;
        }
    }
    
    if (Trigger.isInsert) {
        for (BMCServiceDesk__Task__c TK : Trigger.new){
            ChangeID = TK.BMCServiceDesk__FKChange__c;
            NewChgID = TK.BMCServiceDesk__FKChange__c;
        }
    }
  
    if (Trigger.isUpdate) {
        for (BMCServiceDesk__Task__c TK : Trigger.old){
			ChangeID = TK.BMCServiceDesk__FKChange__c;
            OldChgID = TK.BMCServiceDesk__FKChange__c;
            for (BMCServiceDesk__Task__c TK2 : Trigger.new){
                NewChgID = TK2.BMCServiceDesk__FKChange__c;
            }
		}
        if (ChangeID == null) {
            ChangeID = NewChgID;
        }
    }
    
    if (OldChgID != NewChgID || Trigger.isInsert){
        if (ChangeID != null){
            TotalTasks = [SELECT COUNT() FROM BMCServiceDesk__Task__c where BMCServiceDesk__FKChange__c = :ChangeID];

            BMCServiceDesk__Change_Request__c CR = [SELECT Number_of_Linked_Tasks__c FROM BMCServiceDesk__Change_Request__c WHERE Id = :ChangeID LIMIT 1];
            if (CR.Number_of_Linked_Tasks__c != TotalTasks){
                CR.Number_of_Linked_Tasks__c = TotalTasks;
                update CR;
            }
        }
    }
}