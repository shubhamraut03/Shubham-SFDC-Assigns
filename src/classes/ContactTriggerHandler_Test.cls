/**
* Description : It Contains ContactTriggerHandler Test Methods for Coverage             
*
* Created By : Shubham Raut
*
* Created Date : 4/12/24
*
* Revision Logs : V1.0 - Created - Shubham Raut
*
* Coverage : 88%
**/
@isTest
private class ContactTriggerHandler_Test {
    
    //Setup method to create Account
    @testSetup
    private static void setupAccountRec(){
        
        List<Account> listOfAccount = TestDataFactory.createAccountRec('Test Account', 1, false);
        listOfAccount[0].Domain__c = '@gmail.com';
        
        insert listOfAccount;
    }
    
    //Generic method to create Contact
    @isTest(seeAllData = false)
    private static List<Contact> createContactTest(){
        
        Account objAccount = [SELECT Id FROM Account];
        
        List<Contact> listOfContact = TestDataFactory.createContactRec('Test Contact', 1, false);
        
        listOfContact[0].AccountId = objAccount.Id;
        
        return listOfContact;
    }
    
    //=====================================Insert====================================================
    @isTest
    private static void checkWrongEmailDomainOfConWithRelAccWhenInsertTest(){
        
        //Arrange
        List<Contact> listOfContact = createContactTest();
        listOfContact[0].Email = 'test@gail.com';
        
        
        //Act
        Test.startTest();
        try{
            insert listOfContact;
        }
        //Assert
        catch(Exception e){
            Assert.areEqual(true , e.getMessage().contains('Email does not contain Account Domain!') ,'Could not fetched Error');
        }        
        Test.stopTest();        
        
    }
    
    @isTest
    private static void checkEmailDomainOfConWithRelAccWhenInsertTest(){
        
        //Arrange
        List<Contact> listOfContact = createContactTest();
        listOfContact[0].Email = 'test@gmail.com';
        
        //Act
        Test.startTest();
        try{
            insert listOfContact;
        }
        //Assert
        catch(Exception e){
            Assert.areEqual(false , e.getMessage().contains('Email does not contain Account Domain!') ,'Could not fetched Error');
        }        
        Test.stopTest();        
        
    }
    
    //=====================================Update====================================================
    @isTest
    private static void checkWrongEmailDomainOfConWithRelAccWhenUpdateTest(){
        
        //Arrange
        List<Contact> listOfContact = createContactTest();
        listOfContact[0].Email = 'test@gmail.com';
        
        insert listOfContact;
        
        Contact objContact = [SELECT Id, Email FROM Contact];
        objContact.Email = 'test@gail.com';
        
        //Act
        Test.startTest();
        try{
            update objContact;
        }        
        //Assert
        catch(Exception e){
            Assert.areEqual(true , e.getMessage().contains('Email does not contain Account Domain!') ,'Could not fetched Error');
        }        
        Test.stopTest();        
        
    }
    
    @isTest
    private static void checkEmailDomainOfConWithRelAccWhenUpdateTest(){
        
        //Arrange
        List<Contact> listOfContact = createContactTest();
        listOfContact[0].Email = 'test@gmail.com';
        
        insert listOfContact;
        
        Contact objContact = [SELECT Id, Email FROM Contact];
        objContact.Email = 'test@gmail.com';
        
        //Act
        Test.startTest();
        try{
            update objContact;
        }
        //Assert
        catch(Exception e){
            Assert.areEqual(false , e.getMessage().contains('Email does not contain Account Domain!') ,'Could not fetched Error');
        }        
        Test.stopTest();        
        
    }
}