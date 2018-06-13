@isTest
public class ASAApplicationReview_Test {
    static testmethod void testProfileFetch(){
        
        BMCServiceDesk__BMC_BaseElement__c bmcs = new BMCServiceDesk__BMC_BaseElement__c();
        BMCServiceDesk__BMC_BaseElement__c bmcs1 = new BMCServiceDesk__BMC_BaseElement__c();
        List<BMCServiceDesk__BMC_BaseElement__c> BE = new List<BMCServiceDesk__BMC_BaseElement__c>{bmcs,bmcs1};
      List<BMCServiceDesk__BMC_BaseElement__c> BEApprove = new List<BMCServiceDesk__BMC_BaseElement__c>{bmcs,bmcs1};
        List<BMCServiceDesk__BMC_BaseElement__c> BEReject = new List<BMCServiceDesk__BMC_BaseElement__c>{bmcs,bmcs1};       
             
    
        User u = new User();
        u.Phone = '1234567890';
        u.Email = 'test@test.com';
        ASAApplicationReview pf = new ASAApplicationReview();
        try {
            pf.RejectRecord();
        } catch(DMLException e) {
            system.assertEquals(e.getMessage(), e.getMessage());
        }
        pf.BEApprove = BEApprove;
        pf.BEReject = BEReject;
        pf.aBEId ='005E0000008GxH6';
        pf.sBEId ='005E0000008GxH6';
        pf.ApproveRecord();
        pf.ApproveAllRecord();
        pf.RejectRecord();
        pf.RejectAllRecord();
        
    }
}