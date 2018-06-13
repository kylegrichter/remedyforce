public with Sharing class ASAApplicationReview
{    
  
    
    public List<BMCServiceDesk__BMC_BaseElement__c> BE {get;set;}  
    public List<BMCServiceDesk__BMC_BaseElement__c> BEApprove {get;set;}
    public List<BMCServiceDesk__BMC_BaseElement__c> BEReject {get;set;}
    public List<User> use {get;set;}
    public String sBEId {get;set;} 
    public String aBEId {get;set;}
       
    public ASAApplicationReview()
    {
        sBEId = ''; 
        aBEId = '';
        use = [SELECT User.Id,User.Name,User.Phone,User.Email,User.Manager.Id FROM User WHERE Id = :ApexPages.currentPage().getParameters().get('id')];
        loadBE();
    }
    
    private void loadBE()
    {
        BE = [SELECT Id, Name, ASA_Application__c, ASA_Application__r.Additional_System_Access_Label__c, ASA_Application__r.kGen_Profile__c, ASA_Approved_Date_Time__c, Review_Date_Time__c FROM BMCServiceDesk__BMC_BaseElement__c WHERE BMCServiceDesk__Inactive__c = false AND BMCServiceDesk__BMC_BaseElement__c.user__c = :ApexPages.currentPage().getParameters().get('id')];
    }
     
    public void ApproveAllRecord()
    {
        use =[SELECT User.Id,User.Name,User.Phone,User.Email,User.Manager.Id FROM User WHERE Id = :ApexPages.currentPage().getParameters().get('id')];
        BE =[SELECT Id,ASA_Application__r.Id FROM BMCServiceDesk__BMC_BaseElement__c WHERE BMCServiceDesk__BMC_BaseElement__c.user__c = :ApexPages.currentPage().getParameters().get('id')];
        List<BMCServiceDesk__BMC_BaseElement__c> allBE = [SELECT Id,ASA_Application__r.Id FROM BMCServiceDesk__BMC_BaseElement__c];
        if(BE != null && allBE != null)
        {
            for(BMCServiceDesk__BMC_BaseElement__c tempBE : BE){
                tempBE.Review_Date_Time__c = DateTime.now().AddDays(365);
                //if(tempBE != null){
                    //for(BMCServiceDesk__BMC_BaseElement__c tempAllBE : allBE){
                        //if(tempAllBE != null && tempAllBE.id == tempBE.id){
                        //    tempAllBE.Review_Date_Time__c = DateTime.now().AddDays(365);
                        //}
                    //}             
                    
                //}
            }
            update BE;
            loadBE();
            
        }
    }
    public void RejectAllRecord()
    {
        use =[SELECT User.Id,User.Name,User.Phone,User.Email,User.Manager.Id FROM User WHERE Id = :ApexPages.currentPage().getParameters().get('id')];
        BE =[SELECT Id,Review_Date_Time__c,ASA_Application__c FROM BMCServiceDesk__BMC_BaseElement__c WHERE BMCServiceDesk__BMC_BaseElement__c.user__c = :ApexPages.currentPage().getParameters().get('id')];
       
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

           //String rejectBE = ApexPages.currentPage().getParameters().get('rejectBE');
           //System.Debug('rejectBE='+ rejectBE);
           System.Debug('aBEId='+ aBEId);      
            
            If(aBEId != null)
            {               
                List<BMCServiceDesk__BMC_BaseElement__c> BMCList = [select id, Review_Date_Time__c from BMCServiceDesk__BMC_BaseElement__c where id =:aBEId];
                System.debug('BMCList='+ BMCList);
                
                if(BMCList.size() > 0){
                    BMCList[0].Review_Date_Time__c = DateTime.now().AddDays(365);
                    UPDATE BMCList;
                    
                   loadBE();
                    
                    System.Debug('update success.');
                }
            }
     }
     
    
    
     public void RejectRecord()
     {
       System.Debug('In method RejectRecord');

           //String rejectBE = ApexPages.currentPage().getParameters().get('rejectBE');
           //System.Debug('rejectBE='+ rejectBE);
           System.Debug('sBEId='+ sBEId);      
            
            If(sBEId != null)
            {               
                List<BMCServiceDesk__BMC_BaseElement__c> BMCList = [select ASA_Application__r.id,ASA_Application__r.BMCServiceDesk__Inactive__c from BMCServiceDesk__BMC_BaseElement__c where id =:sBEId];
                System.debug('BMCList='+ BMCList);
                
                if(BMCList.size() > 0){
                    BMCList[0].BMCServiceDesk__Inactive__c = true;
                    UPDATE BMCList;
                    
                    loadBE();
                    
                    System.Debug('update success.');
                }
            }

     }

}