/**
* Assign to Me functionality on Incident object
* @author  Ranjit Gandhi
* @version 2.0, Oct 2014
*/ 

public class AcceptIncident {
    List<BMCServiceDesk__Incident__c> ListIncident;
    public ApexPages.StandardController standardController;
    
    public AcceptIncident(ApexPages.StandardController standardController)
    {
        this.standardController = standardController;
    }
    
    public  PageReference AssigntoMe()
    {
        PageReference p=null;
        // Apex code for handling record from a Detail page goes here
        //Id recordId = ApexPages.currentPage().getParameters().get('incidentid');
        String incidentnum = ApexPages.currentPage().getParameters().get('incidentid');
        ListIncident=[select id from BMCServiceDesk__Incident__c where name=:incidentnum limit 1];
        Id recordId=ListIncident[0].id;
        System.debug('*************recordId****************'+recordId);
        BMCServiceDesk__Incident__c record = [select ownerId,BMCServiceDesk__FKOpenBy__c,BMCServiceDesk__respondedDateTime__c,BMCServiceDesk__FKStatus__c from BMCServiceDesk__Incident__c where id=:recordId];
        String idstr=String.valueOf(record.OwnerId);
        System.debug('*************record****************'+record);
        System.debug('*************idstr.substring(0,3)****************'+idstr.substring(0,3));
        String QueueName;
        List<Group> listgrp=[select id,name from Group where id=:record.ownerId];
        if (listgrp.size()>0)
            QueueName=listgrp[0].name;
        
        String u=UserInfo.getUserId();
        System.debug('*************user****************'+u);
        if(idstr.substring(0,3)=='00G')
        {
            List<GroupMember> gmlist=[select userorGroupID from GroupMember where GroupID=:record.OwnerId and UserorGroupID=:u];
            System.debug('*************gmlist****************'+gmlist);
            Boolean strpopup=true;
            if(gmlist.size()>0)
            {
                if(record.BMCServiceDesk__respondedDateTime__c==null)
                {
                    record.BMCServiceDesk__respondedDateTime__c=System.Datetime.now();
                    
                }
                if(record.BMCServiceDesk__FKOpenBy__c==null || record.BMCServiceDesk__FKOpenBy__c==UserInfo.getUserId())
                {
                    for(integer i=0;i<gmlist.size();i++)
                    {
                        Id statusAccepted=[select id from BMCServiceDesk__Status__c where name='ACCEPTED'].id; 
                        if(record.BMCServiceDesk__FKOpenBy__c==gmlist[i].userorGroupID)
                        {
                            
                            
                            if(record.BMCServiceDesk__FKOpenBy__c==UserInfo.getUserId())
                            {
                                if(record.BMCServiceDesk__FKStatus__c!=statusAccepted)
                                {
                                    record.BMCServiceDesk__FKStatus__c= statusAccepted;
                                    update record;
                                    System.debug('Updated status-Accepted-Already Assigned to me');  
                                }
                                System.debug('Already Assigned to me'); 
                                //String incidentlink=System.URL.getSalesforceBaseUrl().toExternalForm() +'/'+record.Id+'?isdtp=vw';
                                Apexpages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO,''+'This Incident is already assigned to you.'));
                                //Apexpages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO,''+'Click <a target="_blank" height="50" width="200"  href="'+incidentlink+'">here </a> to review the incident record.'));
                                //p=null;
                                break;
                            }
                            
                            /*Id updatedQueue=record.OwnerId;
if(initialQueue!=updatedQueue)
{
Id statusOpened=[select id from BMCServiceDesk__Status__c where name='OPENED'].id; 
record.BMCServiceDesk__FKStatus__c=statusOpened;
update record;
}*/
                            
                            
                            
                        }   
                        else if(record.BMCServiceDesk__FKOpenBy__c==null)
                        {
                            record.BMCServiceDesk__FKOpenBy__c=Userinfo.getUserId();
                            //BMCServiceDesk__FKStatus__c
                            
                            record.BMCServiceDesk__FKStatus__c= statusAccepted;
                            //Id initialQueue=record.OwnerId;
                            
                            update record;
                            System.debug('updated-Assigned to me now');
                            //p=new PageReference('/'+recordId);
                            //String incidentlink=System.URL.getSalesforceBaseUrl().toExternalForm()+'/servlet/servlet.Integration?lid=01rE0000000Mon8&amp;ic=1' ;
                            Apexpages.addMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM,''+'Success: This Incident is currently assigned to you.'));
                            //Apexpages.addMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM,''+'Click <a height="50" width="200" " href="'+incidentlink+'">here </a> to view list of incidents.'));
                            //p=null;
                            break;
                        }                     
                    }
                }
                else
                {
                    System.debug('This ticket has already been assigned to a Staff member. Please refresh your screen');
                    //String incidentlink=System.URL.getSalesforceBaseUrl().toExternalForm() +'/'+record.Id+'?isdtp=vw';
                    //https://cs8.salesforce.com/a1TL0000000YtroMAC?isdtp=vw
                    //+'/AcceptActionIncident?incidentid=a1TL0000000Ytro&isdtp=vw&sfdcIFrameOrigin=https%3A%2F%2Fcs8.salesforce.com';
                    //+'/apex/RemedyforceConsole#';
                    //apex/AcceptActionIncident?incidentid=a1TL0000000Ytro
                    //https://cs8.salesforce.com/servlet/servlet.Integration?lid=01rE0000000MUX3&amp;ic=1
                    //
                    
                    Apexpages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO,''+'This ticket has already been assigned to a Staff member.'));
                    //Apexpages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO,''+'Click <a target="_blank" height="50" width="200"  href="'+incidentlink+'">here </a> to review the incident record.'));
                    //record.addError('This ticket has already been assigned to a Staff member. Please refresh your screen');                              
                    //p=null;        
                }
            }
            else
            {
                System.debug('Error: You are not a member of the queue assigned to this ticket');
                //String incidentlink=System.URL.getSalesforceBaseUrl().toExternalForm()+'/servlet/servlet.Integration?lid=01rE0000000Mon8&amp;ic=1' ;
                //ApexPages.currentPage().getHeaders().get('Host')+Apexpages.currentPage().getUrl();
                //'https://cs8.salesforce.com/servlet/servlet.Integration?lid=01rE0000000MUX3&amp;ic=1'; 
                
                Apexpages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,''+'Error: You are not a member of the '+QueueName+' queue assigned to this ticket.'));
                //Apexpages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,''+'Click <a target="_blank" height="50" width="200"  href="'+incidentlink+'">here </a> to go back.'));
                //record.addError('Error: You are not a member of the queue assigned to this ticket');
                //p=null;
            }                   
            
        }
        else
        {
            //String incidentlink=System.URL.getSalesforceBaseUrl().toExternalForm() +'/'+record.Id; 
            
            
            //System.debug('Error: This ticket is not assigned to a queue. It must be assigned to a queue first in order to use this button.');
            Apexpages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,''+'Error: This ticket is not assigned to a queue. It must be assigned to a queue first in order to use this button.'));
            //Apexpages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,''+'Click <a height="50" width="200"  href="'+incidentlink+'">here </a> to go back.'));
            //p=null;
        }
        
        return p;
    }
}