/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an organization are executed whenever Apex code is deployed
 * to a production organization to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production organization. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the organization size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest
private class QueueMembersControllerTest {
 
    @isTest
    static void test_refresh() {

        QueueMembersController controller = new QueueMembersController();
        
        Test.startTest();
        
        PageReference ref = controller.refresh();
        
        Test.stopTest();
        
        System.assert( ref == null );
        
    }
    
    @isTest
    static void test_get_queue_info() {
     
        Group queue = null;
        GroupMember groupMember = null;

        // avoid DML mixed operation exception
        // http://salesforce.stackexchange.com/questions/13318/error-mixed-dml-operation-on-setup-and-non-setup-objects
        System.runAs( new User( Id = UserInfo.getUserId() ) ) {

            queue = new Group();
            queue.name = 'Test Queue 1';
            queue.developerName = 'Test_Queue_1';
            queue.type = 'Queue';

            insert queue;
            
            groupMember = new GroupMember();
            groupMember.userOrGroupId = UserInfo.getUserId();
            groupMember.groupId = queue.id;
            
            insert groupMember;
            
        }
        
        PageReference pageRef = Page.QueueMembersListPage;

        Test.setCurrentPage( pageRef );
        
        ApexPages.currentPage().getParameters().put( 'queueId', queue.id );
        
        QueueMembersController controller = new QueueMembersController();
        
        Test.startTest();
        
		List<SelectOption> options = controller.getQueueOptions();
        
        List<User> queueMembers = controller.queueMembers;
        
        Group selectedQueue = controller.selectedQueue;
        
        Test.stopTest();
            
        System.assert( options.size() > 0 );
        
        Boolean isFound = false;
        for ( SelectOption option : options ) {
            if ( option.getLabel() == 'Test Queue 1' ) {
                isFound = true;
            }
        }
        System.assert( isFound );
        
        System.assert( selectedQueue != null );
        System.assertEquals( queue.id, controller.queueId );
        System.assertEquals( queue.id, selectedQueue.id );
        
        System.assert( queueMembers.size() > 0 );
        
        isFound = false;
        for ( User usr : queueMembers ) {
            if ( usr.id == groupMember.userOrGroupId ) {
                isFound = true;
            }
        }
        System.assert( isFound );
        
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