/**
* Description : This Will Test GenericSObjectBatch.
*
* Created By : Shubham Raut
*
* Created Date : 06/01/25
*
* Revision Logs : V1.0 - Created - Shubham Raut
*
**/
@isTest
private class GenericSObjectBatch_Test {

    @isTest(seeAllData = true)
    private static void testBatchExecution() {
        
        Archive_Config__mdt archiveConfig = Archive_Config__mdt.getInstance('Account_Info');

        Test.startTest();
        GenericSObjectBatch batch = new GenericSObjectBatch();
        Database.executeBatch(batch);
        Test.stopTest();
        
        // Verify that the records were archived and deleted
        String query = 'SELECT Id FROM ' + archiveConfig.Object_API_Name__c + ' WHERE ' 
                        + archiveConfig.Filter__c + ' AND CreatedDate = ' + archiveConfig.Duration__c; 

        List<sObject> archivedSObject = Database.query(query);
        
        //Assert
        System.assertEquals(0, archivedSObject.size());
                    
        // Assert that the email was sent
        System.assertEquals(1, GenericSObjectBatch.emailInvocations, 'Emails should be sent');
    }
}