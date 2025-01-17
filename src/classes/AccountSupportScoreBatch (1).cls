public class AccountSupportScoreBatch Implements Database.Batchable<sObject>{
    
    public Database.QueryLocator start(Database.BatchableContext BC){
        
        //It will Retrieve Cases Which are Open
        return Database.getQueryLocator('SELECT Id, AccountId, CaseNumber, Priority, Status FROM Case WHERE Status != \'Closed\' AND AccountId != null');
    }
    
    public void execute(Database.BatchableContext BC, List<Case> listOfCase){
        
        if(listOfCase.isEmpty())
            return;
        
        // To Store AccountId Related to Cases
        Set<Id> setOfAccountId = new Set<Id>();
        
        // will store AccountIds
        for(Case objCase : listOfCase){
            
            setOfAccountId.add(objCase.AccountId);
        }
        
        // Will Contain Account Records Based upon AccountId
        Map<Id, Account> mapOfAccount = new Map<Id, Account>([SELECT Id, Support_Score__c FROM Account WHERE Id IN : setOfAccountId]);
        
        //It will iterate on Cases & Calculate Support Score For related Account
        if(mapOfAccount != null){
            for(Case objCase : listOfCase){
                
                if(mapOfAccount.containsKey(objCase.AccountId)){
                    
                    mapOfAccount.get(objCase.AccountId).Support_Score__c += scoreCalculation(objCase);
                }
            }
            
            //Will Update Account with Support Score
            Database.SaveResult[] srList= Database.update(mapOfAccount.values(), false);
            
            for (Database.SaveResult sr : srList) {
                if (sr.isSuccess()) {
                    // Operation was successful, so get the ID of the record that was processed
                    System.debug('Successfully inserted account. Account ID: ' + sr.getId());
                }
                else {
                    // Operation failed, so get all errors                
                    for(Database.Error err : sr.getErrors()) {
                        System.debug('The following error has occurred.');                    
                        System.debug(err.getStatusCode() + ': ' + err.getMessage());
                        System.debug('Account that affected this error: ' + err.getFields());
                    }
                }
            }
        }  
    }
    
    public void finish(Database.BatchableContext BC){
        
    }
    
    //Will Caluculate Support Score for Account And Return the Score
    public Integer scoreCalculation(Case objCase){
        
        Integer score;
        
        if(objCase.Priority == 'High'){
            
            score = 3;
            
            if(objCase.CreatedDate < System.now() &&  objCase.CreatedDate > System.now().addDays(-30)){
                score += 1;
            }
            if(objCase.CreatedDate < System.now().addDays(-60)){
                score += -1;
            }
        }
        else if(objCase.Priority == 'Medium'){
            score = 2;
            
            if(objCase.CreatedDate < System.now() &&  objCase.CreatedDate > System.now().addDays(-30)){
                score += 1;
            }
            if(objCase.CreatedDate < System.now().addDays(-60)){
                score += -1;
            }
        }
        else{
            score = 1;
            
            if(objCase.CreatedDate < System.now() &&  objCase.CreatedDate > System.now().addDays(-30)){
                score += 1;
            }
            if(objCase.CreatedDate < System.now().addDays(-60)){
                score += -1;
            }
        }
        
        return score;
    }
}