/******************************************************************************
Name:  createAttachmentThroughEmailTest
Copyright © 2014  DexMedia Inc. 
==============================================================================
Purpose:                                                            
This class covers positive and negative scenarios to
create Attachments from Service Cloud to Remedy when inserted in SC.
==============================================================================
History                                                            
-------                                                            
VERSION     AUTHOR              DATE           DETAIL           FEATURES/CSR/TTP
------      ------              -----         ---------         -----------------
1.0       Guru R. Vattam      04/10/2014    Initial Development      
*****************************************************************************/
@isTest(SeeAllData=true) 
public class createAttachmentThroughEmailTest
{  
  public static testMethod void testCreateAttachFrmEmail() {

     // create a new email and envelope object
     
   Messaging.InboundEmail email = new Messaging.InboundEmail() ;
   Messaging.InboundEnvelope env = new Messaging.InboundEnvelope();
   
   // setup the data for the email
   
  email.subject = 'Test Job Applicant';
  email.fromAddress = 'someaddress@email.com';
  email.plainTextBody='00003000';
 
  // add an Text atatchment
  Messaging.InboundEmail.TextAttachment attachmenttext = new Messaging.InboundEmail.TextAttachment();
  attachmenttext.body = 'my attachment text';
  attachmenttext.fileName = 'textfiletwo.txt';
  attachmenttext.mimeTypeSubType = 'texttwo/plain';
  email.textAttachments =   new Messaging.inboundEmail.TextAttachment[] { attachmenttext };

  // add an Binary attachment
  Messaging.InboundEmail.BinaryAttachment attachment = new Messaging.InboundEmail.BinaryAttachment();
  attachment.body = blob.valueOf('my attachment text');
  attachment.fileName = 'textfileone.txt';
  attachment.mimeTypeSubType = 'text/plain';
  email.binaryAttachments = new Messaging.inboundEmail.BinaryAttachment[] { attachment };
        
  // call the email service class and test it with the data in the testMethod
  createAttachmentThroughEmail  testInbound=new createAttachmentThroughEmail();
  testInbound.handleInboundEmail(email, env);
  
   
}
}