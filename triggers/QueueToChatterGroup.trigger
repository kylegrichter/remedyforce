trigger QueueToChatterGroup on BMCServiceDesk__Incident__c (after insert, after update){
    System.Debug('START QueueToChatterGroup');
    if(HelperClass.firstRun){
        
        Map<String, String> QueuesForChatterName = new Map<String, String>();
        Map<Id,Queue_Extended_Attributes__c> QueuesForChatter = new Map<Id, Queue_Extended_Attributes__c>( [SELECT Id, Queue_Label__c, Queue_Name__c FROM Queue_Extended_Attributes__c WHERE Send_Ticket_Notification_to_Chatter__c = true]);
        System.Debug('Loading QueuesForChatter with records. # of Records: '+QueuesForChatter.size());
        for (Id id : QueuesForChatter.keySet()) {QueuesForChatterName.put(QueuesForChatter.get(id).Queue_Name__c, id);}
        
        Map<String, String> ChatterGroupsName = new Map<String, String>();
        Map<Id,CollaborationGroup> ChatterGroups = new Map<Id, CollaborationGroup>( [select Id, Name from CollaborationGroup]);
        System.Debug('Loading ChatterGroups with records. # of Records: '+ChatterGroups.size());
        for (Id id : ChatterGroups.keySet()) {ChatterGroupsName.put(ChatterGroups.get(id).Name, id);}
        
        Map<String, String> GroupNameMap = new Map<String, String>();
        Map<String, String> GroupDevNameMap = new Map<String, String>();
        Map<Id,Group> GroupMap = new Map<Id, Group>( [SELECT Id, Name, DeveloperName, Type FROM Group WHERE Type = 'Queue']);
        System.Debug('Loading GroupMap with records. # of Records: '+GroupMap.size());
        for (Id id : GroupMap.keySet()) {
            GroupNameMap.put(GroupMap.get(id).Name, id);
            GroupDevNameMap.put(GroupMap.get(id).DeveloperName, id);
        }
        
        for ( BMCServiceDesk__Incident__c IR : Trigger.new ){
            System.Debug('Starting For Loop');
            if ( string.valueOf(IR.OwnerId).startsWith('00G') && QueuesForChatterName.containsKey(GroupMap.get(IR.OwnerId).DeveloperName) && ( Trigger.isInsert || ( Trigger.isUpdate && Trigger.oldMap.get(IR.Id).OwnerId != Trigger.newMap.get(IR.Id).OwnerId)) ){
                System.Debug('Queue is tagged for Chatter Updates');
                String QueueNameDev = QueuesForChatter.get(QueuesForChatterName.get(GroupMap.get(IR.OwnerId).DeveloperName)).Queue_Name__c;
                String QueueNameLabel = QueuesForChatter.get(QueuesForChatterName.get(GroupMap.get(IR.OwnerId).DeveloperName)).Queue_Label__c;
                String ChatterGroupId;
                
                if ( ChatterGroupsName.containsKey(QueueNameDev) ){
                    System.Debug('Chatter Group is Already Present');
                    ChatterGroupId = ChatterGroups.get(ChatterGroupsName.get(QueueNameDev)).Id;
                } else {
                    System.Debug('Building new Chatter Group');
                    CollaborationGroup myGroup = new CollaborationGroup();
                    myGroup.Name=QueueNameDev;
                    myGroup.CollaborationType='Public';
                    myGroup.IsAutoArchiveDisabled=true;
                    myGroup.OwnerId='005E00000027kY3';
                    insert myGroup;
                    ChatterGroupId = myGroup.Id;
                }
                System.Debug('Building Feed Item');
                String actionstate;
                if (Trigger.isInsert){ actionstate = 'created and assigned'; } else { actionstate = 'transfered'; }
                FeedItem post = new FeedItem();
                post.ParentId = ChatterGroupId;
                post.Body = 'A P'+ IR.BMCServiceDesk__Priority_ID__c+' '+IR.BMCServiceDesk__Type__c+' has been '+actionstate+' to '+QueueNameLabel+'.';
                post.Body += '\r\n\r\n';
                if (IR.BMCServiceDesk__queueName__c == 'Field Support'){
                    post.Body += 'Computer Name: '+IR.Computer_Name__c;
                    post.Body += '\r\n\r\n';
                }
                post.Body += 'Description: '+IR.BMCServiceDesk__incidentDescription__c;
                post.Type = 'LinkPost';
                post.LinkUrl = 'https://remedy.my.salesforce.com/'+IR.Id+'#RemedyForce_PCGLink__'+IR.Id;
                post.Title = 'Incident #'+IR.Name;
                System.Debug('Posting Feed Item');
                insert post;
            }
            System.Debug('Ending For Loop');
        }
        HelperClass.firstRun=false;
    }
    System.Debug('END QueueToChatterGroup');
}