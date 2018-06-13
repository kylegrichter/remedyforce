public class UserLookup {
    public string UserLookupId{get;set;}
    public string UserSearchName{get;set;}
    public string UserSearchLan{get;set;}
    private integer totalRecs = 0;
    private integer index = 0;
    private integer blockSize = 5;
    public Integer pageNumber{get;set;}
    public Integer ResultSize{get;set;}
    public Integer PageSize{get;set;}
    private integer totalRecsLan = 0;
    private integer indexLan = 0;
    private integer blockSizeLan = 5;
    public Integer pageNumberLan{get;set;}
    public Integer ResultSizeLan{get;set;}
    public Integer PageSizeLan{get;set;}
    
    public UserLookup(){
        if (string.isNotBlank(ApexPages.currentPage().getParameters().get('user'))){
            UserLookupId = ApexPages.currentPage().getParameters().get('user');
        }
    }
    
    public List<User> getUserInfoRecord(){
        List<User> u_UserInfo;
        Map<String, Schema.SObjectField> fldObjMap = schema.SObjectType.User.fields.getMap();
        List<Schema.SObjectField> fldObjMapValues = fldObjMap.values();
        String theQuery = 'SELECT ';
        for(Schema.SObjectField s : fldObjMapValues)
        {
            String theName = s.getDescribe().getName();
            theQuery += theName + ',';
        }
        theQuery += 'LastModifiedBy.Name FROM User WHERE FederationIdentifier=\'' + UserLookupId + '\' limit 1';
        u_UserInfo = Database.query(theQuery);
        return u_UserInfo;
    }
    
    public List<User> getUserSearchList(){
        String a = UserSearchName;
        a = '%' + a + '%';
        totalRecs = [select count() FROM User WHERE FederationIdentifier != NULL AND Name like :a];
        ResultSize = totalRecs;
        PageSize = 5;
        pageNumber = index+1;
        Map<String, Schema.SObjectField> fldObjMap = schema.SObjectType.User.fields.getMap();
        List<Schema.SObjectField> fldObjMapValues = fldObjMap.values();
        String theQuery = 'SELECT ';
        for(Schema.SObjectField s : fldObjMapValues)
        {
            String theName = s.getDescribe().getName();
            theQuery += theName + ',';
        }
        theQuery += 'LastModifiedBy.Name FROM User WHERE FederationIdentifier != NULL AND Name like \'%' + UserSearchName + '%\' LIMIT :blockSize OFFSET :index';
        list<User> u_UserInfo = Database.query(theQuery);
        return u_UserInfo;
    }
    
    public List<User> getLanSearchList(){
        String a = UserSearchLan;
        a = '%' + a + '%';
        totalRecsLan = [select count() FROM User WHERE FederationIdentifier != NULL AND FederationIdentifier like :a];
        ResultSizeLan = totalRecsLan;
        PageSizeLan = 5;
        pageNumberLan = indexLan+1;
        Map<String, Schema.SObjectField> fldObjMap = schema.SObjectType.User.fields.getMap();
        List<Schema.SObjectField> fldObjMapValues = fldObjMap.values();
        String theQuery = 'SELECT ';
        for(Schema.SObjectField s : fldObjMapValues)
        {
            String theName = s.getDescribe().getName();
            theQuery += theName + ',';
        }
        theQuery += 'LastModifiedBy.Name FROM User WHERE FederationIdentifier != NULL AND FederationIdentifier like \'%' + UserSearchLan + '%\' LIMIT :blockSizeLan OFFSET :indexLan';
        list<User> u_UserInfo = Database.query(theQuery);
        return u_UserInfo;
    }
    
    public List<BMCServiceDesk__Incident__c> getUserIncidents()
    {
        list<BMCServiceDesk__Incident__c> u_UserIRs;
        if(UserLookupId!=null && UserLookupId != 'null'&& UserLookupId != '')
        {
            u_UserIRs=[select id, name, BMCServiceDesk__Launch_console__c, BMCServiceDesk__Type__c, CreatedDate, CreatedById, CreatedBy.Name, LastModifiedById, 
                       LastModifiedBy.Name, LastModifiedDate, BMCServiceDesk__FKPriority__c, BMCServiceDesk__FKStatus__c, Incident_Title__c, BMCServiceDesk__incidentDescription__c, 
                       BMCServiceDesk__FKBMC_BaseElement__c, BMCServiceDesk__queueName__c, BMCServiceDesk__FKOpenBy__c, BMCServiceDesk__dueDateTime__c 
                       from BMCServiceDesk__Incident__c 
                       where BMCServiceDesk__FKClient__r.FederationIdentifier=:UserLookupId 
                       order by CreatedDate DESC 
                       limit 20];
            System.debug('u_UserIRs'+u_UserIRs);
        }
        return u_UserIRs;
    }
    
    public void beginning(){
        index = 0;
    }
    
    public void previous(){
        index = index - blockSize;
    }
    
    public void next(){
        index = index + blockSize;
    }
    
    public void end(){
        index = totalrecs - math.mod(totalRecs,blockSize);
    }        
    
    public boolean getprev(){
        if(index == 0)
            return true;
        else
            return false;
    }  
    
    public boolean getnxt(){
        if((index+1 + blockSize) > totalRecs)
            return true;
        else
            return false;
    }
    
    public void beginningLan(){
        indexLan = 0;
    }
    
    public void previousLan(){
        indexLan = indexLan - blockSizeLan;
    }
    
    public void nextLan(){
        indexLan = indexLan + blockSizeLan;
    }
    
    public void endLan(){
        indexLan = totalrecsLan - math.mod(totalRecsLan,blockSizeLan);
    }        
    
    public boolean getprevLan(){
        if(indexLan == 0)
            return true;
        else
            return false;
    }  
    
    public boolean getnxtLan(){
        if((indexLan+1 + blockSizeLan) > totalRecsLan)
            return true;
        else
            return false;
    }      
}