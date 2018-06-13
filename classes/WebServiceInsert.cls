/*****Code to insert the KGEN data into Salesforce*****/
/*****Developer Name:Papia Dhar******/
/*****Created Date:15/09/2016*******/


global class WebServiceInsert {
   
    // This class is used to return fields only through webservice 
   global class BEInfoRet{
        webService String beId;
        //webService String beName;
    }
    // This class is used to expose fields only required fields through webservice
    global Class BaseElementFields {
        
        webService String empID;
        webService String lastName;
        webService String firstName;
        webService String profileId;
        webService String profileName;
        webService String baseElementLANID;
        webservice String baseElementName;
    }
  
   
  //Webservice to be called through TIBCO
  
    webservice static List<BEInfoRet> insertNewBE( List<BaseElementFields> befList ){

         System.debug('The following code has occurred: ');
        String access = 'kGen Profile';
        String tempName='';
        //List<BEInfoRet> beretList=new List<BEInfoRet> ();
         List<BEInfoRet> beretListVal=new List<BEInfoRet> ();/*Variable use for return*/

        Set<String> beretNameSet=new Set<String> ();
        //List<BaseElementFields> lstReceived =BEi.lstBaseElementFields;//
        //List<BMCServiceDesk__BMC_BaseElement__c> receivedBEList = BEi.kgen_remedyforce;
        List<BMCServiceDesk__BMC_BaseElement__c> newBEList = new List<BMCServiceDesk__BMC_BaseElement__c>(); 
        
                                BEInfoRet bir =new BEInfoRet();
                                Integer count=1;
                                Map<Integer,BaseElementFields> tempObjMap = new Map<Integer,BaseElementFields>();  
                                Map<String,BMCServiceDesk__BMC_BaseElement__c> tempNameMap = new Map<String,BMCServiceDesk__BMC_BaseElement__c>();  
                                Map<String,User > tempLanIdMap = new Map<String,User>();  
                                //Fetching all BaseElementFields
                                Set<String> tempNameSet = new Set<String>(); 
                                Set<String> lanIdSet = new Set<String>();
                                 Set<String> tempBeNameSet = new Set<String>(); 
                                String profileId='';
                                if(befList != null){
                                    System.debug('Total Record: ' + befList.size()); 
                                    for(BaseElementFields  tempBEF: befList ){
                                          if(tempBEF!= null){
                                                      System.debug('Profile Id: ' + tempBEF.profileId);
                                                      profileId=tempBEF.profileId;
                                                      profileId='ASA-TRUSTEE-KGEN-'+profileId;
                                                      System.debug('After Adding Profile Id: ' + profileId);
                                                      tempNameSet.add(profileId);
                                                      lanIdSet.add(tempBEF.baseElementLANID.trim()); 
                                                     // tempBeNameSet.add(tempBEF.baseElementName.trim());     
                                          }
                                      }
                                  }
                                  System.Debug('tempNameSet='+ tempNameSet);
                          
                      List <BMCServiceDesk__BMC_BaseElement__c> recList = [ SELECT id,name from BMCServiceDesk__BMC_BaseElement__c where Additional_System_Access__c ='kGen Profile' and Name IN : tempNameSet  ];     
                      System.Debug('recList='+ recList);
                      List <User> uIdList = [ SELECT id,FederationIdentifier  from User where FederationIdentifier IN :lanIdSet];
                       
                      if(recList != null && recList.size() > 0)
                      {
                        for(BMCServiceDesk__BMC_BaseElement__c  tempBBB: recList ){
                              if(tempBBB!= null){                             
                                 tempNameMap.put(tempBBB.name,tempBBB);
                              }
                          }
                      }
                      System.debug('tempNameMap : ' + tempNameMap); 
                                   
                      if(uIdList  != null)
                      {
                        for(User tempUser: uIdList ){
                              if(tempUser!= null){
                              
                                          tempLanIdMap.put(tempUser.FederationIdentifier,tempUser);

                              }
                          }
                      } 
                      System.debug('tempLanIdMap : ' + tempLanIdMap);             
                              
                                 
                                                      
         if(befList != null){
            for(BaseElementFields  tempBEF: befList ){
                if(tempBEF!= null){
                    BMCServiceDesk__BMC_BaseElement__c BE =new BMCServiceDesk__BMC_BaseElement__c();
                    BE.Name = tempBEF.BaseElementName;
                    BE.BMCServiceDesk__Name__c=tempBEF.BaseElementName;
                    tempName='ASA-Trustee-kGen-'+tempBEF.profileId;
                    BMCServiceDesk__BMC_BaseElement__c BEASA=null;
                    try
                    {
                      BEASA=tempNameMap.get(tempName);
                       System.debug('*****BEASA***** : ' + BEASA);             
                       if(BEASA!=null)
                       {
                        BE.ASA_Application__c = BEASA.Id;
                        
                           User uId =tempLanIdMap.get(tempBEF.baseElementLANID.trim());
                           
                          System.debug('*****User ***** : ' + uId );             
                         if(uId==null)
                          {
                              BE.User__c = null;
                              
                              BE.BMCServiceDesk__CMDB_Class__c = 'a1BE000000KXkHr';       
                              BE.BMCServiceDesk__LANID__c = null;
                             
                              newBEList.add(BE);
                              tempBeNameSet.add(BE.BMCServiceDesk__Name__c);
                          }
                          else if(uId!=null)
                          {
                              
                              BE.User__c = uId.Id;
                                                            BE.BMCServiceDesk__CMDB_Class__c = 'a1BE000000KXkHr';       
                              BE.BMCServiceDesk__LANID__c = tempBEF.BaseElementLANID;
                             
                              newBEList.add(BE);
                               tempBeNameSet.add(BE.BMCServiceDesk__Name__c);
                          }
                          
                       }
                     }catch(DmlException e) {

                       System.debug('The following exception has occurred: ' + e.getMessage());
                       }
                }
            }
            
           
             if(newBEList!=null && newBEList.size()>0)
            {
            try{
            List<Database.SaveResult> insertResults;
        insertResults= Database.insert(newBEList, false);
        List<LogDb__c> LogList = new List<LogDb__c>();
      for(Integer i=0;i<insertResults.size();i++)
      {

            
          if (insertResults.get(i).isSuccess()){
               BEInfoRet retBEFTempVal=new BEInfoRet ();
               retBEFTempVal.beId = insertResults.get(i).getId();
               beretListVal.add(retBEFTempVal);
            }
            else if (!insertResults.get(i).isSuccess()){                  
                LogDb__c ldc=new LogDb__c();    
                // DML operation failed
                Database.Error error = insertResults.get(i).getErrors().get(0);
                string errorID=error.getMessage();
                ldc.Log_Detail__c = error.getMessage();
                ldc.Operation__c='insert';
                //newBEList.get(i);//failed record from the list
                ldc.errorId__c=newBEList.get(i).Name;
                //ldc.errorId__c=errorID.right(15);
                 LogList.add(ldc);
            }
           

        }
        
         if(LogList!=null && LogList.size()>0)
          {
               database.insert(LogList,false);
          } 
         }
         catch(DmlException e)
         {
               System.debug('The following exception has occurred: ' + e.getMessage());
         }
         } 
            
                    
          
        }
       
          return  beretListVal;                      
    }

}