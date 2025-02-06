/**
* Description : It will Test populateObjectAndPicklistOnContact() Method From ContactTriggerHandler
*
* Created By : Shubham Raut
*
* Created Date : 02/01/25
*
* Revision Logs : V1.0 - Created - Shubham Raut
*
**/
@isTest
private class PopulatePicklistOnContact_Test {
    
    //========================================Insert==================================================
    @isTest(seeAllData = false)
    private static void populateObjectAndPicklistOnContact_Test() {
        
        //Arrange
        List<Account> listOfAcc = TestDataFactory.createAccountRec('Test Acc', 1, true);
        
        List<Contact> listOfCon = TestDataFactory.createContactRec('Test Con', 1, false);
        
        listOfCon[0].RecordID__c = listOfAcc[0].Id;
        
        //Act
        Test.startTest();
        insert listOfCon;
        Test.stopTest();
        
        //Assert
        Contact updatedContact = [SELECT Object_Name__c, Picklist_Fields__c FROM Contact LIMIT 1];
        System.assertNotEquals(null, updatedContact.Object_Name__c);
        System.assertNotEquals(null, updatedContact.Picklist_Fields__c);
    }
    
    @isTest(seeAllData = false)
    private static void populateObjectAndPicklistOnContactWrongId() {
        
        //Arrange
        List<Contact> listOfCon = TestDataFactory.createContactRec('Test Con', 1, false);
        
        listOfCon[0].RecordID__c = '461112fgujngvc1234';
        
        //Act
        try{
            Test.startTest();
            insert listOfCon;
            Test.stopTest();
        }
        catch(Exception e){
            //Assert
            System.assertEquals(true, e.getMessage().contains('Entered Record Id is Invalid!'));
        }
        
    }
    
    //======================================Update=========================================================
    
    @isTest(seeAllData = false)
    private static void populateObjectAndPicklistOnContactUpdate_Test() {
        
        //Arrange
        List<Account> listOfAcc = TestDataFactory.createAccountRec('Test Acc', 1, true);
        
        List<Contact> listOfCon = TestDataFactory.createContactRec('Test Con', 1, true);
        
        Contact objCon = [SELECT Id, LastName, RecordID__c FROM Contact LIMIT 1];
        objCon.RecordID__c = listOfAcc[0].Id;
        
        //Act
        Test.startTest();
        update objCon; 
        Test.stopTest();
        
        //Assert
        Contact updatedContact = [SELECT Object_Name__c, Picklist_Fields__c FROM Contact LIMIT 1];
        System.assertNotEquals(null, updatedContact.Object_Name__c);
        System.assertNotEquals(null, updatedContact.Picklist_Fields__c);
    }
    
    @isTest(seeAllData = false)
    private static void populateObjectAndPicklistOnContactUpdateWrongId() {
        
        //Arrange
        List<Contact> listOfCon = TestDataFactory.createContactRec('Test Con', 1, true);
        
        Contact objCon = [SELECT Id, LastName, RecordID__c FROM Contact LIMIT 1];
        objCon.RecordID__c = 'dhh123148asdfhc527';
        
        //Act
        try{
            Test.startTest();
            update objCon;
            Test.stopTest();
        }
        catch(Exception e){
            //Assert
            System.assertEquals(true, e.getMessage().contains('Entered Record Id is Invalid!'));
        }
    }
    
    
    //======================================Insert&Upsert=========================================================
    
    @isTest(seeAllData = false)
    private static void populateObjectAndNotPicklistOnContactUpsert_Test() {
        
        //Arrange
        List<Training_Session__c> listOfTS = TestDataFactory.createTrainingSessionRec('Test TS', 2, true);
        
        List<Contact> listOfCon = TestDataFactory.createContactRec('Test Con', 1, false);
        listOfCon[0].RecordID__c = listOfTS[0].Id;
        
        //Act
        insert listOfCon;
        
        //Assert
        Contact objCon = [SELECT Id,Object_Name__c, Picklist_Fields__c, LastName, RecordID__c FROM Contact LIMIT 1];
        System.assertNotEquals(null, objCon.Object_Name__c);
        System.assertEquals(null, objCon.Picklist_Fields__c);
        
        //Arrange
        objCon.RecordID__c = listOfTS[1].Id;
        
        //Act
        Test.startTest();
        update objCon;
        Test.stopTest();
        
        //Assert
        Contact updatedContact = [SELECT Object_Name__c, Picklist_Fields__c FROM Contact LIMIT 1];
        System.assertNotEquals(null, updatedContact.Object_Name__c);
        System.assertEquals(null, updatedContact.Picklist_Fields__c);
    }
}