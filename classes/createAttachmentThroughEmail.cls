/******************************************************************************
Name:  createAttachmentThroughEmail 
Copyright © 2014  DexMedia Inc. 
==============================================================================
Purpose:                                                            
This class create Attachments from Service Cloud to Remedy when inserted in SC.
==============================================================================
History                                                            
-------                                                            
VERSION     AUTHOR              DATE           DETAIL           FEATURES/CSR/TTP
------      ------              -----         ---------         -----------------
1.0       Guru R. Vattam      04/10/2014    Initial Development      
*****************************************************************************/
global class createAttachmentThroughEmail implements Messaging.InboundEmailHandler {
    global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email, Messaging.InboundEnvelope envelope) {
          Messaging.InboundEmailResult result = new Messaging.InboundEmailresult();
          string str = email.plainTextBody ;
          BMCServiceDesk__Incident__c incObj =[Select Id,Name from BMCServiceDesk__Incident__c where Name=:str];
          list<attachment> LstOfAttachments = new list<Attachment>();
          if (email.textAttachments != null && email.textAttachments.size() > 0) { 
              for (integer i=0;i<email.textAttachments.size();i++) {
                  Attachment attachment = new Attachment();
                  attachment.Name = email.textAttachments[i].filename;
                  attachment.Body = Blob.valueOf(email.textAttachments[i].body);
                  attachment.ParentId = incObj.Id;
                  insert attachment;
              }
          }
          if(email.binaryAttachments != null && email.binaryAttachments.size() > 0) {
              for(integer i=0;i<email.binaryAttachments.size();i++)
              {
                  Attachment AttIns = new Attachment();
                  AttIns.body = email.binaryAttachments[i].body;
                  AttIns.ParentId = incObj.Id;
                  AttIns.name = email.binaryAttachments[i].filename;
                  insert AttIns ;
              }      
          }
          return result;
        }  
}