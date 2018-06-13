@IsTest
private class ApprovalRequestCommentsControllerTest {
 
    @IsTest
    private static void test_get_comments() {
 
        // As of 12/31/2014, Salesforce does not provide us ability
        // to create ProcessInstance or ProcessInstanceStep records,
        // so there is no way to test this *correctly* without actually
        // submitting a record through an actual approve process.
        // However, this does get 100% code coverage =/
        
        ApprovalRequestCommentsController contr = new ApprovalRequestCommentsController();
        System.debug( contr.comments );
        System.debug( contr.stepstatus );
        System.debug( contr.actorid );
        System.debug( contr.actorname );
        System.debug( contr.actorphone );
        System.debug( contr.originalactorid );
        System.debug( contr.originalactorname );
        System.debug( contr.originalactorphone );
        System.debug( contr.processinstanceid );
        System.debug( contr.stepnodeid );
 
    }
    
}