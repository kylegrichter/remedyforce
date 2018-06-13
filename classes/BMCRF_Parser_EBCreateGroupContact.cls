public class BMCRF_Parser_EBCreateGroupContact
{
    BMCRF_EB_Incident_Configuration__c EB_Config;
    
    public BMCRF_Parser_EBCreateGroupContact(){
        EB_Config = [select ID, BMCRF_Everbridge_Webhook_URL__c, BMCRF_Everbridge_Organization_ID__c, BMCRF_Everbridge_Username__c, 
                                                               BMCRF_Everbridge_Password__c, BMCRF_Everbridge_API_URL_Base__c, BMCRF_Everbridge_External_ID_Field__c
                                                        from BMCRF_EB_Incident_Configuration__c limit 1];
    }
    
    //The wrapper class is used to by the methods to return the status(success/failure) and object which was synced
    public class UpdatedUserWrapper{
        public String Status;
        public User updatedUser;
        public BMCRF_Everbridge_Group_Details__c updatedGroup;
        public List<User> updatedUserList;
        public String resJSON;
    }
    
    List<String> param4_List = new List<String>();
    
    // The below method is used to sync users from RF to EB
    public List<UpdatedUserWrapper> createEBContact(List<User> u,Boolean batchFlag){
    
        List<UpdatedUserWrapper> updatedUsers = new List<UpdatedUserWrapper>();
        
        //Below flags will be used to create array of contacts
        Integer j = 0;
        String jsonBatch = '';

        //HTTP callout to fetch EB Record Type
        String recTypeJSON = call('' ,'GET','recordTypes','','');
        recTypeJSON = recTypeJSON.replace('"page"', '"page1"');
        BMCRF_Model_RecordType rt = (BMCRF_Model_RecordType) System.JSON.deserialize(recTypeJSON, BMCRF_Model_RecordType.class);
        BMCRF_Model_RecordType.Page1 pg = rt.Page1;
        List<BMCRF_Model_RecordType.Data> dt = pg.data;
        Map<String, Long> recTypeIDMap = new Map<String, Long>();
        for(BMCRF_Model_RecordType.Data dt1:dt){
            recTypeIDMap.put(dt1.name,dt1.id);
        }
        
        //HTTP callout to fetch EB Contact Paths
        String pathJSON = call('' ,'GET','contactPaths','','');
        pathJSON = pathJSON.replace('"page"', '"page1"');
        BMCRF_Model_ContactPath cp = (BMCRF_Model_ContactPath) System.JSON.deserialize(pathJSON, BMCRF_Model_ContactPath.class);
        BMCRF_Model_ContactPath.Page1 pg1 = cp.Page1;
        List<BMCRF_Model_ContactPath.Data> dt1 = pg1.data;
        Map<String, Long> pathIDMap = new Map<String, Long>();
        for(BMCRF_Model_ContactPath.Data dt2:dt1){
            pathIDMap.put(dt2.code,dt2.pathId);
        }
        
        //HTTP callout for all the user in the list to be sync
        for(User u1: u){
            UpdatedUserWrapper usw = new UpdatedUserWrapper();
        
            //JSON will be serialized using Model Apex class and passed to the callout method
            BMCRF_Model_Contact cnt = new BMCRF_Model_Contact();
            cnt.firstName = u1.firstname;
            cnt.lastName = u1.lastname;
            if(EB_Config.BMCRF_Everbridge_External_ID_Field__c == 'Username')
                cnt.externalId = u1.username;
            else if (EB_Config.BMCRF_Everbridge_External_ID_Field__c == 'Federation ID')
                cnt.externalId = u1.FederationIdentifier;
            else if (EB_Config.BMCRF_Everbridge_External_ID_Field__c == 'Record ID')
                cnt.externalId = u1.id;

            cnt.recordTypeId = recTypeIDMap.get('Employee');
            
            List<BMCRF_Model_Contact.Paths> pathList = new List<BMCRF_Model_Contact.Paths>();
            
            //Set salesforce contact information of user details as Email1/Mobile1/Office1 in EB
            for(Integer i=0 ; i<3 ; i++){
                String contactPath,pathValue  = '';
                if((String.isNotBlank(u1.Email) && i==0)){
                    contactPath = 'EMAIL1';
                    pathValue = u1.Email;
                }
                else if((String.isNotBlank(u1.MobilePhone) && String.isNotBlank(u1.BMCRF_EB_Country_Code__c) && i==1)){
                    contactPath = 'MOBILE1';
                    pathValue = u1.MobilePhone;
                }
                else if((String.isNotBlank(u1.Phone) && i==3)){
                    contactPath = 'OFFICE1';
                    pathValue = u1.Phone;                
                }
                
                if (String.isNotBlank(pathValue)){
                    BMCRF_Model_Contact.Paths path = new BMCRF_Model_Contact.Paths();
                    path.value = pathValue;
                    path.pathId = pathIDMap.get(contactPath);
                    if(String.isNotBlank(u1.BMCRF_EB_Country_Code__c)) 
                        path.countryCode = u1.BMCRF_EB_Country_Code__c ;
                    pathList.add(path);
                }
            }            
            cnt.paths = pathList;
            String json1 = JSON.serializePretty(cnt);
            system.debug('##JSONSTRING USER: '+json1);
            
            if(j==0)
                jsonBatch = '['+json1;
            else
                jsonBatch = jsonBatch+','+json1;
            
            String responseJSON = '';
            if(!batchFlag){
                if(String.isBlank(u1.BMCRF_EB_ID__c))
                    responseJSON = call(json1 ,'POST','contacts','','');
                else
                    responseJSON = call(json1 ,'PUT','contacts',u1.BMCRF_EB_ID__c,'');
                if (responseJSON != '## HTTP Callout Failed ##'){
                    BMCRF_Model_Response res = BMCRF_Model_Response.parse(responseJSON);
                    if(res != NULL){
                        u1.BMCRF_Everbridge_Sync__c = true;
                        u1.BMCRF_EB_ID__c = String.valueOf(res.id);
                        usw.Status = 'success';
                        usw.updatedUser = u1;
                        updatedUsers.add(usw);
                    }
                }
                else{
                        usw.Status = 'failure';
                        usw.updatedUser = u1;
                        updatedUsers.add(usw);
                }
            }
            j++;
                
        }
        if(batchFlag && String.isNotBlank(jsonBatch)){
            String responseJSON;
            jsonBatch = jsonBatch +']';
            system.debug('##JSONSTRING USER BATCH: '+jsonBatch);
            //BMCRF_HELPER_EBHttpCallout calloutObj3=new BMCRF_HELPER_EBHttpCallout();
            responseJSON = call(jsonBatch,'POST','contacts','batch','');
            UpdatedUserWrapper usw = new UpdatedUserWrapper();
            usw.resJSON = responseJSON;
            updatedUsers.add(usw);
            return updatedUsers;
        }
        
        return updatedUsers;
    }//End of createEBContact()
    
    
    //The below method is used to sync RF and EB groups and users associated to the groups.
    public List<UpdatedUserWrapper> createEBGroup(List<BMCRF_Everbridge_Group_Details__c> ebGroup){

        Set<ID> groupID = new Set<ID>();
        List<UpdatedUserWrapper> updatedGroupsWrapperList = new List<UpdatedUserWrapper>();
        
        //Sync Group and get groupIds
        for(BMCRF_Everbridge_Group_Details__c egd: ebGroup){
            if(String.isBlank(egd.BMCRF_Everbridge_ID__c)){
                BMCRF_Model_Group jsonGroup = new BMCRF_Model_Group();
                jsonGroup.parentId = -1;
                jsonGroup.name = egd.name;
                String json1 = JSON.serializePretty(jsonGroup);
                String responseJSON = call(json1 ,'POST','groups','','');
                UpdatedUserWrapper usw = new UpdatedUserWrapper();
                system.debug('##JSONSTRING GROUPSYNC:'+json1);
                if (responseJSON != '## HTTP Callout Failed ##'){
                    BMCRF_Model_Response res = BMCRF_Model_Response.parse(responseJSON);
                    
                    if(res != NULL){
                        egd.BMCRF_Everbridge_Sync__c = true;
                        egd.BMCRF_Everbridge_ID__c = String.valueOf(res.id);
                        egd.BMCRF_Everbridge_Name__c = egd.name;
                        usw.Status = 'success';
                        usw.updatedGroup = egd;
                        updatedGroupsWrapperList.add(usw);
                    }
                }
                else{
                        usw.Status = 'failure';
                        usw.updatedGroup = egd;
                        updatedGroupsWrapperList.add(usw);
                        //update Failed Groups with the error message here;
                }
            }
            else if(String.isNotBlank(egd.BMCRF_Everbridge_ID__c) && !egd.BMCRF_Everbridge_Sync__c){
                BMCRF_Model_Group jsonGroup = new BMCRF_Model_Group();
                jsonGroup.parentId = -1;
                jsonGroup.name = egd.name;
                String json1 = JSON.serializePretty(jsonGroup);
                String responseJSON = call(json1 ,'PUT','groups',egd.BMCRF_Everbridge_ID__c,'');
                system.debug('##JSONSTRING RESPONSE:'+responseJSON);
                UpdatedUserWrapper usw = new UpdatedUserWrapper();
                if (responseJSON != '## HTTP Callout Failed ##'){
                    BMCRF_Model_Response res = BMCRF_Model_Response.parse(responseJSON);
                    
                    if(res != NULL){
                        egd.BMCRF_Everbridge_Sync__c = true;
                        egd.BMCRF_Everbridge_ID__c = String.valueOf(res.id);
                        egd.BMCRF_Everbridge_Name__c = egd.name;
                        usw.Status = 'success';
                        usw.updatedGroup = egd;
                        updatedGroupsWrapperList.add(usw);
                        
                    }
                }
                else{
                        usw.Status = 'failure';
                        usw.updatedGroup = egd;
                        updatedGroupsWrapperList.add(usw);
                        //update Failed Groups with the error message to be updated here
                }
            }
            groupID.add(egd.BMCRF_Salesforce_ID__c); //to extract users from 
        }
        
        //updating all the groups synced in RF with EB ID 
        List<BMCRF_Everbridge_Group_Details__c> updateEBGroups = new List<BMCRF_Everbridge_Group_Details__c> ();
        Map<id,String> groupIdEBIdMap = new Map<id,String>();
        for(UpdatedUserWrapper usw1: updatedGroupsWrapperList){
            updateEBGroups.add(usw1.updatedGroup);
            groupIdEBIdMap.put(usw1.updatedGroup.BMCRF_Salesforce_ID__c , usw1.updatedGroup.BMCRF_Everbridge_ID__c);
            System.debug('##addingInMap'+usw1.updatedGroup.BMCRF_Salesforce_ID__c +' '+ usw1.updatedGroup.BMCRF_Everbridge_ID__c);
        }
        
        //Users to sync
        List<GroupMember> gm1 = [select ID, groupId, UserOrGroupId from GroupMember where groupId IN: groupID];
        Set<ID> userID = new Set<ID>();
        for(GroupMember gm:gm1){
            userID.add(gm.UserOrGroupId);
        }
        
        List<User> userToUpdate = [select ID, BMCRF_Everbridge_Sync__c,BMCRF_EB_ID__c, Firstname, Lastname, name, email, username, FederationIdentifier, Extension, Phone, MobilePhone, street, city, PostalCode, state, country, BMCRF_EB_Country_Code__c from user where ID IN: userID];
        Map<id,User> userIdSyncMap = new Map<id,User>();
        for(User u:userToUpdate){
            userIdSyncMap.put(u.id,u);
        }
        List<UpdatedUserWrapper> updatedUserWrapperList = new List<UpdatedUserWrapper>(); 
        BMCRF_Parser_EBCreateGroupContact ebc = new BMCRF_Parser_EBCreateGroupContact();
        try
        {
            updatedUserWrapperList = ebc.createEBContact(userToUpdate,true);
        }
        catch(Exception e)
        {
        }
        
        //Check the status of the user sync by making a GET request to EB.
        String userJSON= call('' ,'GET','contacts','','pageNumber=1&searchType=OR');
        userJSON= userJSON.replace('"page"', '"page1"');
        BMCRF_Model_Contact_Response cnt = (BMCRF_Model_Contact_Response) System.JSON.deserialize(userJSON, BMCRF_Model_Contact_Response.class);
        BMCRF_Model_Contact_Response.Page1 pg = cnt.Page1;
        List<BMCRF_Model_Contact_Response.Data> dt1;
        try
        {
            dt1 = pg.Data;
        
        if(pg.totalPageCount > 1 ){
            for(Integer i=1; i<=pg.totalPageCount;i++){
                Integer pageNum = i+1;    
                String param3 = 'pageNumber='+pageNum+'&searchType=OR';
                userJSON = '';
                userJSON = call('' ,'GET','contacts','',param3);
                userJSON = userJSON.replace('"page"', '"page1"');
                BMCRF_Model_Contact_Response cnt1 = (BMCRF_Model_Contact_Response) System.JSON.deserialize(userJSON, BMCRF_Model_Contact_Response.class);
                dt1.addAll(cnt.Data);
            }
        }
        }
        catch(Exception e)
        {}
        
        //Updating all the users in RF with EB ID
        List<User> updatedUsersList = new List<user>();
        Map<id,String> userIdEBIdMap = new Map<id,String>();
        for(User u: userToUpdate ){  
            if(dt1!=null){
                for(BMCRF_Model_Contact_Response.Data dt:dt1){
                    if(String.isBlank(u.BMCRF_EB_ID__c) && (dt.externalId == u.username || dt.externalId == u.FederationIdentifier || dt.externalId == String.valueOf(u.id))){
                        u.BMCRF_Everbridge_Sync__c = true;
                        u.BMCRF_EB_ID__c = String.valueOf(dt.id);
                        updatedUsersList.add(u);
                        userIdEBIdMap.put(u.id,u.BMCRF_EB_ID__c);
                    }
                }
            }
        }
        
        //Group Members sync
        Map<ID,Set<ID>> groupMemberMap = new Map<ID,Set<ID>>();
        //List to return to the Group Sync VF page
        List<UpdatedUserWrapper> uswReturnList = new List<UpdatedUserWrapper>();
        for(ID group1: groupID){
            Integer i=0 ;
            if(groupIdEBIdMap.get(group1) != NULL){
                String addMember = '';
                List<User> updatedMembersList = new List<user>();
                for(GroupMember gm: gm1){
                    system.debug('##i IN LOOP= '+ i);
                    if((userIdEBIdMap.get(gm.UserOrGroupId) != NULL) && gm.groupId == group1){
                        if(i == 0){
                            addMember = addMember + '['+userIdEBIdMap.get(gm.UserOrGroupId);
                            updatedMembersList.add(userIdSyncMap.get(gm.UserOrGroupId));
                            i++;
                        }
                        else{
                            addMember = addMember + ','+userIdEBIdMap.get(gm.UserOrGroupId);
                            updatedMembersList.add(userIdSyncMap.get(gm.UserOrGroupId));
                        }
                    }
                    //users already synced and not added to EB group
                    else if(userIdSyncMap.get(gm.UserOrGroupId).BMCRF_EB_ID__c != NULL && userIdEBIdMap.get(gm.UserOrGroupId) == NULL){
                        if(i == 0){
                            addMember = addMember + '['+userIdSyncMap.get(gm.UserOrGroupId).BMCRF_EB_ID__c;
                            updatedMembersList.add(userIdSyncMap.get(gm.UserOrGroupId));
                            i++;
                        }
                        else{
                            addMember = addMember + ','+userIdSyncMap.get(gm.UserOrGroupId).BMCRF_EB_ID__c;
                            updatedMembersList.add(userIdSyncMap.get(gm.UserOrGroupId));    
                        }
                    }

                }
                
                //Callout to sync group members to their associated groups
                if(String.isNotBlank(addMember)){
                    addMember = addMember + ']';
                    system.debug('##JSONSTRING GROUP MEMBERS:'+addMember);
                    String param3 = 'byType=id&groupId='+groupIdEBIdMap.get(group1)+'&idType=id';
                    String responseJSON = call(addMember,'POST','groups','contacts',param3);
                    system.debug('##JSONSTRING RESPONSE:'+responseJSON);
                    if (responseJSON == '## HTTP Callout Failed ##'){
                        BMCRF_Model_Response res = BMCRF_Model_Response.parse(responseJSON);
                        System.debug('##EXCEPTION GROUPMEMBER SYNC FAILED: ' + addMember);
                    }
                }
                
                //List to return to the Group Sync VF page
                for(UpdatedUserWrapper usw:updatedGroupsWrapperList){
                    usw.updatedUserList = updatedMembersList;
                    uswReturnList.add(usw);
                }
            }
        }
        
        //update statements at last as callouts needs to be performed first, they can't be simultaneous performed.
        try{
            update updateEBGroups;
        }catch(Exception e){System.debug('##EXCEPTION GROUP SYNC: UPDATING GROUPS:'+e);}
        
        system.debug('##UsertoUpdate ' +updatedUsersList);
        try{
            update updatedUsersList;
        }catch(Exception e){System.debug('##EXCEPTION GROUP SYNC: UPDATING USERS:'+e);}
        
        return uswReturnList;
    }

    
    //Callout Method
    public String call(String body,String method, String param1,String param2,String param3){
            
        String JSONString='';
        String baseuri = EB_Config.BMCRF_Everbridge_API_URL_Base__c;
        String uname_Password = EB_Config.BMCRF_Everbridge_Username__c + ':' + EB_Config.BMCRF_Everbridge_Password__c ;
        Blob toBlob = Blob.valueOf(uname_Password);
        String credentials = 'Basic '+ EncodingUtil.base64Encode(toBlob);
        String OraganizationId = EB_Config.BMCRF_Everbridge_Organization_ID__c;
        
        HttpRequest req = new HttpRequest();
        //set base url based on the parameter passed
        if(String.isEmpty(param2) && String.isEmpty(param3))
            req.setEndpoint(baseuri+'/'+param1+'/'+OraganizationId+'/');    
        else if(String.isEmpty(param3))
            req.setEndpoint(baseuri+'/'+param1+'/'+OraganizationId+'/'+param2);    
        else
            req.setEndpoint(baseuri+'/'+param1+'/'+OraganizationId+'/'+param2+'?'+param3);    

        req.setMethod(method);

        if((method=='POST' || method=='PUT'))
            req.setBody(body);
        //if(param4 != NULL)
         //   req.setBody(String.valueof(param4));
            
        req.setHeader('Content-Type', 'application/json');
        req.setHeader('Authorization', credentials);
        req.setHeader('organizationId', OraganizationId);
        req.setTimeout(20000);
        Http h = new Http();
        HttpResponse res = new HttpResponse();
        
        try{
            res = h.send(req);
        }catch(Exception e){system.debug('##CALLOUT EXCEPTION: '+ e + '##RESPONSE: '+res );}
        
        if(res.getStatusCode() == 200)
            JSONString=res.getBody();
        else
            system.debug('##HTTP CALLOUT FAILED:'+ res.getBody());
            
        return JSONString;
    }
    
}