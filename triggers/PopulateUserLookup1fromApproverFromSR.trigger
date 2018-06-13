trigger PopulateUserLookup1fromApproverFromSR on BMCServiceDesk__Incident__c (before insert, before update) {
	for ( BMCServiceDesk__Incident__c IR : Trigger.new ){
		String IrNum = IR.Name;
        String SrApprover = IR.Approver_From_SR__c;
		if ( IR.BMCServiceDesk__FKBusinessService__c == 'a0GE000000CrdYEMAZ' ){
			IR.User_FKLookup_1__c = IR.Approver_From_SR__c;
			}
		}
}