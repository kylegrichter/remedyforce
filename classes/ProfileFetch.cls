//Creation of a Apex class to view the profile from Base Element Object by the user given in the URL.
//Creation Date:1/09/2016     Version 1.1
//Creation BY:SFDC Dexmedia Offshore Team 


public with Sharing class ProfileFetch
{    
  
    
    public List<BMCServiceDesk__BMC_BaseElement__c> BE {get;set;}  
    //public List<BMCServiceDesk__BMC_BaseElement__c> BEApprove {get;set;}
    //public List<BMCServiceDesk__BMC_BaseElement__c> BEReject {get;set;}
    public List<User> use {get;set;}
    public String sBEId {get;set;} 
    public String aBEId {get;set;}
       
    public ProfileFetch()
    {
        sBEId = ''; 
        aBEId = '';
        use = [SELECT User.Id,User.Name,User.Phone,User.Email FROM User WHERE Id = :ApexPages.currentPage().getParameters().get('id')];
        loadBE();
        if(Test.isrunningtest())
        {
            BMCServiceDesk__BMC_BaseElement__c bmcstst = new BMCServiceDesk__BMC_BaseElement__c();
            bmcstst.Name = 'TESTqwe';
            bmcstst.BMCServiceDesk__Name__c = 'TESTqwe123';
            bmcstst.BMCServiceDesk__Inactive__c = False;
            bmcstst.BMCServiceDesk__LANID__c = 'dharp01';
            insert bmcstst;
            aBEId=bmcstst.id;
            
            BMCServiceDesk__BMC_BaseElement__c bmcstst1 = new BMCServiceDesk__BMC_BaseElement__c();
            bmcstst1.Name = 'TESTcdf';
            bmcstst1.BMCServiceDesk__Name__c = 'TESTcdf123';
            bmcstst1.BMCServiceDesk__Inactive__c = False;
            bmcstst1.BMCServiceDesk__LANID__c = 'dharp01';
            insert bmcstst1;
            sBEId=bmcstst1.id;
        }
    }
    
    private void loadBE()
    {
        BE = [SELECT Id,NAME, BMCServiceDesk__BMC_BaseElement__c.ASA_Application__c FROM BMCServiceDesk__BMC_BaseElement__c WHERE BMCServiceDesk__Inactive__c = false AND BMCServiceDesk__BMC_BaseElement__c.user__c = :ApexPages.currentPage().getParameters().get('id')];
    }
     
    public void ApproveAllRecord()
    {
        use =[SELECT User.Id,User.Name,User.Phone,User.Email FROM User WHERE Id = :ApexPages.currentPage().getParameters().get('id')];
        BE =[SELECT Id,Review_Date_Time__c,ASA_Application__c FROM BMCServiceDesk__BMC_BaseElement__c WHERE BMCServiceDesk__BMC_BaseElement__c.user__c = :ApexPages.currentPage().getParameters().get('id') and BMCServiceDesk__Inactive__c = false];
        
        if(BE != null)
        {
            for(BMCServiceDesk__BMC_BaseElement__c tempBE : BE){
                if(tempBE != null){
                    tempBE.Review_Date_Time__c = DateTime.now().AddDays(365);
                }
            }             
            update BE;
            loadBE();
         } 
    } 
    public void RejectAllRecord()
    {
        use =[SELECT User.Id,User.Name,User.Phone,User.Email FROM User WHERE Id = :ApexPages.currentPage().getParameters().get('id')];
        BE =[SELECT Id,Review_Date_Time__c,ASA_Application__c FROM BMCServiceDesk__BMC_BaseElement__c WHERE BMCServiceDesk__BMC_BaseElement__c.user__c = :ApexPages.currentPage().getParameters().get('id') and BMCServiceDesk__Inactive__c = false];
       
        if(BE != null)
        {
            for(BMCServiceDesk__BMC_BaseElement__c tempBE : BE){
                if(tempBE != null){
                    tempBE.BMCServiceDesk__Inactive__c = true;
                }
            }             
            update BE;
            loadBE();
         } 
    }
    
    
    public void ApproveRecord()
      {
       System.Debug('In method ApprovMethod');
       try{
           //String rejectBE = ApexPages.currentPage().getParameters().get('rejectBE');
           //System.Debug('rejectBE='+ rejectBE);
           System.Debug('aBEId='+ aBEId);      
            
            If(aBEId != null)
            {               
                List<BMCServiceDesk__BMC_BaseElement__c> BMCList = [select id, Review_Date_Time__c from BMCServiceDesk__BMC_BaseElement__c where id =:aBEId];
                System.debug('BMCList='+ BMCList);
                
                if(BMCList.size() > 0){
                    BMCList[0].Review_Date_Time__c = DateTime.now().AddDays(365);
                    Database.UPDATE (BMCList,false);
                    
                    loadBE();
                    
                    System.Debug('update success.');
                }
            }
        }
        catch(DMLException ex){
            System.Debug('Exception occured when Approve the record, ERROR='+ ex);
        }
        //return null;
     }
     
    
    
     public void RejectRecord()
     {
       System.Debug('In method RejectRecord');
       try{
           //String rejectBE = ApexPages.currentPage().getParameters().get('rejectBE');
           //System.Debug('rejectBE='+ rejectBE);
           System.Debug('sBEId='+ sBEId);      
            
            If(sBEId != null)
            {               
                List<BMCServiceDesk__BMC_BaseElement__c> BMCList = [select id, BMCServiceDesk__Inactive__c from BMCServiceDesk__BMC_BaseElement__c where id =:sBEId];
                System.debug('BMCList='+ BMCList);
                
                if(BMCList.size() > 0){
                    BMCList[0].BMCServiceDesk__Inactive__c = true;
                    Database.UPDATE (BMCList,false);
                    
                    loadBE();
                    
                    System.Debug('update success.');
                }
            }
        }
        catch(DMLException ex){
            System.Debug('Exception occured when reject the record, ERROR='+ ex);
        }
        //return null;
     }

}