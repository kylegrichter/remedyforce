<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>ASA_Application_Review_Notice</fullName>
        <description>ASA: Application Review Notice</description>
        <protected>false</protected>
        <recipients>
            <field>Email</field>
            <type>email</type>
        </recipients>
        <recipients>
            <field>Manager_s_Email__c</field>
            <type>email</type>
        </recipients>
        <senderAddress>clientservices1300helpdesk@dexmedia.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>BMCServiceDesk__SDE_Emails/ET40_ASA_Application_Review_VF</template>
    </alerts>
    <alerts>
        <fullName>FifteenDayLeftForASAApproval</fullName>
        <description>FifteenDayLeftForASAApproval</description>
        <protected>false</protected>
        <recipients>
            <field>Manager_Email__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/FifteenDayLeftApproval</template>
    </alerts>
    <alerts>
        <fullName>Job_Code_Change_Notification</fullName>
        <description>Job Code Change Notification</description>
        <protected>false</protected>
        <recipients>
            <field>Email</field>
            <type>email</type>
        </recipients>
        <recipients>
            <field>Manager_Email__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <recipient>logonids@dexmedia.com</recipient>
            <type>user</type>
        </recipients>
        <senderAddress>logonids@dexmedia.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>BMCServiceDesk__SDE_Emails/Job_Code_Notification</template>
    </alerts>
    <alerts>
        <fullName>OneDayLeftForASAApproval</fullName>
        <description>OneDayLeftForASAApproval</description>
        <protected>false</protected>
        <recipients>
            <field>Manager_Email__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/OneDayLeftApproval</template>
    </alerts>
    <alerts>
        <fullName>Review_Reminder_ASA_Thirty</fullName>
        <description>ThirtyDayLeftForASAApproval</description>
        <protected>false</protected>
        <recipients>
            <field>Manager_Email__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/ThirtyDayLeftApproval</template>
    </alerts>
    <fieldUpdates>
        <fullName>BMCRF_UserFieldUpdate</fullName>
        <description>EBSync field to update with value as &apos;false&apos;.</description>
        <field>BMCRF_Everbridge_Sync__c</field>
        <literalValue>0</literalValue>
        <name>BMCRF_UserFieldUpdate</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Email_Ud</fullName>
        <field>Manager_Email__c</field>
        <formula>Manager.Email</formula>
        <name>Email_Ud</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Null_out_Primary_Queue_if_value_is_NULL</fullName>
        <field>Primary_Queue_Assignment__c</field>
        <name>Null out Primary Queue if value is NULL</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Users_Manager_s_Email</fullName>
        <field>Manager_s_Email__c</field>
        <formula>Manager_s_Email_Formula__c</formula>
        <name>Update Users Manager&apos;s Email</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>ASA%3A Review Access</fullName>
        <active>false</active>
        <description>Sends notification to users manager if Review date is within 30 days.</description>
        <formula>NOT( ISNULL(ASA_Application_Review_Date_Time__c  )) &amp;&amp;
ASA_Application_Review_Date_Time__c  &lt;= NOW() + 30</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>ASA_Application_Review_Notice</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>User.ASA_Application_Review_Date_Time__c</offsetFromField>
            <timeLength>-1</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
        <workflowTimeTriggers>
            <actions>
                <name>ASA_Application_Review_Notice</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>User.ASA_Application_Review_Date_Time__c</offsetFromField>
            <timeLength>-15</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
        <workflowTimeTriggers>
            <offsetFromField>User.ASA_Application_Review_Date_Time__c</offsetFromField>
            <timeLength>0</timeLength>
            <workflowTimeTriggerUnit>Hours</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>BMCRF_EBUserUpdate</fullName>
        <actions>
            <name>BMCRF_UserFieldUpdate</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND(NOT(ISNEW()),(ISCHANGED(Email) ||  ISCHANGED(FirstName) || ISCHANGED(LastName) || ISCHANGED( Username )||ISCHANGED( Phone )||ISCHANGED( MobilePhone ) || ISCHANGED( Street )||ISCHANGED( City )||ISCHANGED( State ) || ISCHANGED( Country )))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Clear Primary Queue if NULL</fullName>
        <actions>
            <name>Null_out_Primary_Queue_if_value_is_NULL</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>TEXT(Primary_Queue_Assignment__c) = &quot;NULL&quot;</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Email_Update_manager</fullName>
        <actions>
            <name>Email_Ud</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>User.ManagerId</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Keep Manager Email in Sync</fullName>
        <actions>
            <name>Update_Users_Manager_s_Email</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>User.Manager_s_Email_Formula__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Review Reminder ASA Fifteen</fullName>
        <active>false</active>
        <booleanFilter>1</booleanFilter>
        <criteriaItems>
            <field>User.Review_Date__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>This workflow is used to send reminder mail to user and manager who&apos;s review date is within 15 day.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>FifteenDayLeftForASAApproval</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>User.Review_Date__c</offsetFromField>
            <timeLength>-15</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Review Reminder ASA One</fullName>
        <active>false</active>
        <booleanFilter>1</booleanFilter>
        <criteriaItems>
            <field>User.Review_Date__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>This workflow is used to send reminder mail to user and manager who&apos;s review date is within 1 day.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>OneDayLeftForASAApproval</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>User.Review_Date__c</offsetFromField>
            <timeLength>-1</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Review Reminder ASA Thirty</fullName>
        <active>false</active>
        <criteriaItems>
            <field>User.Review_Date__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>This workflow is used to send reminder mail to user and manager who&apos;s review date is within 30 day.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Review_Reminder_ASA_Thirty</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>User.Review_Date__c</offsetFromField>
            <timeLength>-30</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
</Workflow>
