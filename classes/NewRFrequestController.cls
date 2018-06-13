public class NewRFrequestController {
    public string NwUser{get;set;}
    public string ReplicateLike{get;set;}
    public Id PermSetId{get;set;}
    
    public NewRFrequestController(){
        if (string.isNotBlank(ApexPages.currentPage().getParameters().get('nwuser'))){
            NwUser = ApexPages.currentPage().getParameters().get('nwuser');
        }
        if (string.isNotBlank(ApexPages.currentPage().getParameters().get('replicatelike'))){
            ReplicateLike = ApexPages.currentPage().getParameters().get('replicatelike');
        }
    }
    
    public void updateAll(){
        changeProfile();
        changeRole();
        changeServiceDeskStaff();
        AddPrimaryQueue();
        ReplaceQueue();
        ReplacePermissionSet();
        sendEMailNwuser();
    }
    
    public List<User> getNewU(){
        list<User> u_NewUser;
        System.debug('NwUser'+NwUser);
        if(NwUser!=null && NwUser != 'null'&& NwUser != ''){
            u_NewUser=[select id, Primary_Queue_Assignment__c,name,FederationIdentifier,ProfileId,UserRoleId,ManagerId,BMCServiceDesk__IsStaffUser__c,isActive,Lan_ID__c from User where FederationIdentifier=:NwUser limit 1];
            System.debug('u_NewUser'+u_NewUser);
        }
        return u_NewUser;
    }
    
    public List<User> getReplicateU(){
        list<User> u_ReplicateLike;
        if(ReplicateLike!=null && ReplicateLike != 'null'&& ReplicateLike != ''){
            u_ReplicateLike=[select Primary_Queue_Assignment__c,name,FederationIdentifier,ProfileId,UserRoleId,ManagerId,BMCServiceDesk__IsStaffUser__c,isActive,Lan_ID__c from User where FederationIdentifier=:ReplicateLike limit 1]; 
            System.debug('u_ReplicateLike'+u_ReplicateLike);
        }
        return u_ReplicateLike;
    }
    
    public List<PermissionSetAssignment> getPermissionSetReplicateLikeUser(){
        list<PermissionSetAssignment> pl;
        if(ReplicateLike!=null && ReplicateLike != 'null'&& ReplicateLike != ''){
            user oldU=[select UserRoleId,id from user where FederationIdentifier=:ReplicateLike];
            pl=[SELECT Id, PermissionSetId,AssigneeId,Assignee.Name, PermissionSet.Name FROM PermissionSetAssignment where AssigneeId =:oldu.id and (NOT PermissionSet.Name like 'X00e%')];            
        }
        System.debug('getPermissionSetReplicateLikeUser: '+pl);
        return pl;
    }
    
    public List<PermissionSetAssignment> getPermissionSetNewUser(){
        list<PermissionSetAssignment> pl;
        if(NwUser!=null && NwUser != 'null'&& NwUser != ''){
            user oldU=[select UserRoleId,id from user where FederationIdentifier=:NwUser];
            pl=[SELECT PermissionSetId,PermissionSet.Name FROM PermissionSetAssignment where AssigneeId =:oldu.id and (NOT PermissionSet.Name like 'X00e%')];            
        }
        System.debug('getPermissionSetNewUser: '+pl);
        return pl;
    }
    
    public List<GroupMember> getQueueReplicateLikeUser(){
        list<GroupMember> pl;
        if(ReplicateLike!=null && ReplicateLike != 'null'&& ReplicateLike != ''){
            user oldU=[select UserRoleId,id from user where FederationIdentifier=:ReplicateLike];
            pl=[SELECT Id, Group.Name, Group.Id FROM GroupMember where UserOrGroupId =:oldu.id];            
        }
        System.debug('getQueueReplicateLikeUser: '+pl);
        return pl;
    }
    
    public List<GroupMember> getQueueNewUser(){
        list<GroupMember> pl;
        if(NwUser!=null && NwUser != 'null'&& NwUser != ''){
            user oldU=[select UserRoleId,id from user where FederationIdentifier=:NwUser];
            pl=[SELECT Id, Group.Name, Group.Id FROM GroupMember where UserOrGroupId =:oldu.id];            
        }
        System.debug('getQueueNewUser: '+pl);
        return pl;
    }
    
    public void changeProfile(){
        if(NwUser!=null && NwUser != 'null'&& NwUser != ''&& ReplicateLike!=null && ReplicateLike != 'null'&& ReplicateLike != ''){ 
            user oldU=[select profileId from user where FederationIdentifier=:ReplicateLike];
            user newu=[select id from user where FederationIdentifier=:NwUser];
            newu.ProfileId=oldu.ProfileId;
            update newu;
        }
    } 
    
    public void changeRole(){
        if(NwUser!=null && NwUser != 'null'&& NwUser != ''&& ReplicateLike!=null && ReplicateLike != 'null'&& ReplicateLike != ''){
            user oldU=[select UserRoleId from user where FederationIdentifier=:ReplicateLike];
            user newu=[select id from user where FederationIdentifier=:NwUser];
            newu.UserRoleId=oldu.UserRoleId;
            update newu;
        }
    } 
    
    public void changeServiceDeskStaff(){
        if(NwUser!=null && NwUser != 'null'&& NwUser != ''&& ReplicateLike!=null && ReplicateLike != 'null'&& ReplicateLike != ''){
            user oldU=[select BMCServiceDesk__IsStaffUser__c from user where FederationIdentifier=:ReplicateLike];
            user newu=[select id from user where FederationIdentifier=:NwUser];
            newu.BMCServiceDesk__IsStaffUser__c=oldu.BMCServiceDesk__IsStaffUser__c;
            update newu;
        }
    }  
    
    public PageReference AssignPermissionSet(){
        String permSetIdval = ApexPages.currentPage().getParameters().get('p1');
        String newUserval=  ApexPages.currentPage().getParameters().get('p2');
        System.debug('AssignPermissionSet: '+'permSetIdval : '+permSetIdval +' newUserval :'+newUserval );
        if(permSetIdval !=null && permSetIdval != 'null'&& permSetIdval != ''&& newUserval !=null && newUserval != 'null'&& newUserval != ''){     
            user newu=[select id from user where FederationIdentifier=:newUserval ];
            list <PermissionSetAssignment> PSAssignments = new list <PermissionSetAssignment>();
            PSAssignments =[select id from PermissionSetAssignment where AssigneeId =:newu.id and PermissionSetId = :permSetIdval];
            if(PSAssignments.size()<=0){
                System.debug('inserting the new Permission set');
                PSAssignments.add( new PermissionSetAssignment(AssigneeId =newu.id,PermissionSetId = permSetIdval ) );
                insert PSAssignments;
            }
        }
        return null;
    } 
    
    public PageReference RemovePermissionSet(){
        String permSetIdval = ApexPages.currentPage().getParameters().get('p1');
        String newUserval=  ApexPages.currentPage().getParameters().get('p2');
        System.debug('RemovePermissionSet: '+'permSetIdval : '+permSetIdval +' newUserval :'+newUserval );
        if(permSetIdval !=null && permSetIdval != 'null'&& permSetIdval != ''&& newUserval !=null && newUserval != 'null'&& newUserval != ''){     
            user newu=[select id from user where FederationIdentifier=:newUserval ];
            list <PermissionSetAssignment> PSAssignments = new list <PermissionSetAssignment>();
            PSAssignments =[select id from PermissionSetAssignment where AssigneeId =:newu.id and PermissionSetId = :permSetIdval];
            if(PSAssignments.size()>0){
                System.debug('Deleting the new Permission set from new user');
                //PSAssignments.add( new PermissionSetAssignment(AssigneeId =newu.id,PermissionSetId = permSetIdval ) );
                delete PSAssignments;}
        }
        return null;
    }
    
    public PageReference ReplacePermissionSet(){
        String NwUser =  ApexPages.currentPage().getParameters().get('p2');
        if(NwUser!=null && NwUser != 'null'&& NwUser != ''){
            user oldU=[select UserRoleId,id from user where FederationIdentifier=:NwUser];
            for (PermissionSetAssignment p : [SELECT PermissionSetId,PermissionSet.Name FROM PermissionSetAssignment where AssigneeId =:oldu.id and (NOT PermissionSet.Name like 'X00e%')]) {
                delete p;
            }
            AppendPermissionSet();
        }
        return null;
    }
    
    public PageReference AppendPermissionSet(){
        if(ReplicateLike!=null && ReplicateLike != 'null'&& ReplicateLike != ''){
            String newUserval=  ApexPages.currentPage().getParameters().get('p2');
            user oldU=[select UserRoleId,id from user where FederationIdentifier=:ReplicateLike];
            user newu=[select id from user where FederationIdentifier=:newUserval ];
            for (PermissionSetAssignment p : [SELECT Id, PermissionSetId,AssigneeId,Assignee.Name, PermissionSet.Name FROM PermissionSetAssignment where AssigneeId =:oldu.id and (NOT PermissionSet.Name like 'X00e%')]) {
                String permSetIdval = p.PermissionSetId;
                System.debug('AssignQueue: '+'permSetIdval : '+permSetIdval +' newUserval :'+newUserval );
                if(permSetIdval !=null && permSetIdval != 'null'&& permSetIdval != ''&& newUserval !=null && newUserval != 'null'&& newUserval != ''){     
                    list <PermissionSetAssignment> PSAssignments = new list <PermissionSetAssignment>();
                    PSAssignments =[select id from PermissionSetAssignment where AssigneeId =:newu.id and PermissionSetId = :permSetIdval];
                    if(PSAssignments.size()<=0){
                        System.debug('inserting the new Permission set');
                        PSAssignments.add( new PermissionSetAssignment(AssigneeId =newu.id,PermissionSetId = permSetIdval ) );
                        insert PSAssignments;
                    }
                }
            }
        }
        return null;
    }
    
     public PageReference AssignQueue(){
        String permSetIdval = ApexPages.currentPage().getParameters().get('p1');
        String newUserval=  ApexPages.currentPage().getParameters().get('p2');
        System.debug('AssignQueue: '+'permSetIdval : '+permSetIdval +' newUserval :'+newUserval );
        if(permSetIdval !=null && permSetIdval != 'null'&& permSetIdval != ''&& newUserval !=null && newUserval != 'null'&& newUserval != ''){     
            user newu=[select id from user where FederationIdentifier=:newUserval ];
            list <GroupMember> QAssignments = new list <GroupMember>();
            QAssignments =[select id from GroupMember where UserOrGroupId =:newu.id and Id = :permSetIdval];
            if(QAssignments.size()<=0){
                System.debug('inserting the new QueueMember');
                QAssignments.add( new GroupMember(UserOrGroupId = newu.id,GroupId = permSetIdval ) );
                insert QAssignments;
            }
        }
        return null;
    }
    
    public PageReference RemoveQueue(){
        String permSetIdval = ApexPages.currentPage().getParameters().get('p1');
        String newUserval=  ApexPages.currentPage().getParameters().get('p2');
        System.debug('RemoveQueue: '+'permSetIdval : '+permSetIdval +' newUserval :'+newUserval );
        if(permSetIdval !=null && permSetIdval != 'null'&& permSetIdval != ''&& newUserval !=null && newUserval != 'null'&& newUserval != ''){     
            user newu=[select id from user where FederationIdentifier=:newUserval ];
            list <GroupMember> QAssignments = new list <GroupMember>();
            QAssignments =[select id from GroupMember where UserOrGroupId =:newu.id and Id = :permSetIdval];
            if(QAssignments.size()>0){
                System.debug('Deleting the QueueMember from new user');
                delete QAssignments;}
        }
        return null;
    }
    
    public PageReference ReplaceQueue(){
        String NwUser =  ApexPages.currentPage().getParameters().get('p2');
        if(NwUser!=null && NwUser != 'null'&& NwUser != ''){
            user oldU=[select UserRoleId,id from user where FederationIdentifier=:NwUser];
            for (GroupMember g : [SELECT Id, Group.Name, Group.Id FROM GroupMember where UserOrGroupId =:oldu.id]) {
                delete g;
            }
            AppendQueue();
        }
        return null;
    }
    
    public PageReference AppendQueue(){
        if(ReplicateLike!=null && ReplicateLike != 'null'&& ReplicateLike != ''){
            String newUserval=  ApexPages.currentPage().getParameters().get('p2');
            user oldU=[select UserRoleId,id from user where FederationIdentifier=:ReplicateLike];
            user newu=[select id from user where FederationIdentifier=:newUserval ];
            for (GroupMember g : [SELECT Id, Group.Name, Group.Id FROM GroupMember where UserOrGroupId =:oldu.id]) {
                String permSetIdval = g.Group.Id;
                System.debug('AssignQueue: '+'permSetIdval : '+permSetIdval +' newUserval :'+newUserval );
                if(permSetIdval !=null && permSetIdval != 'null'&& permSetIdval != ''&& newUserval !=null && newUserval != 'null'&& newUserval != ''){     
                    list <GroupMember> QAssignments = new list <GroupMember>();
                    QAssignments =[select id from GroupMember where UserOrGroupId =:newu.id and Id = :permSetIdval];
                    if(QAssignments.size()<=0){
                        System.debug('inserting the new QueueMember');
                        QAssignments.add( new GroupMember(UserOrGroupId = newu.id,GroupId = permSetIdval ) );
                        insert QAssignments;
                    }
                }
            }
        }
        return null;
    }
    
    public void AddPrimaryQueue() {
        if(NwUser!=null && NwUser != 'null'&& NwUser != ''&& ReplicateLike!=null && ReplicateLike != 'null'&& ReplicateLike != '') { 
            User oldU=[select Primary_Queue_Assignment__c from user where FederationIdentifier=:ReplicateLike];
            if(oldU.Primary_Queue_Assignment__c !=null && oldU.Primary_Queue_Assignment__c !='null' && oldU.Primary_Queue_Assignment__c !='' ) {
                user newu=[select id from user where FederationIdentifier=:NwUser];
                Group g=[select id from Group where name=:oldu.Primary_Queue_Assignment__c  and type='Queue'];
                GroupMember NewUPrimMember= new GroupMember();
                NewUPrimMember.userorgroupid=newu.id;
                NewUPrimMember.GroupId=g.id;
                insert NewUPrimMember;
                newu.Primary_Queue_Assignment__c=oldu.Primary_Queue_Assignment__c;
                update newu;
            }
        }
    }
    
    public void sendEMailNwuser() {
        user oldU=[select email from user where FederationIdentifier=:ReplicateLike and isActive=true limit 1];
        user newu=[select id,name,email from user where FederationIdentifier=:NwUser and isActive=true limit 1 ];
        Id templateId = [select Id from EmailTemplate where name = 'EmailNewRemedyforceUser'].id;
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        Messaging.SingleEmailMessage mail1 = new Messaging.SingleEmailMessage();
        System.debug('newu'+newu.email);  System.debug('oldu'+oldu.email);  
        mail.setTargetObjectId(newu.id);
        mail.setSaveAsActivity(false);
        mail.setTemplateId(templateId);
        mail.setUseSignature(false);
        mail.setBccAddresses(new String[] {'remedyforcesystemuseonly@dexmedia.com'});
        OrgWideEmailAddress[] owea = [select Id,address from OrgWideEmailAddress where Address = 'dl-itremedyforce@dexmedia.com'];
        if ( owea.size() > 0 ) {
            mail.setOrgWideEmailAddressId(owea.get(0).Id);
            String s=owea.get(0).address;
            List<String> s1=new List<string>();
            s1.add(s);
            System.debug('toAddresses'+s1);            
            mail1.setToAddresses(s1);
        }
        mail1.setSubject('Approved New RF Access: '+newu.name);
        mail1.setPlainTextBody('Approved New RF Access: '+newu.name);
        // Send the email you have created.
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail }, false);
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail1 }, false);
    }
}