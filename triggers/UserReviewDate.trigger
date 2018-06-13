trigger UserReviewDate on BMCServiceDesk__BMC_BaseElement__c (after update) {
  
    List<BMCServiceDesk__BMC_BaseElement__c> bmcList = new List<BMCServiceDesk__BMC_BaseElement__c>();
    
       system.debug('new sobject value Papia:'+trigger.new);
       
     for(BMCServiceDesk__BMC_BaseElement__c bm : trigger.new){
     
     bmcList.add(bm);
     
     }
      BMCServiceDesk__BMC_BaseElement__c bmc=bmcList.get(0);
      
      If(bmc.user__c!=null && bmc.Review_Date_Time__c !=null)
      {
            UserReviewDate urd=new UserReviewDate();
            urd.UpdateReviewDate(bmcList);
     }



}