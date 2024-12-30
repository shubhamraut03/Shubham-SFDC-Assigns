/**
* Description : It Contains AddPrimaryContact Class Test Methods for Coverage
*
* Created By : Shubham Raut
*
* Created Date : 20/12/24
*
* Revision Logs : V1.0 - Created - Shubham Raut
*
**/
@isTest
private class AddPrimaryContactQueueTest {

    @testSetup
    private static void setupAccount(){
         
        List<Account> listOfAccount = TestDataFactory.createAccountRec('Test Account', 100, false);

        Integer i = 0;
        
        for(Account objAcc : listOfAccount){

            if(Math.mod(i,2) == 0){
              objAcc.BillingState = 'NY'; 
            }
            else{
               objAcc.BillingState = 'CA';
            }
            i++;
        }
        
        insert listOfAccount;
    }
    
    @isTest
    private static void insertContactForAccount(){
        
        Test.startTest();
        AddPrimaryContactQueue addContact = new AddPrimaryContactQueue(new Contact(LastName= 'TestCon') , 'CA');
        System.enqueueJob(addContact);
        Test.stopTest();
        
        List<Contact> listOfCreatedCon = [SELECT Id FROM Contact];
        
        Assert.areEqual(50, listOfCreatedCon.size(), 'Error in Creating Contact');
    }
}