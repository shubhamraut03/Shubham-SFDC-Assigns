/**
* Description : This Schedulable class will Schedule GenericSObjectBatch.
*
* Created By : Shubham Raut
*
* Created Date : 02/01/25
*
* Revision Logs : V1.0 - Created - Shubham Raut
*
**/
public class GenericSObjectBatchSchedule implements Schedulable{

     public void execute(SchedulableContext SC) {
        
        GenericSObjectBatch batch = new GenericSObjectBatch();
        Database.executeBatch(batch);
    }
}

//String cronExp = '0 0 0 1 * ? *'; // Runs at midnight on the first day of every month
//GenericSObjectBatchSchedule scheduleJob = new GenericSObjectBatchSchedule();
//System.schedule('Monthly Archive Data Job', cronExp, scheduleJob);