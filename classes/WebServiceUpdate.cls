global class WebServiceUpdate {
  
    global class BEInfo{
        
        webService String empID;
        webService String lastName;
        webService String firstName;
        webService String profileId;
        webService String profileName;
        webService String baseElementLANID;
        webservice String baseElementName;
       
  }
  
   global class BEInfoRet{
        
        webService String baseElementIdRet;
     // webservice String baseElementNameRet;
       
  }
    
    webservice static List<BEInfoRet> UpdateBEInactive( List<BEInfo> BEi ){
        
        String access = 'kGen Profile';
    
        
        List<BEInfoRet> beretList=new List<BEInfoRet> () ;
          Set<String> tempBeNameSet = new Set<String>(); 
           Set<String> idSet = new Set<String>(); 
           if(BEi!= null){
                            
                                    for(BEInfo tempBEF: BEi){
                                          if(tempBEF!= null){
                                                      
                                                     tempBeNameSet.add(tempBEF.baseElementName.trim());     
                                          }
                                      }
                                  } 
 List <BMCServiceDesk__BMC_BaseElement__c> BEset = [ SELECT id,BMCServiceDesk__Inactive__c,Name from BMCServiceDesk__BMC_BaseElement__c where BMCServiceDesk__Inactive__c=false and Name IN : tempBeNameSet ];                     
 List <BMCServiceDesk__BMC_BaseElement__c> BE = new List<BMCServiceDesk__BMC_BaseElement__c>(BEset); 
        List<BMCServiceDesk__BMC_BaseElement__c> newBEList = new List<BMCServiceDesk__BMC_BaseElement__c>(); 
        
        
        integer cnt=0;
        if(BEi != null){
            
            for (BMCServiceDesk__BMC_BaseElement__c BElement : BEset ) {
            //BEInfoRet bir =new BEInfoRet();
            BElement.BMCServiceDesk__Inactive__c = True;//need to make true.change to false as per testing
            System.debug('Belement size: ' + BElement );
             // BE[0].BMCServiceDesk__Inactive__c = True;//need to make true.change to false as per testing
                         
                       // bir.baseElementIdRet=BE[0].id;
                       // bir.baseElementNameRet=BE[0].Name;
                       // beretList.add(bir);
                        
                        newBEList.add(BElement);
            }
            
         If(newBEList.size()>0)
            {
            try
            {
           
              List<Database.SaveResult> updateResults;
        updateResults= database.update(newBEList,false);
        List<LogDb__c> LogList=new List<LogDb__c>();
      for(Integer i=0;i<updateResults.size();i++){

            LogDb__c ldc=new LogDb__c();
          if (updateResults.get(i).isSuccess()){
               BEInfoRet retBEFTempVal=new BEInfoRet ();
               retBEFTempVal.baseElementIdRet= updateResults.get(i).getId();
               beretList.add(retBEFTempVal);
            }
           /* else if (!updateResults.get(i).isSuccess() ){
                                           
                // DML operation failed
                Database.Error error = updateResults.get(i).getErrors().get(0);
                string errorID=error.getMessage();
                ldc.Log_Detail__c = error.getMessage();
                ldc.Operation__c='update';
                //newBEList.get(i);//failed record from the list
               ldc.errorId__c=newBEList.get(i).Name;
              // system.debug('Faile Record:'+newBEList.get(i).Id);
               // ldc.errorId__c=errorID.right(15);
                LogList.add(ldc);
            }*/
            

        }
       /* if(LogList!=null && LogList.size()>0)
                  {
                       database.insert(LogList,false);
                  } 
            */
          // database.update(newBEList,false);
           } catch(DmlException e) {

                       System.debug('The following exception has occurred: ' + e.getMessage());
                       }
           }
           
        }
           return beretList;                      
    }
    
    webservice static List<BEInfoRet> UpdateBEASAVerifiedDate( List<BEInfo> BEi ){
        
        String access = 'kGen Profile';
       
         List<BEInfoRet> beretList=new List<BEInfoRet> () ;
          BEInfoRet bir =new BEInfoRet();
       
        Set<String> tempBeNameSet = new Set<String>(); 
           if(BEi!= null){
                            
                                    for(BEInfo tempBEF: BEi){
                                          if(tempBEF!= null){
                                                      
                                                     tempBeNameSet.add(tempBEF.baseElementName.trim());     
                                          }
                                      }
                                  }                     
        
         List <BMCServiceDesk__BMC_BaseElement__c> BEset = [ SELECT id,ASA_Verified_Date_Time__c,Name from BMCServiceDesk__BMC_BaseElement__c where Name IN : tempBeNameSet];  
        List<BMCServiceDesk__BMC_BaseElement__c> newBEList = new List<BMCServiceDesk__BMC_BaseElement__c>(); 
        if(BEi != null){
          
              for (BMCServiceDesk__BMC_BaseElement__c BElement : BEset ) {
          
            BElement.ASA_Verified_Date_Time__c = DateTime.now();
             
                         
                       // bir.baseElementIdRet=BElement.id;
                        //bir.baseElementNameRet=BElement.Name;
                       // beretList.add(bir);
                        
                        newBEList.add(BElement);
            }
            
           
           If(newBEList.size()>0)
            {
            try
            {
         
              List<Database.SaveResult> updateResults;
        updateResults= database.update(newBEList,false);
        List<LogDb__c> LogList=new List<LogDb__c>();
      for(Integer i=0;i<updateResults.size();i++){

           // LogDb__c ldc=new LogDb__c();
          if (updateResults.get(i).isSuccess()){
               BEInfoRet retBEFTempVal=new BEInfoRet ();
               retBEFTempVal.baseElementIdRet= updateResults.get(i).getId();
               beretList.add(retBEFTempVal);
            }
           /* else if (!updateResults.get(i).isSuccess()){
                                           
                // DML operation failed
                Database.Error error = updateResults.get(i).getErrors().get(0);
                string errorID=error.getMessage();
                ldc.Log_Detail__c = error.getMessage();
                ldc.Operation__c='update';
                //newBEList.get(i);//failed record from the list
               ldc.errorId__c=newBEList.get(i).Name;
                //ldc.errorId__c=errorID.right(15);
                 LogList.add(ldc);
            }*/
           

        }
       /* if(LogList!=null && LogList.size()>0)
                  {
                       database.insert(LogList,false);
                  } */
           
         // database.update(newBEList,false);
           } catch(DmlException e) {

                       System.debug('The following exception has occurred: ' + e.getMessage());
                       }
           } 
            
            
           
             
           /* If(newBEList.size()>0)
            {
           database.update(newBEList,false);
           
           }*/
           
        }
        return beretList;    
    }
}