public class BMCRF_CNTRL_EBGroupSync {
    
    //The below class whether the Queue are synced or not. If they are not synced then updated them before displaying them on the UI.
    public void upsertOnLoad(){
        List<Group> groupList = [select id, name, lastmodifieddate from Group where type = 'Queue'];
        Set<ID> groupIDs = new Set<ID>();
        for(Group g: groupList){
            groupIDs.add(g.ID);
        }
        List<BMCRF_Everbridge_Group_Details__c> ebGroup = [select ID,name,BMCRF_IsActive__c,BMCRF_Everbridge_ID__c,BMCRF_Everbridge_Sync__c,BMCRF_Group_Last_Modified_Date__c,
                                                           BMCRF_Group_Members__c,BMCRF_Salesforce_ID__c,BMCRF_Everbridge_Name__c from BMCRF_Everbridge_Group_Details__c]; 
        List<GroupMember> gm1 = [select id, groupID, UserOrGroupId from GroupMember where groupID IN :groupIDs];
        
        List<BMCRF_Everbridge_Group_Details__c> ebGroupToUpsert = new List<BMCRF_Everbridge_Group_Details__c>();
        Map<ID,Set<ID>> groupMemberMap = new Map<ID,Set<ID>>();
        for(ID group1: groupIDs){
            Set<ID> addMember = new Set<ID>();
            for(GroupMember gm: gm1){
                if(gm.groupId == group1){
                    addMember.add(gm.UserOrGroupId);
                }
            }
            groupMemberMap.put(group1, addMember);
        }
        for(Group g: groupList){
            Boolean newGroupFlag = true;
            for(BMCRF_Everbridge_Group_Details__c ebg:ebGroup ){
                if(g.id == ebg.BMCRF_Salesforce_ID__c){
                    //using lastmodifieddate checked whether the groups/queue were updated after being synced.
                    if(String.valueOf(g.lastmodifieddate) != ebg.BMCRF_Group_Last_Modified_Date__c){
                        ebg.BMCRF_Group_Last_Modified_Date__c = String.valueOf(g.lastmodifieddate);
                        ebg.BMCRF_Everbridge_Sync__c = false;
                        ebg.BMCRF_Group_Members__c = String.valueOf(groupMemberMap.get(g.id));
                        ebGroupToUpsert.add(ebg);
                    }
                    newGroupFlag = false;
                }
            }
            if(newGroupFlag == true){
                BMCRF_Everbridge_Group_Details__c ebg1 = new BMCRF_Everbridge_Group_Details__c();
                ebg1.name = g.name;
                ebg1.BMCRF_Group_Last_Modified_Date__c = String.valueOf(g.lastmodifieddate);
                ebg1.BMCRF_Group_Members__c = String.valueOf(groupMemberMap.get(g.id));
                ebg1.BMCRF_Salesforce_ID__c = g.id;
                ebGroupToUpsert.add(ebg1);
            }
            system.debug('###GROUPMEMBER'+String.valueOf(groupMemberMap.get(g.id)));
        }
        try{
            upsert ebGroupToUpsert;
        }catch(Exception e){system.debug('EXCEPTION IN BMCRF_CNTRL_SYNC.USERSYNC() UPSERTING USERS:'+e);}
    }
    
    public PageReference newCondition() {
        PageReference pageRef = new PageReference('/apex/BMCRF_VF_ConditionsPage');
        return pageRef;
    }
    
    //Below are the display properties being set in apex which is used in VF Pages to check whether to display the column or not.
    Public static  Integer Col{ get; set; } 
    public String disProp1{get;set;}
    public String disProp2{get;set;}
    public String disProp3{get;set;}
    public String disProp4{get;set;}
    public String disProp5{get;set;}
    public String disProp6{get;set;}
    public String disProp7{get;set;}
    public String disProp8{get;set;}
    public String disProp9{get;set;}
    public String disProp10{get;set;}         
    public String disProp{get;set;}
    public String displayMessage{get; set;}   
    
    //Subclass : Wrapper Class: this class will hold the details of all the column values to be displayed on the UI
    public class GroupListWrapper 
    {
        //These are the variables used to show the actual data in the column.
        public string attr1;
        public string attr2;
        public string attr3;
        public string attr4;
        public string attr5;
        public string attr6;
        public string attr7;
        public string attr8;
        public string attr9;
        public string attr10;        
        public string id1;
        public String name1;
        
        
        //Wrapper  Class Controller
        GroupListWrapper () 
        {
            
        }
    }
    
    //get column headers.
    public List<Schema.FieldSetMember> getFields()
    {
        return SObjectType.BMCRF_Everbridge_Group_Details__c.FieldSets.EB_Column_Headers.getFields();
    }
    
    public List<String> getcolumnHeaders(){
        List<String> columnHeaders1 = new List<String>();
        for(Schema.FieldSetMember f:SObjectType.BMCRF_Everbridge_Group_Details__c.FieldSets.EB_Column_Headers.getFields()){
            columnHeaders1.add(f.getLabel());
        }
        
        return columnHeaders1;    
    }
    
    //Method to bring the list of Conditions and Serialize Wrapper Object as JSON
    //Basically this is used to the column and their associated data using the Field Sets of the object.
    public String getconditionList(){
        List <GroupListWrapper> lstwrap = new List <GroupListWrapper> ();
        String query='select ';
        Integer i = 0;
        col = 0;
        List<String> flds = new list<String>();
        map<Integer,String> tmp= new map<Integer,String>();
        for(Schema.FieldSetMember f:SObjectType.BMCRF_Everbridge_Group_Details__c.FieldSets.EB_Column_Headers.getFields())
        {
            query+= f.getFieldPath() + ',';
            flds.add(f.getFieldPath());
            i++;
            tmp.put(i,f.getFieldPath());
        }
        
        if(i<1){disProp1='none';disProp2='none';disProp3='none';disProp4='none';disProp5='none';disProp6='none';disProp7='none';disProp8='none';disProp9='none';disProp10='none';}
        if(i<2){disProp2='none';disProp3='none';disProp4='none';disProp5='none';disProp6='none';disProp7='none';disProp8='none';disProp9='none';disProp10='none';}
        if(i<3){disProp3='none';disProp4='none';disProp5='none';disProp6='none';disProp7='none';disProp8='none';disProp9='none';disProp10='none';}
        if(i<4){disProp4='none';disProp5='none';disProp6='none';disProp7='none';disProp8='none';disProp9='none';disProp10='none';}
        if(i<5){disProp5='none';disProp6='none';disProp7='none';disProp8='none';disProp9='none';disProp10='none';}
        if(i<6){disProp6='none';disProp7='none';disProp8='none';disProp9='none';disProp10='none';}
        if(i<7){disProp7='none';disProp8='none';disProp9='none';disProp10='none';}
        if(i<8){disProp8='none';disProp9='none';disProp10='none';}
        if(i<9){disProp9='none';disProp10='none';}
        if(i<10){disProp10='none';}
        
        query+='id from BMCRF_Everbridge_Group_Details__c order by name asc';
        list<BMCRF_Everbridge_Group_Details__c> conditions  = Database.query(query);
        for (BMCRF_Everbridge_Group_Details__c cond : conditions) 
        {    
            String temp = String.valueOf(cond);
            GroupListWrapper cwrap = new GroupListWrapper();
            cwrap.id1 = cond.id;
            cwrap.name1=cond.name;
            List<String> ch= temp.split('\\,');
            System.debug(ch);
            Integer j=0;
            for(String c:ch)
            {
                for(Integer k=0;k<flds.size();k++)
                {
                    if(flds[k].trim().equals(c.substringBetween('{','='))&& k==0)
                    {
                        cwrap.attr1= c.substringAfter('=');
                        col++;
                        break;
                    }
                    else if(flds[k].trim().equals(c.substringBefore('=').trim())&& k==1)
                    {
                        cwrap.attr2= c.substringAfter('=');
                        col++;
                        break;
                    }
                    
                    else if(flds[k].trim().equals(c.substringBefore('=').trim())&&k==2)
                    { 
                        cwrap.attr3= c.substringAfter('=');
                        col++;                           
                        break;
                    }
                    else if(flds[k].trim().equals(c.substringBefore('=').trim())&&k==3)
                    { 
                        cwrap.attr4= c.substringAfter('=');
                        col++;
                        break;
                    }
                    else if(flds[k].trim().equals(c.substringBefore('=').trim())&&k==4)
                    { 
                        cwrap.attr5= c.substringAfter('='); 
                        col++;                                            
                        break;
                    }
                    /*else if(flds[k].trim().equals(c.substringBefore('=').trim())&&k==5)
                    { 
                        cwrap.attr7= c.substringAfter('=');  
                        col++;
                        break;
                    }
                    else if(flds[k].trim().equals(c.substringBefore('=').trim())&&k==7)
                    { 
                        cwrap.attr8= c.substringAfter('=');  
                        col++;
                        break;
                    }
                    else if(flds[k].trim().equals(c.substringBefore('=').trim())&&k==8)
                    { 
                        cwrap.attr9= c.substringAfter('=');
                        col++;
                        break;
                    }
                    else if(flds[k].trim().equals(c.substringBefore('=').trim())&&k==9)
                    { 
                        //cwrap.attr10 = Approval_map.get(c.substringAfter('='));
                        
                        cwrap.attr10= c.substringAfter('=');  
                        col++;
                        break;
                    }  */                  
                }
                j++;
            }
            if(String.isBlank(cwrap.attr1))
                cwrap.attr1 = '';
            if(String.isBlank(cwrap.attr2))
                cwrap.attr2 = '';    
            if(String.isBlank(cwrap.attr3))
                cwrap.attr3 = '';
            if(String.isBlank(cwrap.attr4))
                cwrap.attr4 = '';
            if(String.isBlank(cwrap.attr5))
                cwrap.attr5 = '';             
            if(String.isBlank(cwrap.attr6))
                cwrap.attr6 = '';
            if(String.isBlank(cwrap.attr7))
                cwrap.attr7 = '';    
            if(String.isBlank(cwrap.attr8))
                cwrap.attr8 = '';
            if(String.isBlank(cwrap.attr9))
                cwrap.attr9 = '';
            if(String.isBlank(cwrap.attr10))
                cwrap.attr10 = '';            
            lstwrap.add(cwrap); 
        }
        return JSON.serialize(lstwrap);
    }
    
    //The below method is used to sync the Groups and their associated members to EB
    //The method basically gets all the selected groups from the UI and passes it to BMCRF_Parser_EBCreateGroupContact.createEBGroup(groupList);
    public void syncGroup() {
        
        list<String> ls;
        try{
            ls = (List<String>)JSON.deserialize( Apexpages.currentPage().getParameters().get('node'), List<string>.class ) ;
        }
        catch(Exception e)
        {
        
        }
        List<BMCRF_Everbridge_Group_Details__c> updatedGroups = new List<BMCRF_Everbridge_Group_Details__c>();
        List<BMCRF_Parser_EBCreateGroupContact.UpdatedUserWrapper> updatedUserWrapper = new List<BMCRF_Parser_EBCreateGroupContact.UpdatedUserWrapper>(); 
        List<User> updatedUsers = new List<User>();
        Integer successCounter = 0;
        Integer totalCounter = 0;
        Map<String, User> successFailureMap = new Map<String, User>();
        
        
        Set<ID> groupToSync = new Set<ID>();  
        if(ls!=NULL)      
        {
          for(String g: ls)
          {
           if(g =='a' || g == 'b' || String.isBlank(g))
           {
              system.debug('SKIPPED');
           }
           else
           {
              groupToSync.add(g);
              totalCounter ++;
              system.debug('ADDED'+g);
           }
          }
        }
        
        if(!groupToSync.isEmpty()){
            List<BMCRF_Everbridge_Group_Details__c> g =  new List<BMCRF_Everbridge_Group_Details__c>();
            try{
                g = [select ID,name,BMCRF_Everbridge_Name__c,BMCRF_IsActive__c,BMCRF_Everbridge_ID__c,BMCRF_Everbridge_Sync__c,BMCRF_Group_Last_Modified_Date__c,
                     BMCRF_Group_Members__c,BMCRF_Salesforce_ID__c from BMCRF_Everbridge_Group_Details__c where ID IN: groupToSync];
                if(!g.isEmpty()){
                    BMCRF_Parser_EBCreateGroupContact ebc = new BMCRF_Parser_EBCreateGroupContact();
                    updatedUserWrapper = ebc.createEBGroup(g);
                }
            }catch(Exception e){System.debug('EXCEPTION IN BMCRF_CNTRL_SYNC.GROUPSYNC()'+e);}
            
        }

        //To display appropriate message
        if(updatedUserWrapper != NULL){
                for(BMCRF_Parser_EBCreateGroupContact.UpdatedUserWrapper usw: updatedUserWrapper){
                    if(usw.status == 'success'){
                        updatedGroups.add(usw.updatedGroup);
                        successCounter ++;
                        system.debug('###back'+usw.updatedGroup+'###'+usw.status);
                    }
                    else{
                        //Updated groups error field with the http response.
                    }
                }
                if(successCounter != 0)
                    this.displayMessage = 'Sync Successfull!';// for ' + successCounter +' out of '+ totalCounter +' Groups!';
                else
                    this.displayMessage = 'Sync Failed!';
        }
        else
            this.displayMessage = 'Sync Failed!';
    } 
    
}