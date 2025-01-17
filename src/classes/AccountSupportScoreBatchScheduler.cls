public class AccountSupportScoreBatchScheduler Implements Schedulable{

    public void execute(SchedulableContext context){
        
        AccountSupportScoreBatch batch = new AccountSupportScoreBatch();
        Database.executeBatch(batch);
    }
}