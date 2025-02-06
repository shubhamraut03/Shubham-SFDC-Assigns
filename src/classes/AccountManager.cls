/*
 *
 *  Purpose          :	Account Manager Controller
 *
 *  Created Date     :  	31/1/2025
 *
 *  Created By       :  	Shubham Raut
 *
 *  Revision Logs    :  	V_1.0 - Created - Shubham Raut
 *
 */
public with sharing class AccountManager {
    
    /**
     *
     * @description : To get Account Records Imperatively.
     *
     * @args : None.
     *
     * @return : List<Account> - List of Account Records.
     *
     * @revision Log : V1.1 - Created - 31/1/2025 - Shubham Raut
     *
     **/
    @AuraEnabled
    public static List<Account> getAccountList() {
        
        try {
            List<Account> accountList = [SELECT Id, Name, Phone, Rating, Domain__c, Website FROM Account];
            return accountList;
        }
        catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
    
    
    /**
     *
     * @description : To get Account Records using Wire Service.
     *
     * @args :    None.
     *
     * @return :  List<Account> - List of Account Records.
     *
     * @revision Log : V1.1 - Created - 31/1/2025 - Shubham Raut
     *
     **/
    @AuraEnabled(cacheable=true)
    public static List<Account> getAccountListWire() {
        
        try{
            List<Account> accountList = [SELECT Id, Name, Phone, Rating, Domain__c, Website FROM Account];
            return accountList;
        }
        catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}