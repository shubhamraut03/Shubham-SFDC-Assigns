/**
* Description : It Contains Contact Triggers Test Methods for Coverage
*               (Contact is child of Account)
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
    private static void createAccountRec(){
        
        Account objAccount = new Account();
        objAccount.Name = 'Test Account';
        objAccount.Phone = '9685746352';
        objAccount.Domain__c = '@gmail.com';
        
        insert objAccount;
    }
    
    //Generic method to create Contact
    @isTest(seeAllData = false)
    private static Contact createContactTest(){
        
        Account objAccount = [SELECT Id FROM Account];
        
        Contact objCon1 = new Contact();
        objCon1.LastName = 'Test Contact 1';
        objCon1.AccountId = objAccount.Id;
        
        return objCon1;
    }
    
    //=====================================Insert====================================================
    @isTest
    private static void checkWrongEmailDomainOfConWithRelAccWhenInsertTest(){
        
        //Arrange
        Contact objCon = createContactTest();
        
        objCon.Email = 'test@gail.com';
        
        
        //Act
        Test.startTest();
        try{
            insert objCon;
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
        Contact objCon = createContactTest();
        
        objCon.Email = 'test@gmail.com';
        
        //Act
        Test.startTest();
        try{
            insert objCon;
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
        Contact objCon = createContactTest();
        
        objCon.Email = 'test@gmail.com';
        
        insert objCon;
        
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
        Contact objCon = createContactTest();
        
        objCon.Email = 'test@gmail.com';
        
        insert objCon;
        
        Contact objContact = [SELECT Id, Email FROM Contact];
        objContact.Email = 'test@gmail.com';
        
        //Act
        Test.startTest();
        try{
            update objCon;
        }
        //Assert
        catch(Exception e){
            Assert.areEqual(false , e.getMessage().contains('Email does not contain Account Domain!') ,'Could not fetched Error');
        }        
        Test.stopTest();        
        
    }
}