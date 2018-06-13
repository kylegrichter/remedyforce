public class BMCRF_CNTRL_EBConditionList {

    public PageReference newCondition() {
        PageReference pageRef = new PageReference('/apex/BMCRF_VF_ConditionsPage');
        return pageRef;
    }

    //public String POList { get; set; }
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
    
    //Subclass : Wrapper Class: this class will hold the details of all the column values to be displayed on the UI
    public class CondListWrapper 
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
        public CondListWrapper () 
        {

        }
    }
    public List<Schema.FieldSetMember> getFields()
    {
        return SObjectType.BMCRF_Everbridge_Incident_Conditions__c.FieldSets.Condition_Column_Header.getFields();
    }
    
    public List<String> getcolumnHeaders()
    {
        List<String> columnHeaders1 = new List<String>();
        for(Schema.FieldSetMember f:SObjectType.BMCRF_Everbridge_Incident_Conditions__c.FieldSets.Condition_Column_Header.getFields())
        {
            columnHeaders1.add(f.getLabel());
        }
        
        return columnHeaders1;    
    }
       
    //Method to bring the list of Conditions and Serialize Wrapper Object as JSON
    public String getconditionList()
    {
        List <CondListWrapper> lstwrap = new List <CondListWrapper> ();
        String query='select ';
        Integer i = 0;
        col = 0;
        List<String> flds = new list<String>();
        map<Integer,String> tmp= new map<Integer,String>();
        for(Schema.FieldSetMember f:SObjectType.BMCRF_Everbridge_Incident_Conditions__c.FieldSets.Condition_Column_Header.getFields())
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
        
        //query+='id from BMCRF_Everbridge_Incident_Conditions__c order by name desc';
        query+='id from BMCRF_Everbridge_Incident_Conditions__c order by Name__c desc';
        list<BMCRF_Everbridge_Incident_Conditions__c> conditions  = Database.query(query);
        for (BMCRF_Everbridge_Incident_Conditions__c cond : conditions) 
        {    
            String temp = String.valueOf(cond);
            CondListWrapper cwrap = new CondListWrapper();
            cwrap.id1 = cond.id;
            //cwrap.name1=cond.name;
            cwrap.name1=cond.Name__c;
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
                    else if(flds[k].trim().equals(c.substringBefore('=').trim())&&k==6)
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
                    }                    
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
    public void deleteConditions() 
    {
        //PageReference redirect=new PageReference('apex\BMCRF_VF_EBConditionList');
        //redirect.setRedirect(true);
        list<String> ls;
        try{
            ls = (List<String>)JSON.deserialize( Apexpages.currentPage().getParameters().get('node'), List<string>.class ) ;
        }
        catch(Exception e)
        {
        
        }
        
        List<BMCRF_Everbridge_Incident_Conditions__c> cond = [select id from BMCRF_Everbridge_Incident_Conditions__c where ID IN:ls];
        delete cond;
        //return redirect;
    }
}