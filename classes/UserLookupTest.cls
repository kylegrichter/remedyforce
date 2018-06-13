@isTest (SeeAllData = true)
public class UserLookupTest
{
    
    public static testmethod void UserLookupTest1() 
    {
        //Use the PageReference Apex class to instantiate a page
        PageReference pageRef = Page.NewRFRequest;
        
        Test.setCurrentPage(pageRef);
        
        //Instantiate and construct the controller class.   
        UserLookup  controller = new UserLookup ();
        
        controller.UserLookupId=[select FederationIdentifier from User where isActive=true and FederationIdentifier!=null and Primary_Queue_Assignment__c !='null' and Primary_Queue_Assignment__c !='' order by FederationIdentifier DESC limit 1].FederationIdentifier ;
        
        List<User> u_User=controller.getUserInfoRecord();
        List<User> u_User2=controller.getUserSearchList();
        List<User> u_User3=controller.getLanSearchList();
        List<BMCServiceDesk__Incident__c> u_UserIRs=controller.getUserIncidents();
        
        controller.beginning();
        controller.previous();
        controller.next();
        controller.end();
        controller.getprev();
        controller.getnxt();
        
        controller.beginningLan();
        controller.previousLan();
        controller.nextLan();
        controller.endLan();
        controller.getprevLan();
        controller.getnxtLan();
    }
    
}