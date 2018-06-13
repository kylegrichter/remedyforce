public class Custom_GroupMember_Controller {

   @future (callout=true)   
   //##############################
   // Create A Queue Member Method
   //##############################
   public static void CreateMemberRcd( string UserID, string GroupID ){
   
       GroupMember QueueMemberRecord = new GroupMember ( 
                                                         UserOrGroupId = UserID, 
                                                         GroupID       = GroupID 
                                                        );
                                                        
       INSERT QueueMemberRecord;                                                       
  
   }   
   @future (callout=true)
   //##############################
   // Remove A Queue Member Method
   //##############################
   public static void RemoveMemberRcd( string UserID, string GroupID ){
   
       GroupMember QueueMemberRecord = [ SELECT Id, UserOrGroupId
                                         FROM GroupMember 
                                         WHERE UserOrGroupId = :UserID
                                         AND GroupId         = :GroupId ];
                                         
       DELETE QueueMemberRecord;                       
  
   }   








}