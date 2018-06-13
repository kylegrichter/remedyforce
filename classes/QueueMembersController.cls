public with sharing class QueueMembersController {

    // selected queue whose members to view
    public ID queueId { get; set; }
    
    // provide queue name to show on page
    public Group selectedQueue {
        get {
            return [
				SELECT
                	id, name
                FROM
                	group
                WHERE
                	id = :queueId
            ];
        }
    }
    
    // list of all active queue members
    public List<User> queueMembers {
        get {
            return [
            	SELECT
                	id, firstName, lastName, isActive, username, email, userRole.name, profile.name, BMCServiceDesk__IsStaffUser__c 
                FROM
                	user
                WHERE
                	id IN (SELECT userOrGroupId FROM groupmember WHERE groupId = :queueId )
				AND 
               	isActive = true
                ORDER BY firstName ASC                                	
            ];          
        }
    }
    
    
    /**
     * Controller
     */
    public QueueMembersController() {
        queueId = ApexPages.currentPage().getParameters().get('queueId');
    }
    
    public PageReference refresh() {
        return null;
    }
    
    // picklist of queues whose members to view
    public List<SelectOption> getQueueOptions() {
        
        List<SelectOption> options = new List<SelectOption>();

        options.add( new SelectOption( '', '- Select -' ) );
        for ( Group grp : [
            SELECT
            	id, name
            FROM
            	group
           	WHERE
            	type = 'Queue'
           	ORDER BY
            	name
        ] ) {
            options.add( new SelectOption( grp.id, grp.name ) );
        }
        
        return options;
    }
    
}

/**
* THIS CODE AND INFORMATION IS PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESSED 
* OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR 
* FITNESS FOR A PARTICULAR PURPOSE.
*
* This script is not supported under any BMC Software standard support program or service. 
* The script is provided AS IS without warranty of any kind. BMC Software further disclaims all
* implied warranties including, without limitation, any implied warranties of merchantability
* or of fitness for a particular purpose. The entire risk arising out of the use or performance
* of the scripts and documentation remains with you. In no event shall BMC Software, its authors,
* or anyone else involved in the creation, production, or delivery of the script be liable for 
* any damages whatsoever (including, without limitation, damages for loss of business profits, 
* business interruption, loss of business information, or other pecuniary loss) arising out of 
* the use of or inability to use the script or documentation, even if BMC Software has been advised 
* of the possibility of such damages.
* 
* We'd like to thank Doug Ayers (https://douglascayers.wordpress.com/) for graciously allowing us
* to use his code in this unmanaged package!
**/