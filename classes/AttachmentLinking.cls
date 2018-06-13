public class AttachmentLinking {
    public Id parentId {get;set;}
    public List<Attachment> getattachmentsbyir(){
        List<Attachment> attachments;
        attachments = [select Id, Name, Owner.Name, ContentType, Parent.Name from Attachment where ParentId = :parentId];
        return attachments;
    }
}