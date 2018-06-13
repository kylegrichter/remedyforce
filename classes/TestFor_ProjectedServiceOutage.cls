@isTest (SeeAllData = true)
public class TestFor_ProjectedServiceOutage {
    
    public static testmethod void ProjectedServiceOutage() {
        
        //Use the PageReference Apex class to instantiate a page
        PageReference pageRef = Page.FutureSystemDowntime;
        
        //In this case, the Visualforce page named 'success' is the starting point of this test method. 
        Test.setCurrentPage(pageRef);
        
        //Instantiate and construct the controller class.   
        ProjectedServiceOutage controller = new ProjectedServiceOutage();
        
        //Instantiate a new controller with all parameters in the page
        controller = new ProjectedServiceOutage(); 
        
        //Example of calling the 'setter' method for several properties. 
        //Normally these setter methods are initiated by a user interacting with the Visualforce page, 
        //but in a test method, just call the setter method directly. 
        controller.getanswers();
        controller.getoutages();
        controller.getoutagesCal();
        
        String outage=[select id from BMCServiceDesk__Projected_Service_Outage__c limit 1].id;
        
        ApexPages.currentPage().getParameters().put('wkid', outage);
        controller.getoutages();
        
        ApexPages.currentPage().getParameters().put('answer', 'NEXT_N_DAYS:30');
        controller.getoutages();
        
        controller.getanswer();
        controller.setanswer('A');              
        
        controller.SendEmail();        
    }
}