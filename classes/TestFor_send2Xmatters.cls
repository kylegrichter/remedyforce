@isTest(SeeAllData=true)
public class TestFor_send2Xmatters  {
    
    static testMethod void testFutureCall2Xmatters(){   
           
    
           BMCServiceDesk__Incident__c AnyExistingIR = [SELECT Id, Name
                                                        FROM BMCServiceDesk__Incident__c 
                                                        LIMIT 1];
           
           Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator_200());
           Test.startTest();
           send2Xmatters.postTicketID(AnyExistingIR.ID);
           Test.stopTest();
           
    }
    
    
}