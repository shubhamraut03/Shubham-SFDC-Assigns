/**
* Description : It Contains Account Object Test Methods for Coverage.
*
* Created By : Shubham Raut
*
* Created Date : 13/12/24
*
* Revision Logs : V1.0 - Created - Shubham Raut
*
**/
@isTest
private class AccountProcessorAsyncTest {
    
    @testSetup
    private static void createAccountContact(){
        
        List<Account> listOfAccount = TestDataFactory.createAccountRec('Test Acc', 3, true);
        
        List<Contact> listOfContactToInsert = new List<Contact>();
        
        for(Account objAcc : listOfAccount){
            
            List<Contact> listOfContact = TestDataFactory.createContactRec('Test Con', 3, false);
            
            for(Contact objCon : listOfContact){
                objCon.AccountId = objAcc.Id;
                listOfContactToInsert.add(objCon);
            }
        }
        
        insert listOfContactToInsert;
    }
    
    
    @isTest
    private static void countContactsTest(){
        
        List<Id> listOfAccountId = new List<Id>();
        
        for(Account objAcc : [SELECT Id FROM Account]){
            
            listOfAccountId.add(objAcc.Id);
        }
        
        Test.startTest();
        AccountProcessorAsync.countContactsOnAcc(listOfAccountId);
        Test.stopTest();
        
        Account objAccount = [SELECT Id, Number_Of_Contacts__c From Account Limit 1];
        Assert.areEqual(3 , objAccount.Number_Of_Contacts__c , 'Error in getting Count');
    }
}