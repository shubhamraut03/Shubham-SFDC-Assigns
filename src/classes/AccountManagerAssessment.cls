public with sharing class AccountManagerAssessment {
    
    @AuraEnabled(cacheable=true)
    public static List<Account> getAccounts() {
        return [SELECT Name, Type, Industry, Phone FROM Account];
    }
    
    @AuraEnabled
    public static String createAccount(Account objAccount){
        
        system.debug('objAccount: ' + objAccount);
        try {
            
                insert objAccount;
                Id accountId = objAccount.Id;
                return accountId;
           
        } catch (Exception e) {
            return 'Error creating account: ' + e.getMessage();
        }
    }
}