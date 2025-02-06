/**
* Description : This Will Test GenericSObjectBatchSchedule.
*
* Created By : Shubham Raut
*
* Created Date : 06/01/25
*
* Revision Logs : V1.0 - Created - Shubham Raut
*
**/
@isTest
private class GenericSObjectBatchSchedule_Test {
    
    @isTest(seeAllData = false)
    private static void schedulableExecution() {
        
        Test.startTest();
        String cronExp = '0 0 0 1 * ? *'; // Runs at midnight on the first day of every month
        GenericSObjectBatchSchedule scheduleJob = new GenericSObjectBatchSchedule();
        System.schedule('Monthly Archive Data Job', cronExp, scheduleJob);
        Test.stopTest();
    }
}