<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Notify_Assigned_SME_Of_Assignment</fullName>
        <description>Notify Assigned SME Of Assignment</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Executive_Support/Notify_ESS_Assigned_SME_Record_Assigned</template>
    </alerts>
    <fieldUpdates>
        <fullName>Change_ESS_Status_to_Closed</fullName>
        <field>Status__c</field>
        <literalValue>Closed</literalValue>
        <name>Change ESS Status to Closed</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Change_ESS_Status_to_Open</fullName>
        <field>Status__c</field>
        <literalValue>Open</literalValue>
        <name>Change ESS Status to Open</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Null_ESS_Close_Date</fullName>
        <field>Close_Date__c</field>
        <name>Null ESS Close Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>If Closed Date is Not Null Set Status to Closed</fullName>
        <actions>
            <name>Change_ESS_Status_to_Closed</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>NOT(ISNULL( Close_Date__c ))&amp;&amp; 
ISCHANGED( Close_Date__c )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>If Closed Date is Null Set Status to Open</fullName>
        <actions>
            <name>Change_ESS_Status_to_Open</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <formula>ISNULL( Close_Date__c )  &amp;&amp; 
ISCHANGED( Close_Date__c )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>If Status is Changed from Closed NULL Close Date</fullName>
        <actions>
            <name>Null_ESS_Close_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>NOT(ISNULL( Close_Date__c ))&amp;&amp;
ISCHANGED(Status__c)&amp;&amp;
NOT(ISPICKVAL(Status__c,&quot;Closed&quot;))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Notify ESS Assigned SME if Changed</fullName>
        <actions>
            <name>Notify_Assigned_SME_Of_Assignment</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <formula>ISCHANGED(OwnerId)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
