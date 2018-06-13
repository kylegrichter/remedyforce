@IsTest
public class BMCRF_Parser_phaseTemplate_Test {
    
    // This test method should give 100% coverage
    static testMethod void testParse() {
        String json = '{'+
        '  \"message\": \"OK\",'+
        '  \"result\": {'+
        '    \"id\": 1323816294812794,'+
        '    \"name\": \"External Service Outage (Client Notification)\",'+
        '    \"templateStatus\": \"Live\",'+
        '    \"phaseTemplates\": ['+
        '      {'+
        '        \"templateId\": 0,'+
        '        \"name\": \"New\",'+
        '        \"messageFlag\": 3,'+
        '        \"contactsFlag\": 3,'+
        '        \"settingsFlag\": 3,'+
        '        \"phaseDefinitions\": ['+
        '          {'+
        '            \"id\": 1001,'+
        '            \"status\": \"A\",'+
        '            \"isDefault\": false,'+
        '            \"name\": \"New\",'+
        '            \"seq\": 0'+
        '          }'+
        '        ],'+
        '        \"formTemplate\": {'+
        '          \"subject\": \"Service Outage Notification\",'+
        '          \"formVariableItems\": ['+
        '            {'+
        '              \"val\": ['+
        '                \"{date}\"'+
        '              ],'+
        '              \"variableName\": \"Today\'s Date\",'+
        '              \"isRequired\": false,'+
        '              \"seq\": 1,'+
        '              \"variableId\": 10004'+
        '            },'+
        '            {'+
        '              \"val\": ['+
        '                \"{time}\"'+
        '              ],'+
        '              \"variableName\": \"Current Time\",'+
        '              \"isRequired\": false,'+
        '              \"seq\": 2,'+
        '              \"variableId\": 10003'+
        '            },'+
        '            {'+
        '              \"variableName\": \"External Service\",'+
        '              \"isRequired\": true,'+
        '              \"seq\": 3,'+
        '              \"variableId\": 1323816294812964'+
        '            },'+
        '            {'+
        '              \"variableName\": \"Description\",'+
        '              \"isRequired\": true,'+
        '              \"seq\": 4,'+
        '              \"variableId\": 444206992589703'+
        '            },'+
        '            {'+
        '              \"variableName\": \"Next Update\",'+
        '              \"isRequired\": true,'+
        '              \"seq\": 5,'+
        '              \"variableId\": 1323816294812958'+
        '            }'+
        '          ]'+
        '        },'+
        '        \"broadcastTemplate\": {'+
        '          \"accountId\": 0,'+
        '          \"broadcastContacts\": {'+
        '            \"filterIds\": ['+
        '              1323854949518779'+
        '            ],'+
        '            \"contactSearchType\": \"AllOr\"'+
        '          },'+
        '          \"resourceBundleId\": 0,'+
        '          \"organizationId\": 0,'+
        '          \"type\": \"Standard\",'+
        '          \"id\": 0,'+
        '          \"message\": {'+
        '            \"accountId\": 0,'+
        '            \"organizationId\": 0,'+
        '            \"contentType\": \"Text\",'+
        '            \"id\": 0,'+
        '            \"title\": \"Service Outage Notification\",'+
        '            \"conferenceBridgeId\": 0,'+
        '            \"resourceBundleId\": 0,'+
        '            \"lastModifiedId\": 0,'+
        '            \"createdId\": 0,'+
        '            \"rtfContent\": \"<meta id=\\\"meta\\\" name=\\\"viewport\\\" content=\\\"width=device-width; initial-scale=1.0\\\"><hr id=\\\"null\\\"><div style=\\\"text-align: center;\\\"><span style=\\\"font-size: x-large;\\\"><span style=\\\"font-weight: bold; color: rgb(153, 0, 0);\\\">Service Outage Affecting:&nbsp;</span><span style=\\\"color: rgb(153, 0, 0); font-weight: bold;\\\">{External Service}</span></span></div><hr id=\\\"null\\\"><div><br></div><div><table border=\\\"1\\\" cellpadding=\\\"2\\\" cellspacing=\\\"2\\\"><tbody><tr><td><span style=\\\"font-weight: bold;\\\">Item&nbsp;</span></td><td>&nbsp;<span style=\\\"font-weight: bold;\\\">Details</span></td></tr><tr><td>Date:</td><td>&nbsp;{Today\'s Date}</td></tr><tr><td><span style=\\\"font-weight: bold; color: rgb(153, 0, 0);\\\">Service:</span></td><td><span style=\\\"font-weight: bold; color: rgb(153, 0, 0);\\\">&nbsp;</span>{External Service}</td></tr><tr><td><span style=\\\"font-weight: bold; color: rgb(153, 0, 0);\\\">Issue:</span></td><td><span style=\\\"color: rgb(153, 0, 0);\\\">&nbsp;{Description}</span></td></tr><tr><td>Next Update:</td><td>&nbsp;{Next Update}</td></tr></tbody></table><br><br>If you have any questions please contact the Service Desk at 1-888-555-1212.</div>\"'+
        '          },'+
        '          \"broadcastSettings\": {'+
        '            \"voiceMailOption\": \"MESSAGE_ONLY\",'+
        '            \"throttlDefaultAmount\": 0,'+
        '            \"throttle\": false,'+
        '            \"mobileSettings\": {'+
        '              \"requestComment\": true,'+
        '              \"requestImage\": true,'+
        '              \"requestLocation\": true,'+
        '              \"allowShare\": false,'+
        '              \"requireConfirm\": false,'+
        '              \"pushAlertEnabled\": false'+
        '            },'+
        '            \"deliverPaths\": ['+
        '              {'+
        '                \"accountId\": 0,'+
        '                \"pathId\": 241901148045325,'+
        '                \"organizationId\": 0,'+
        '                \"awarePathId\": 0,'+
        '                \"id\": 444206992591362,'+
        '                \"expose\": false,'+
        '                \"isDefault\": false,'+
        '                \"mandatory\": false,'+
        '                \"resourceBundleId\": 0,'+
        '                \"editable\": false,'+
        '                \"seq\": 0,'+
        '                \"lastModifiedId\": 0,'+
        '                \"createdId\": 0,'+
        '                \"extRequired\": false,'+
        '                \"displayFlag\": false,'+
        '                \"default\": false'+
        '              },'+
        '              {'+
        '                \"accountId\": 0,'+
        '                \"pathId\": 241901148045316,'+
        '                \"organizationId\": 0,'+
        '                \"awarePathId\": 0,'+
        '                \"id\": 444206992591357,'+
        '                \"expose\": false,'+
        '                \"isDefault\": false,'+
        '                \"mandatory\": false,'+
        '                \"resourceBundleId\": 0,'+
        '                \"editable\": false,'+
        '                \"seq\": 0,'+
        '                \"lastModifiedId\": 0,'+
        '                \"createdId\": 0,'+
        '                \"extRequired\": false,'+
        '                \"displayFlag\": false,'+
        '                \"default\": false'+
        '              },'+
        '              {'+
        '                \"accountId\": 0,'+
        '                \"pathId\": 241901148045324,'+
        '                \"organizationId\": 0,'+
        '                \"awarePathId\": 0,'+
        '                \"id\": 444206992591361,'+
        '                \"expose\": false,'+
        '                \"isDefault\": false,'+
        '                \"mandatory\": false,'+
        '                \"resourceBundleId\": 0,'+
        '                \"editable\": false,'+
        '                \"seq\": 0,'+
        '                \"lastModifiedId\": 0,'+
        '                \"createdId\": 0,'+
        '                \"extRequired\": false,'+
        '                \"displayFlag\": false,'+
        '                \"default\": false'+
        '              },'+
        '              {'+
        '                \"accountId\": 0,'+
        '                \"pathId\": 241901148045319,'+
        '                \"organizationId\": 0,'+
        '                \"awarePathId\": 0,'+
        '                \"id\": 444206992591360,'+
        '                \"expose\": false,'+
        '                \"isDefault\": false,'+
        '                \"mandatory\": false,'+
        '                \"resourceBundleId\": 0,'+
        '                \"editable\": false,'+
        '                \"seq\": 0,'+
        '                \"lastModifiedId\": 0,'+
        '                \"createdId\": 0,'+
        '                \"extRequired\": false,'+
        '                \"displayFlag\": false,'+
        '                \"default\": false'+
        '              }'+
        '            ],'+
        '            \"requirePinForMessage\": false,'+
        '            \"deliveryMethodInterval\": 1,'+
        '            \"bookConference\": false,'+
        '            \"cycleInterval\": 1,'+
        '            \"duration\": 1,'+
        '            \"senderCallerInfos\": ['+
        '              {'+
        '                \"countryName\": \"United States\",'+
        '                \"accountId\": 0,'+
        '                \"countryCode\": \"US\",'+
        '                \"resourceBundleId\": 0,'+
        '                \"organizationId\": 0,'+
        '                \"id\": 0,'+
        '                \"callerId\": \"8182309700\",'+
        '                \"isDefault\": true,'+
        '                \"createdId\": 0,'+
        '                \"lastModifiedId\": 0'+
        '              }'+
        '            ],'+
        '            \"contactCycles\": 1,'+
        '            \"language\": \"en_US\",'+
        '            \"recipientApp\": true,'+
        '            \"senderEmail\": \"remedyforce_alerts@everbridge.com\",'+
        '            \"confirm\": true,'+
        '            \"deliveryPathOrder\": \"Organization\"'+
        '          },'+
        '          \"priority\": \"NonPriority\",'+
        '          \"lastModifiedId\": 0,'+
        '          \"createdId\": 0'+
        '        },'+
        '        \"ignoreVariable\": false,'+
        '        \"evaluateAll\": false'+
        '      },'+
        '      {'+
        '        \"templateId\": 0,'+
        '        \"name\": \"Update\",'+
        '        \"messageFlag\": 3,'+
        '        \"contactsFlag\": 3,'+
        '        \"settingsFlag\": 3,'+
        '        \"phaseDefinitions\": ['+
        '          {'+
        '            \"id\": 1002,'+
        '            \"status\": \"A\",'+
        '            \"isDefault\": false,'+
        '            \"name\": \"Updated\",'+
        '            \"seq\": 0'+
        '          }'+
        '        ],'+
        '        \"formTemplate\": {'+
        '          \"subject\": \"Service Outage Update\",'+
        '          \"preMessage\": \"At this time the {External Service} outage continues to impact our customer base.   Additional information will be sent out in {Next Update}.\",'+
        '          \"formVariableItems\": ['+
        '            {'+
        '              \"val\": ['+
        '                \"{date}\"'+
        '              ],'+
        '              \"variableName\": \"Today\'s Date\",'+
        '              \"isRequired\": false,'+
        '              \"seq\": 1,'+
        '              \"variableId\": 10004'+
        '            },'+
        '            {'+
        '              \"val\": ['+
        '                \"{time}\"'+
        '              ],'+
        '              \"variableName\": \"Current Time\",'+
        '              \"isRequired\": false,'+
        '              \"seq\": 2,'+
        '              \"variableId\": 10003'+
        '            },'+
        '            {'+
        '              \"variableName\": \"External Service\",'+
        '              \"isRequired\": true,'+
        '              \"seq\": 3,'+
        '              \"variableId\": 1323816294812964'+
        '            },'+
        '            {'+
        '              \"variableName\": \"Description\",'+
        '              \"isRequired\": true,'+
        '              \"seq\": 4,'+
        '              \"variableId\": 444206992589703'+
        '            },'+
        '            {'+
        '              \"variableName\": \"Next Update\",'+
        '              \"isRequired\": true,'+
        '              \"seq\": 5,'+
        '              \"variableId\": 1323816294812958'+
        '            },'+
        '            {'+
        '              \"variableName\": \"Update\",'+
        '              \"isRequired\": true,'+
        '              \"seq\": 6,'+
        '              \"variableId\": 444206992589707'+
        '            }'+
        '          ]'+
        '        },'+
        '        \"broadcastTemplate\": {'+
        '          \"accountId\": 0,'+
        '          \"broadcastContacts\": {'+
        '            \"filterIds\": ['+
        '              1323854949518779'+
        '            ],'+
        '            \"contactSearchType\": \"AllOr\"'+
        '          },'+
        '          \"resourceBundleId\": 0,'+
        '          \"organizationId\": 0,'+
        '          \"type\": \"Standard\",'+
        '          \"id\": 0,'+
        '          \"message\": {'+
        '            \"accountId\": 0,'+
        '            \"organizationId\": 0,'+
        '            \"contentType\": \"Text\",'+
        '            \"id\": 0,'+
        '            \"title\": \"Service Outage Update\",'+
        '            \"conferenceBridgeId\": 0,'+
        '            \"resourceBundleId\": 0,'+
        '            \"lastModifiedId\": 0,'+
        '            \"createdId\": 0,'+
        '            \"rtfContent\": \"<meta id=\\\"meta\\\" name=\\\"viewport\\\" content=\\\"width=device-width; initial-scale=1.0\\\"><hr id=\\\"null\\\"><div style=\\\"text-align: center;\\\"><span style=\\\"font-size: x-large;\\\"><span style=\\\"font-weight: bold; color: rgb(153, 0, 0);\\\">Service Outage Update:&nbsp;</span><span style=\\\"color: rgb(153, 0, 0); font-weight: bold;\\\">{External Service}</span></span></div><div style=\\\"text-align: center;\\\"><span style=\\\"font-size: x-large;\\\"><span style=\\\"color: rgb(153, 0, 0); font-weight: bold;\\\"><br></span></span></div><div style=\\\"text-align: left;\\\"><span style=\\\"font-size: large; color: rgb(0, 0, 153);\\\"><span style=\\\"font-weight: bold;\\\">Update:&nbsp;</span>{Update}</span></div><hr id=\\\"null\\\"><div><br></div><div><table border=\\\"1\\\" cellpadding=\\\"2\\\" cellspacing=\\\"2\\\"><tbody><tr><td><span style=\\\"font-weight: bold;\\\">Item&nbsp;</span></td><td>&nbsp;<span style=\\\"font-weight: bold;\\\">Details</span></td></tr><tr><td><span style=\\\"font-weight: bold;\\\">Date:</span></td><td>&nbsp;{Today\'s Date}</td></tr><tr><td><span style=\\\"font-weight: bold;\\\">Service:</span></td><td><span style=\\\"font-weight: bold;\\\">&nbsp;</span>{External Service}</td></tr><tr><td><span style=\\\"font-weight: bold;\\\">Issue:</span></td><td>&nbsp;{Description}</td></tr><tr><td><span style=\\\"font-weight: bold;\\\">Next Update:</span></td><td>&nbsp;{Next Update}</td></tr></tbody></table><br><br>If you have any questions please contact the Service Desk at 1-888-555-1212.</div>\"'+
        '          },'+
        '          \"broadcastSettings\": {'+
        '            \"voiceMailOption\": \"MESSAGE_ONLY\",'+
        '            \"throttlDefaultAmount\": 0,'+
        '            \"throttle\": false,'+
        '            \"mobileSettings\": {'+
        '              \"requestComment\": true,'+
        '              \"requestImage\": true,'+
        '              \"requestLocation\": true,'+
        '              \"allowShare\": false,'+
        '              \"requireConfirm\": false,'+
        '              \"pushAlertEnabled\": false'+
        '            },'+
        '            \"deliverPaths\": ['+
        '              {'+
        '                \"accountId\": 0,'+
        '                \"pathId\": 241901148045325,'+
        '                \"organizationId\": 0,'+
        '                \"awarePathId\": 0,'+
        '                \"id\": 444206992591362,'+
        '                \"expose\": false,'+
        '                \"isDefault\": false,'+
        '                \"mandatory\": false,'+
        '                \"resourceBundleId\": 0,'+
        '                \"editable\": false,'+
        '                \"seq\": 0,'+
        '                \"lastModifiedId\": 0,'+
        '                \"createdId\": 0,'+
        '                \"extRequired\": false,'+
        '                \"displayFlag\": false,'+
        '                \"default\": false'+
        '              },'+
        '              {'+
        '                \"accountId\": 0,'+
        '                \"pathId\": 241901148045316,'+
        '                \"organizationId\": 0,'+
        '                \"awarePathId\": 0,'+
        '                \"id\": 444206992591357,'+
        '                \"expose\": false,'+
        '                \"isDefault\": false,'+
        '                \"mandatory\": false,'+
        '                \"resourceBundleId\": 0,'+
        '                \"editable\": false,'+
        '                \"seq\": 0,'+
        '                \"lastModifiedId\": 0,'+
        '                \"createdId\": 0,'+
        '                \"extRequired\": false,'+
        '                \"displayFlag\": false,'+
        '                \"default\": false'+
        '              },'+
        '              {'+
        '                \"accountId\": 0,'+
        '                \"pathId\": 241901148045324,'+
        '                \"organizationId\": 0,'+
        '                \"awarePathId\": 0,'+
        '                \"id\": 444206992591361,'+
        '                \"expose\": false,'+
        '                \"isDefault\": false,'+
        '                \"mandatory\": false,'+
        '                \"resourceBundleId\": 0,'+
        '                \"editable\": false,'+
        '                \"seq\": 0,'+
        '                \"lastModifiedId\": 0,'+
        '                \"createdId\": 0,'+
        '                \"extRequired\": false,'+
        '                \"displayFlag\": false,'+
        '                \"default\": false'+
        '              },'+
        '              {'+
        '                \"accountId\": 0,'+
        '                \"pathId\": 241901148045319,'+
        '                \"organizationId\": 0,'+
        '                \"awarePathId\": 0,'+
        '                \"id\": 444206992591360,'+
        '                \"expose\": false,'+
        '                \"isDefault\": false,'+
        '                \"mandatory\": false,'+
        '                \"resourceBundleId\": 0,'+
        '                \"editable\": false,'+
        '                \"seq\": 0,'+
        '                \"lastModifiedId\": 0,'+
        '                \"createdId\": 0,'+
        '                \"extRequired\": false,'+
        '                \"displayFlag\": false,'+
        '                \"default\": false'+
        '              }'+
        '            ],'+
        '            \"requirePinForMessage\": false,'+
        '            \"deliveryMethodInterval\": 1,'+
        '            \"bookConference\": false,'+
        '            \"cycleInterval\": 1,'+
        '            \"duration\": 1,'+
        '            \"senderCallerInfos\": ['+
        '              {'+
        '                \"countryName\": \"United States\",'+
        '                \"accountId\": 0,'+
        '                \"countryCode\": \"US\",'+
        '                \"resourceBundleId\": 0,'+
        '                \"organizationId\": 0,'+
        '                \"id\": 0,'+
        '                \"callerId\": \"8182309700\",'+
        '                \"isDefault\": true,'+
        '                \"createdId\": 0,'+
        '                \"lastModifiedId\": 0'+
        '              }'+
        '            ],'+
        '            \"contactCycles\": 1,'+
        '            \"language\": \"en_US\",'+
        '            \"recipientApp\": true,'+
        '            \"senderEmail\": \"remedyforce_alerts@everbridge.com\",'+
        '            \"confirm\": true,'+
        '            \"deliveryPathOrder\": \"Organization\"'+
        '          },'+
        '          \"priority\": \"NonPriority\",'+
        '          \"lastModifiedId\": 0,'+
        '          \"createdId\": 0'+
        '        },'+
        '        \"ignoreVariable\": true,'+
        '        \"evaluateAll\": false'+
        '      },'+
        '      {'+
        '        \"templateId\": 0,'+
        '        \"name\": \"Resolved\",'+
        '        \"messageFlag\": 3,'+
        '        \"contactsFlag\": 3,'+
        '        \"settingsFlag\": 3,'+
        '        \"phaseDefinitions\": ['+
        '          {'+
        '            \"id\": 1003,'+
        '            \"status\": \"A\",'+
        '            \"isDefault\": false,'+
        '            \"name\": \"Closed\",'+
        '            \"seq\": 0'+
        '          }'+
        '        ],'+
        '        \"formTemplate\": {'+
        '          \"subject\": \"Service Outage Resolved\",'+
        '          \"preMessage\": \"As of {Today\'s Date} at {Current Time} the {External Service} outage is resolved.  Thank you for your patience.\",'+
        '          \"formVariableItems\": ['+
        '            {'+
        '              \"val\": ['+
        '                \"{date}\"'+
        '              ],'+
        '              \"variableName\": \"Today\'s Date\",'+
        '              \"isRequired\": false,'+
        '              \"seq\": 1,'+
        '              \"variableId\": 10004'+
        '            },'+
        '            {'+
        '              \"val\": ['+
        '                \"{time}\"'+
        '              ],'+
        '              \"variableName\": \"Current Time\",'+
        '              \"isRequired\": false,'+
        '              \"seq\": 2,'+
        '              \"variableId\": 10003'+
        '            },'+
        '            {'+
        '              \"variableName\": \"External Service\",'+
        '              \"isRequired\": true,'+
        '              \"seq\": 3,'+
        '              \"variableId\": 1323816294812964'+
        '            },'+
        '            {'+
        '              \"variableName\": \"Description\",'+
        '              \"isRequired\": true,'+
        '              \"seq\": 4,'+
        '              \"variableId\": 444206992589703'+
        '            },'+
        '            {'+
        '              \"variableName\": \"Resolution\",'+
        '              \"isRequired\": true,'+
        '              \"seq\": 5,'+
        '              \"variableId\": 444206992589706'+
        '            }'+
        '          ]'+
        '        },'+
        '        \"broadcastTemplate\": {'+
        '          \"accountId\": 0,'+
        '          \"broadcastContacts\": {'+
        '            \"filterIds\": ['+
        '              1323854949518779'+
        '            ],'+
        '            \"contactSearchType\": \"AllOr\"'+
        '          },'+
        '          \"resourceBundleId\": 0,'+
        '          \"organizationId\": 0,'+
        '          \"type\": \"Standard\",'+
        '          \"id\": 0,'+
        '          \"message\": {'+
        '            \"accountId\": 0,'+
        '            \"organizationId\": 0,'+
        '            \"contentType\": \"Text\",'+
        '            \"id\": 0,'+
        '            \"title\": \"Service Outage Resolved\",'+
        '            \"conferenceBridgeId\": 0,'+
        '            \"resourceBundleId\": 0,'+
        '            \"lastModifiedId\": 0,'+
        '            \"createdId\": 0,'+
        '            \"rtfContent\": \"<meta id=\\\"meta\\\" name=\\\"viewport\\\" content=\\\"width=device-width; initial-scale=1.0\\\"><hr id=\\\"null\\\"><div style=\\\"text-align: center;\\\"><span style=\\\"font-size: x-large;\\\"><span style=\\\"font-weight: bold; color: rgb(0, 153, 0);\\\">Service Outage </span><span style=\\\"font-weight: bold; color: rgb(0, 153, 0);\\\">Resolved</span><span style=\\\"color: rgb(0, 153, 0);\\\"><span style=\\\"font-weight: bold;\\\">:&nbsp;</span><span style=\\\"font-weight: bold;\\\">{External Service}</span></span></span></div><hr id=\\\"null\\\"><div><br></div><div><table border=\\\"1\\\" cellpadding=\\\"2\\\" cellspacing=\\\"2\\\"><tbody><tr><td><span style=\\\"font-weight: bold;\\\">Item&nbsp;</span></td><td>&nbsp;<span style=\\\"font-weight: bold;\\\">Details</span></td></tr><tr><td>Date:</td><td>&nbsp;{Today\'s Date}</td></tr><tr><td>Service:</td><td>&nbsp;{External Service}</td></tr><tr><td>Issue:</td><td>&nbsp;{Description}</td></tr><tr><td><span style=\\\"color: rgb(0, 153, 0); font-weight: bold;\\\">Resolution:</span></td><td><span style=\\\"color: rgb(0, 153, 0); font-weight: bold;\\\">&nbsp;{Resolution}</span></td></tr></tbody></table><br><br>If you have any questions please contact the Service Desk at 1-888-555-1212.</div>\"'+
        '          },'+
        '          \"broadcastSettings\": {'+
        '            \"voiceMailOption\": \"MESSAGE_ONLY\",'+
        '            \"throttlDefaultAmount\": 0,'+
        '            \"throttle\": false,'+
        '            \"mobileSettings\": {'+
        '              \"requestComment\": true,'+
        '              \"requestImage\": true,'+
        '              \"requestLocation\": true,'+
        '              \"allowShare\": false,'+
        '              \"requireConfirm\": false,'+
        '              \"pushAlertEnabled\": false'+
        '            },'+
        '            \"deliverPaths\": ['+
        '              {'+
        '                \"accountId\": 0,'+
        '                \"pathId\": 241901148045325,'+
        '                \"organizationId\": 0,'+
        '                \"awarePathId\": 0,'+
        '                \"id\": 444206992591362,'+
        '                \"expose\": false,'+
        '                \"isDefault\": false,'+
        '                \"mandatory\": false,'+
        '                \"resourceBundleId\": 0,'+
        '                \"editable\": false,'+
        '                \"seq\": 0,'+
        '                \"lastModifiedId\": 0,'+
        '                \"createdId\": 0,'+
        '                \"extRequired\": false,'+
        '                \"displayFlag\": false,'+
        '                \"default\": false'+
        '              },'+
        '              {'+
        '                \"accountId\": 0,'+
        '                \"pathId\": 241901148045316,'+
        '                \"organizationId\": 0,'+
        '                \"awarePathId\": 0,'+
        '                \"id\": 444206992591357,'+
        '                \"expose\": false,'+
        '                \"isDefault\": false,'+
        '                \"mandatory\": false,'+
        '                \"resourceBundleId\": 0,'+
        '                \"editable\": false,'+
        '                \"seq\": 0,'+
        '                \"lastModifiedId\": 0,'+
        '                \"createdId\": 0,'+
        '                \"extRequired\": false,'+
        '                \"displayFlag\": false,'+
        '                \"default\": false'+
        '              },'+
        '              {'+
        '                \"accountId\": 0,'+
        '                \"pathId\": 241901148045324,'+
        '                \"organizationId\": 0,'+
        '                \"awarePathId\": 0,'+
        '                \"id\": 444206992591361,'+
        '                \"expose\": false,'+
        '                \"isDefault\": false,'+
        '                \"mandatory\": false,'+
        '                \"resourceBundleId\": 0,'+
        '                \"editable\": false,'+
        '                \"seq\": 0,'+
        '                \"lastModifiedId\": 0,'+
        '                \"createdId\": 0,'+
        '                \"extRequired\": false,'+
        '                \"displayFlag\": false,'+
        '                \"default\": false'+
        '              },'+
        '              {'+
        '                \"accountId\": 0,'+
        '                \"pathId\": 241901148045319,'+
        '                \"organizationId\": 0,'+
        '                \"awarePathId\": 0,'+
        '                \"id\": 444206992591360,'+
        '                \"expose\": false,'+
        '                \"isDefault\": false,'+
        '                \"mandatory\": false,'+
        '                \"resourceBundleId\": 0,'+
        '                \"editable\": false,'+
        '                \"seq\": 0,'+
        '                \"lastModifiedId\": 0,'+
        '                \"createdId\": 0,'+
        '                \"extRequired\": false,'+
        '                \"displayFlag\": false,'+
        '                \"default\": false'+
        '              }'+
        '            ],'+
        '            \"requirePinForMessage\": false,'+
        '            \"deliveryMethodInterval\": 1,'+
        '            \"bookConference\": false,'+
        '            \"cycleInterval\": 1,'+
        '            \"duration\": 1,'+
        '            \"senderCallerInfos\": ['+
        '              {'+
        '                \"countryName\": \"United States\",'+
        '                \"accountId\": 0,'+
        '                \"countryCode\": \"US\",'+
        '                \"resourceBundleId\": 0,'+
        '                \"organizationId\": 0,'+
        '                \"id\": 0,'+
        '                \"callerId\": \"8182309700\",'+
        '                \"isDefault\": true,'+
        '                \"createdId\": 0,'+
        '                \"lastModifiedId\": 0'+
        '              }'+
        '            ],'+
        '            \"contactCycles\": 1,'+
        '            \"language\": \"en_US\",'+
        '            \"recipientApp\": true,'+
        '            \"senderEmail\": \"remedyforce_alerts@everbridge.com\",'+
        '            \"confirm\": false,'+
        '            \"deliveryPathOrder\": \"Organization\"'+
        '          },'+
        '          \"priority\": \"NonPriority\",'+
        '          \"lastModifiedId\": 0,'+
        '          \"createdId\": 0'+
        '        },'+
        '        \"ignoreVariable\": true,'+
        '        \"evaluateAll\": false'+
        '      }'+
        '    ],'+
        '    \"accountId\": 892807736722576,'+
        '    \"status\": \"A\",'+
        '    \"createdId\": 3083034899266633,'+
        '    \"createdName\": \"Lisa Radley_ITADemo\",'+
        '    \"lastModifiedId\": 3083034899266633,'+
        '    \"lastModifiedName\": \"Lisa Radley_ITADemo\",'+
        '    \"createdDate\": 1444919498023,'+
        '    \"lastModifiedDate\": 1444920262778,'+
        '    \"organizationId\": 453003085612786,'+
        '    \"resourceBundleId\": 453003085613479,'+
        '    \"category\": {'+
        '      \"id\": 1323816294810222,'+
        '      \"name\": \"Outage\"'+
        '    }'+
        '  }'+
        '}';
        BMCRF_Parser_phaseTemplate r = BMCRF_Parser_phaseTemplate.parse(json);
        System.assert(r != null);

        
    }
}