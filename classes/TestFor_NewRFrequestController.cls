@isTest (SeeAllData = true)
public class TestFor_NewRFrequestController 
{
    
    public static testmethod void TestNewRFrequestController() 
    {
        //Use the PageReference Apex class to instantiate a page
        PageReference pageRef = Page.NewRFRequest;
       
        Test.setCurrentPage(pageRef);
        
        //Instantiate and construct the controller class.   
        NewRFrequestController  controller = new NewRFrequestController ();
        
        controller.NwUser=[select FederationIdentifier from User where isActive=true and FederationIdentifier!=null and Primary_Queue_Assignment__c !='null' and Primary_Queue_Assignment__c !='' order by FederationIdentifier DESC limit 1].FederationIdentifier ;
        
        controller.ReplicateLike=[select FederationIdentifier from User where isActive=true and FederationIdentifier!=null and Primary_Queue_Assignment__c !='null' and Primary_Queue_Assignment__c !='' order by FederationIdentifier ASC limit 1].FederationIdentifier ;
        
        //controller.ReplicateLike=[select FederationIdentifier from User where isActive=true and name like '%Kyle Rich%' limit 1].FederationIdentifier ;
        
        List<User> u_NewUser=controller.getNewU();
        List<User> u_getReplicateU=controller.getReplicateU();
        
        List<PermissionSetAssignment> psa= controller.getPermissionSetReplicateLikeUser();
        List<PermissionSetAssignment> psnu= controller.getPermissionSetNewUser();
        
        controller.changeProfile();
        controller.changeRole();
        controller.changeServiceDeskStaff();
        controller.AddPrimaryQueue();
        controller.sendEMailNwuser();
        
        controller.updateAll();
        controller.getQueueReplicateLikeUser();
        controller.getQueueNewUser();
        controller.ReplacePermissionSet();
        controller.AssignQueue();
        controller.RemoveQueue();
        controller.ReplaceQueue();
        String pl1;
        if(psa.size()>1)
        {
        pl1=psa[0].PermissionSetId;
        }
        String newu1=controller.NwUser;
        System.currentPageReference().getParameters().put('p1',pl1 );
        System.currentPageReference().getParameters().put('p2', newu1 );
        PageReference vp= controller.AssignPermissionSet();
        
              
        //controller.NwUser=[select FederationIdentifier from User where isActive=true limit 1].FederationIdentifier ;
        //controller.ReplicateLike=[select FederationIdentifier from User where isActive=true and Primary_Queue_Assignment__c!=null and Primary_Queue_Assignment__c !='' and Primary_Queue_Assignment__c !='null' limit 1].FederationIdentifier ;
        
        controller.AddPrimaryQueue();
        
        User u=[select id from User where name like '%Levei%' limit 1];
        System.runas(u)
        {
        vp=controller.RemovePermissionSet();
        }
    
    }
    
     public static testmethod void TestNewRFrequestController1() 
    {
        //Use the PageReference Apex class to instantiate a page
        PageReference pageRef = Page.NewRFRequest;
       
        Test.setCurrentPage(pageRef);
        
        //Instantiate and construct the controller class.   
        NewRFrequestController  controller = new NewRFrequestController ();
        
        controller.NwUser=[select FederationIdentifier from User where isActive=true and FederationIdentifier!=null and Primary_Queue_Assignment__c !='null' and Primary_Queue_Assignment__c !='' order by FederationIdentifier DESC limit 1].FederationIdentifier ;
        
        controller.ReplicateLike=[select FederationIdentifier from User where isActive=true and FederationIdentifier!=null and Primary_Queue_Assignment__c !='null' and Primary_Queue_Assignment__c !='' order by FederationIdentifier ASC limit 1].FederationIdentifier ;
        
        //controller.ReplicateLike=[select FederationIdentifier from User where isActive=true and name like '%Kyle Rich%' limit 1].FederationIdentifier ;
        
        List<User> u_NewUser=controller.getNewU();
        List<User> u_getReplicateU=controller.getReplicateU();
        
        List<PermissionSetAssignment> psa= controller.getPermissionSetReplicateLikeUser();
        List<PermissionSetAssignment> psnu= controller.getPermissionSetNewUser();
        
        String pl1; 
        if(psa.size()>0) 
        { pl1=psa[0].PermissionSetId;
        
        }
        String newu1=controller.NwUser;
        
        System.currentPageReference().getParameters().put('p2', newu1 );
                System.currentPageReference().getParameters().put('p1',pl1 );
             
            
        PageReference vp=controller.RemovePermissionSet();
        
    
    }
    
 }