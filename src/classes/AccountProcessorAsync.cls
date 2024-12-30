/**
* Description : This class is used to process the Account records.              
*
* Created By : Shubham Raut
*
* Created Date : 13/12/24
*
* Revision Logs : V1.0 - Created - Shubham Raut
*
**/
public without sharing class AccountProcessorAsync {
    
    /**
*
* @description : This method is used to count the number of contacts associated with the Account.
*
* @args : listOfAccountId 
*
* @return : void
*
* @revision Log : V1.1 - Created - 13/12/24 - Shubham Raut
*
**/
    @future
    public static void countContactsOnAcc(List<Id> listOfAccountId){
        
        Set<Id> setOfAccountId = new Set<Id>(listOfAccountId);
        
        List<Account> listOfAccount = new List<Account>();
        
        if(!setOfAccountId.isEmpty()){
            for(Account objAcc : [SELECT Id, Number_Of_Contacts__c, (SELECT Id FROM Contacts) 
                                  FROM Account WHERE Id IN :setOfAccountId]){
                                      
                                      objAcc.Number_Of_Contacts__c = objAcc.Contacts.size();
                                      listOfAccount.add(objAcc);
                                  }
        }
        
            if(!listOfAccount.isEmpty())
                Database.update(listOfAccount, false);
    }
}