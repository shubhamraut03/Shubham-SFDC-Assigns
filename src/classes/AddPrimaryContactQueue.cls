/**
* Description :  This Queueable class is used to process the Account records. 
*                It will create Primary Contact record for the Account according to BillingState.                           
*
* Created By : Shubham Raut
*
* Created Date : 20/12/24
*
* Revision Logs : V1.0 - Created - Shubham Raut
*
**/
public class AddPrimaryContactQueue implements Queueable {
    
    private Contact objContact;
    private String stateToQuery;
    
    public AddPrimaryContactQueue(Contact objCon , String state){
        
        objContact = objCon;
        stateToQuery = state;
    }
    
    public void execute(QueueableContext context){
        
        List<Account> listOfAccount = [SELECT Id, BillingState FROM Account WHERE BillingState = : stateToQuery];
        
        List<Contact> listOfCon = new List<Contact>();
        
        if(!listOfAccount.isEmpty()){
            for(Account objAcc : listOfAccount){
                
                objContact.AccountId = objAcc.Id;
                Contact cloneCon = objContact.clone(false, false, false, false);
                listOfCon.add(cloneCon);
            }
        }
        
        if(!listOfCon.isEmpty())
            Database.insert(listOfCon, false);
    } 
}