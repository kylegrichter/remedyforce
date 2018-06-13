//Creation of a Apex class to view the profile from Base Element Object by the user given in the URL.
//Creation Date:2/16/2017     Version 1.1
//Creation BY:Papia Dhar


public with Sharing class UserReviewDate
{    
  
    
   // public List<BMCServiceDesk__BMC_BaseElement__c> BE {get;set;}  
    //public List<BMCServiceDesk__BMC_BaseElement__c> BEApprove {get;set;}
    //public List<BMCServiceDesk__BMC_BaseElement__c> BEReject {get;set;}
  
    //public String sBEId {get;set;} 
    //public String aBEId {get;set;}
       
    /*public UserReviewDate()
    {
        
    }*/
    
       
     public void UpdateReviewDate(List<BMCServiceDesk__BMC_BaseElement__c> bmcList)
     {
       System.Debug('In method UpdateReviewDate');
       try{
          
            Set<Id> setBmcIds = new Set<Id>();
            for (BMCServiceDesk__BMC_BaseElement__c  bmcServiceDesk : bmcList) 
            {  

            setBmcIds.add(bmcServiceDesk.id); 
            }   
            System.Debug('In method UpdateReviewDate setBmcIds:'+setBmcIds);
            If(setBmcIds != null && setBmcIds.size() >0)
            {               
                
                List<BMCServiceDesk__BMC_BaseElement__c> rviewDtList = [select id, Review_Date_Time__c,User__c from BMCServiceDesk__BMC_BaseElement__c where id IN : setBmcIds  ORDER BY Review_Date_Time__c DESC];

                System.debug('rviewDtList ='+ rviewDtList );
                BMCServiceDesk__BMC_BaseElement__c bmc=rviewDtList.get(0);

               
                 System.debug('papia bmc object ='+ bmc);
                  System.debug('papia bmc object User__c ='+ bmc.User__c);
                
                User use= [Select Id,Review_Date__c from User where id = :bmc.User__c];
                
                datetime minDate = bmc.Review_Date_Time__c;
                
                system.debug('mindate papia:'+minDate);
                
                if( use.Review_Date__c !=null && minDate < use.Review_Date__c){
                    
                    use.Review_Date__c=mindate;
                    List<User> uselist=new List<User>();
                    uselist.add(use);
                    Database.UPDATE (uselist ,false);
                    
                                       
                    System.Debug('update success in if.');
                }
            else if ( use.Review_Date__c ==null)
            {
              
                System.debug('Else block =');
                use.Review_Date__c=mindate;
                List<User> uselist=new List<User>();
                uselist.add(use);
                Database.UPDATE (uselist ,false);
                System.Debug('update success in else.');
                
            }
         }
      }
        catch(DMLException ex){
            System.Debug('Exception occured when reject the record, ERROR='+ ex);
        }
        //return null;
     }

}