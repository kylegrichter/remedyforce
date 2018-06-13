public class BMCRF_CNTRL_EBUserSync { //ChangeHere

    public BMCRF_CNTRL_EBUserSync(ApexPages.StandardController controller) {
        
    }
    public static Integer Col{ get; set; }
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
    //public string callfunc{get;set;}
    public String displayMessage{get; set;}
    
    //Subclass : Wrapper Class: this class will hold the details of all the column values to be displayed on the UI
    public class UserListWrapper //ChangeHere
    {
        //Static Variables 
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

    }
    
    public List<Schema.FieldSetMember> getFields()
    {
        return SObjectType.User.FieldSets.EB_User_Column_Headers.getFields(); //ChangeHere
    }   
    
    public List<String> getcolumnHeaders(){
        List<String> columnHeaders1 = new List<String>();
        for(Schema.FieldSetMember f:SObjectType.User.FieldSets.EB_User_Column_Headers.getFields()){
            columnHeaders1.add(f.getLabel());
        }
        
        return columnHeaders1;    
    }
    
    //Method to bring the list of Users and Serialize Wrapper Object as JSON
    public String getconditionList(){
        List <UserListWrapper> lstwrap = new List <UserListWrapper> ();
        String query='select ';
        Integer i = 0;
        col = 0;
        Integer profPosition = 0;
        Integer rolePosition = 0;
        List<String> flds = new list<String>();
        map<Integer,String> tmp= new map<Integer,String>();
        List<Profile> prof = [select id,name from Profile];
        Set<id> profID = new Set<id>();
        Map<String,String> profileIDMap = new Map<String,String>();
        for(Profile p: prof){
            profileIDMap.put(p.id, p.name);
            profID.add(p.id);
        }
        List<UserRole> role = [select id,name from UserRole];
        Set<id> roleID = new Set<id>();
        Map<String,String> roleIDMap = new Map<String,String>();
        for(UserRole r: role){
            roleIDMap.put(r.id, r.name);
            roleID.add(r.id);
        }
        for(Schema.FieldSetMember f:SObjectType.User.FieldSets.EB_User_Column_Headers.getFields()){
            query+= f.getFieldPath() + ',';
            flds.add(f.getFieldPath());
            if(f.getFieldPath() == 'ProfileID')
                profPosition = i; 
            if(f.getFieldPath() == 'UserRoleId')
                rolePosition = i;
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
        
        query+='id from User where IsActive = true and BMCServiceDesk__IsStaffUser__c = true order by name desc'; //and BMCServiceDesk__IsStaffUser__c = true order by name desc';
        list<User> users  = Database.query(query);
        for (User usr : users){    
            String temp = String.valueOf(usr);
            UserListWrapper wrap = new UserListWrapper();
            wrap.id1 = usr.id;
            wrap.name1=usr.name;
            List<String> ch= temp.split('\\,');
            System.debug(ch);
            Integer j=0;
            for(String c:ch)
            {
                for(Integer k=0;k<flds.size();k++)
                {
                    if(flds[k].trim().equals(c.substringBetween('{','='))&& k==0)
                    {
                        if(profPosition != k && rolePosition != k)
                            wrap.attr1= c.substringAfter('=');
                        else if(profPosition == k)
                            wrap.attr1= profileIDMap.get(c.substringAfter('='));
                        else if(rolePosition == k )
                            wrap.attr1= roleIDMap.get(c.substringAfter('='));
                        col++;
                        break;
                    }
                    else if(flds[k].trim().equals(c.substringBefore('=').trim())&& k==1)
                    {
                        if(profPosition != k && rolePosition != k)
                            wrap.attr2= c.substringAfter('=');
                        else if(profPosition == k)
                            wrap.attr2= profileIDMap.get(c.substringAfter('='));
                        else if(rolePosition == k )
                            wrap.attr2= roleIDMap.get(c.substringAfter('='));
                        col++;
                        break;
                    }

                    else if(flds[k].trim().equals(c.substringBefore('=').trim())&&k==2)
                    { 
                        if(profPosition != k && rolePosition != k)
                            wrap.attr3= c.substringAfter('=');
                        else if(profPosition == k)
                            wrap.attr3= profileIDMap.get(c.substringAfter('='));
                        else if(rolePosition == k )
                            wrap.attr3= roleIDMap.get(c.substringAfter('='));
                        col++;
                        break;
                    }
                    else if(flds[k].trim().equals(c.substringBefore('=').trim())&&k==3)
                    { 
                        if(profPosition != k && rolePosition != k)
                            wrap.attr4= c.substringAfter('=');
                        else if(profPosition == k)
                            wrap.attr4= profileIDMap.get(c.substringAfter('='));
                        else if(rolePosition == k )
                            wrap.attr4= roleIDMap.get(c.substringAfter('='));
                        col++;
                        break;
                    }
                    else if(flds[k].trim().equals(c.substringBefore('=').trim())&&k==4)
                    { 
                        if(profPosition != k && rolePosition != k)
                            wrap.attr5= c.substringAfter('=');
                        else if(profPosition == k)
                            wrap.attr5= profileIDMap.get(c.substringAfter('='));
                        else if(rolePosition == k )
                            wrap.attr5= roleIDMap.get(c.substringAfter('='));
                        col++;
                        break;
                    }
                    else if(flds[k].trim().equals(c.substringBefore('=').trim())&&k==5)
                    { 
                        if(profPosition != k && rolePosition != k)
                            wrap.attr6= c.substringAfter('=');
                        else if(profPosition == k)
                            wrap.attr6= profileIDMap.get(c.substringAfter('='));
                        else if(rolePosition == k )
                            wrap.attr6= roleIDMap.get(c.substringAfter('='));
                        col++;
                        break;
                    }else if(flds[k].trim().equals(c.substringBefore('=').trim())&&k==6)
                    { 
                        if(profPosition != k && rolePosition != k)
                            wrap.attr7= c.substringAfter('=');
                        else if(profPosition == k)
                            wrap.attr7= profileIDMap.get(c.substringAfter('='));
                        else if(rolePosition == k )
                            wrap.attr7= roleIDMap.get(c.substringAfter('='));
                        col++;
                        break;
                    }
                                        
                }
                j++;
            }
            if(String.isBlank(wrap.attr1))
                wrap.attr1 = '';
            if(String.isBlank(wrap.attr2))
                wrap.attr2 = '';    
            if(String.isBlank(wrap.attr3))
                wrap.attr3 = '';
            if(String.isBlank(wrap.attr4))
                wrap.attr4 = '';
            if(String.isBlank(wrap.attr5))
                wrap.attr5 = '';             
            if(String.isBlank(wrap.attr6))
                wrap.attr6 = '';
            if(String.isBlank(wrap.attr7))
                wrap.attr7 = '';    
            if(String.isBlank(wrap.attr8))
                wrap.attr8 = '';
            if(String.isBlank(wrap.attr9))
                wrap.attr9 = '';
            if(String.isBlank(wrap.attr10))
                wrap.attr10 = '';            
            lstwrap.add(wrap); 
        }
        return JSON.serialize(lstwrap);
    } 
       
    //The method will make a HTTP callout to sync users from Remedyforce to EB
    public void syncUser() {
        list<String> ls;
        try{
            ls = (List<String>)JSON.deserialize( Apexpages.currentPage().getParameters().get('node'), List<string>.class ) ;
        }
        catch(Exception e)
        {
            system.debug(e);
        }
        List<BMCRF_Parser_EBCreateGroupContact.UpdatedUserWrapper> updatedUserWrapper = new List<BMCRF_Parser_EBCreateGroupContact.UpdatedUserWrapper>(); 
        List<User> updatedUsers = new List<User>();
        Integer successCounter = 0;
        Integer totalCounter = 0;
        Map<String, User> successFailureMap = new Map<String, User>();
        
        Set<ID> userToSync = new Set<ID>();        
        if(ls!=NULL)
        {for(String u: ls){
            if(u =='a' || u == 'b' || String.isBlank(u))
            {
               system.debug('SKIPPED');
            }
            else
            {
                userToSync.add(u);
                totalCounter ++;
                system.debug('ADDED'+u);
            }
        }
        }
        
        if(!userToSync.isEmpty()){
            List<User> u =  new List<User>();
            try{
                u = [select ID,BMCRF_Everbridge_Sync__c,BMCRF_EB_ID__c,Firstname, Lastname, name, email,username,FederationIdentifier, Extension, Phone, MobilePhone, street, city, PostalCode, state, country,BMCRF_EB_Country_Code__c from user where ID IN: userToSync];
                if(!u.isEmpty()){
                    BMCRF_Parser_EBCreateGroupContact ebc = new BMCRF_Parser_EBCreateGroupContact();
                    updatedUserWrapper = ebc.createEBContact(u,false);
                    system.debug('###back wrapper'+ updatedUserWrapper);
                }
            }catch(Exception e){System.debug('EXCEPTION IN BMCRF_CNTRL_SYNC.USERSYNC()'+e);}
            
        }
        
        if(updatedUserWrapper != NULL){
            try{
                for(BMCRF_Parser_EBCreateGroupContact.UpdatedUserWrapper usw: updatedUserWrapper){
                    if(usw.status == 'success'){
                        updatedUsers.add(usw.updatedUser);
                        successCounter ++;
                        system.debug('###back'+usw.updatedUser+'###'+usw.status);
                    }
                    else{
                        //Updated users error field with the http response.
                    }
                }
                update updatedUsers;
                this.displayMessage = 'Sync Successfull for ' + successCounter +' out of '+ totalCounter +' Users!';
            }catch(Exception e){
                system.debug('EXCEPTION IN BMCRF_CNTRL_SYNC.USERSYNC() UPDATING USERS:'+E);
            }
        }
        else{
                this.displayMessage = 'Sync Failed!';
        }
        
           
    } 
    
}