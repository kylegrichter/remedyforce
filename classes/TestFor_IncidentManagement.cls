@isTest (SeeAllData = true)
public class TestFor_IncidentManagement {
    
    public static testmethod void IncidentManagement_Main() {
        
        //Use the PageReference Apex class to instantiate a page
        PageReference pageRef = Page.OperationsIncidentReport;
        
        //In this case, the Visualforce page named 'success' is the starting point of this test method. 
        Test.setCurrentPage(pageRef);
        Test.setCurrentPageReference(pageRef);
        
        //Instantiate and construct the controller class.   
        IncidentManagement controller = new IncidentManagement();
        controller.getranges();
        controller.getrange();        
        controller.getcountsMonitored();
        
        controller.getopsIncidents();
        controller.getcountsTotal();
        
        ApexPages.currentPage().getParameters().put('range', '.75');
        ApexPages.currentPage().getParameters().put('print', 'yes');
        
        controller.getopsIncidents();
        controller.getcountsMonitored();
        
        controller.setrange(.75);
        
        controller.getopsIncidents();
        controller.getcountsMonitored();
    }
	public static testmethod void IncidentManagement_RangeNull() {
        
        //Use the PageReference Apex class to instantiate a page
        PageReference pageRef = Page.OperationsIncidentReport;
        
        //In this case, the Visualforce page named 'success' is the starting point of this test method. 
        Test.setCurrentPage(pageRef);
        Test.setCurrentPageReference(pageRef);
        
        //Instantiate and construct the controller class.   
        IncidentManagement controller = new IncidentManagement();
        controller.getranges();
        controller.getrange();
        
        controller.getopsIncidents();
        controller.getcountsTotal();
		
        controller.getopsIncidents();
    }
	public static testmethod void IncidentManagement_RangeNull2() {
        
        //Use the PageReference Apex class to instantiate a page
        PageReference pageRef = Page.OperationsIncidentReport;
        
        //In this case, the Visualforce page named 'success' is the starting point of this test method. 
        Test.setCurrentPage(pageRef);
        Test.setCurrentPageReference(pageRef);
        
        //Instantiate and construct the controller class.   
        IncidentManagement controller = new IncidentManagement();
        controller.getranges();
        controller.getrange();
        
        controller.getcountsTotal();
		controller.getopsIncidents();
		
        controller.getopsIncidents();
    }
	public static testmethod void IncidentManagement_RangeDefined() {
        
        //Use the PageReference Apex class to instantiate a page
        PageReference pageRef = Page.OperationsIncidentReport;
        
        //In this case, the Visualforce page named 'success' is the starting point of this test method. 
        Test.setCurrentPage(pageRef);
        Test.setCurrentPageReference(pageRef);
        
        //Instantiate and construct the controller class.   
        IncidentManagement controller = new IncidentManagement();
		
        ApexPages.currentPage().getParameters().put('range', '3');
        ApexPages.currentPage().getParameters().put('print', 'yes');
		
        controller.getranges();
        controller.getrange();
		
        controller.getcountsTotal();
        
        controller.getopsIncidents();
        controller.getcountsMonitored();
    }
}