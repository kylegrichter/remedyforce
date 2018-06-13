@isTest(SeeAllDAta=true)
public class AcceptIncident_Test {
    static testMethod void testAlreadyAssignToMe(){
        Test.startTest();
        
        // incident with owner as ownerid
        BMCServiceDesk__Category__c categ=[select id from BMCServiceDesk__Category__c where BMCServiceDesk__AvailableForIncidents__c = TRUE and BMCServiceDesk__AvailableForServiceCatalog__c = TRUE limit 1];
        BMCServiceDesk__Incident__c incidentinsert=new BMCServiceDesk__Incident__c(BMCServiceDesk__FKCategory__c=categ.id);
        insert incidentinsert;
        Test.setCurrentPageReference(new PageReference('Page.AcceptActionIncident'));
        String incidentIdnew=incidentinsert.id;
        String incidentnum=[select name from BMCServiceDesk__Incident__c where id=:incidentIdnew].name;
        System.currentPageReference().getParameters().put('incidentid', incidentnum);
        ApexPages.StandardController sc = new ApexPages.StandardController(incidentinsert);
        AcceptIncident a=new AcceptIncident(sc);
        try{
            a.AssigntoMe();
        } catch(Exception e){
            List<Apexpages.Message> msgs = ApexPages.getMessages();
            boolean b = false;
            for(Apexpages.Message msg:msgs){
                System.assertEquals(ApexPages.Severity.ERROR, msg.getSeverity()); if (msg.getDetail().contains('Search requires more characters')) b = true;
            }
        }
        
        //owner=Queue=RF       
        incidentinsert.BMCServiceDesk__FKImpact__c=[select id from BMCServiceDesk__Impact__c where Name = 'LOW' limit 1 ].id;
        incidentinsert.BMCServiceDesk__FKUrgency__c=[select id from BMCServiceDesk__Urgency__c limit 1].id;
        incidentinsert.ownerId=[select id from Group where name like 'Remedy%' limit 1].id;
        update incidentinsert;
        try{
            a.AssigntoMe();
        } catch(Exception e){
            List<Apexpages.Message> msgs = ApexPages.getMessages();
            boolean b = false;
            for(Apexpages.Message msg:msgs){
                System.assertEquals(ApexPages.Severity.ERROR, msg.getSeverity()); if (msg.getDetail().contains('Search requires more characters')) b = true;
            }
        }     
        
        //staff=null, RF Queue
        incidentinsert.BMCServiceDesk__FKOpenBy__c=null;
        update incidentinsert;
        try{
            a.AssigntoMe();
        } catch(Exception e){
            List<Apexpages.Message> msgs = ApexPages.getMessages();
            boolean b = false;
            for(Apexpages.Message msg:msgs){
                System.assertEquals('Have a nice day', msg.getSummary());
                System.assertEquals(ApexPages.Severity.ERROR, msg.getSeverity()); if (msg.getDetail().contains('Search requires more characters')) b = true;
            }
        }   

        Test.stopTest();
    }
}