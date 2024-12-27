/**
* Description : It Contains Attendee Object Triggers Test Methods for Coverage
*               (Attendee is child of Contact & Training Session)
*
* Created By : Shubham Raut
*
* Created Date : 15/12/24
*
* Revision Logs : V1.0 - Created - Shubham Raut
*
* Coverage : 88%
**/
@isTest
private class AttendeeTriggerHandler_Test {
    
    //Setup method to create Training Session & Contact
    @testSetup
    private static void createTrainingSesAndContact_Test(){
        
        //Created Training Session
        List<Training_Session__c> listOfTrainingSess = TestDataFactory.createTrainingSessionRec('Training Session', 3, true);
        
        //Created Contact
        List<Contact> listOfContact = TestDataFactory.createContactRec('Test Contact', 2, true);
    }
    
    //=================================================Insert==========================================================
    
    @isTest(seeAllData = false)
    private static void countSessionsOnContact_Test(){
        
        //Arrange
        List<Attendee__c> listOfAttendee = new List<Attendee__c>();
        
        List<Training_Session__c> listOfTrainingSess = [SELECT Id FROM Training_Session__c];
        
        List<Contact> listOfContact = [SELECT Id FROM Contact LIMIT 1];
        
        Attendee__c objAtt1 = new Attendee__c();
        objAtt1.Email__c = 'demo@gmail.com';
        objAtt1.Session__c = listOfTrainingSess[0].Id;
        objAtt1.Contact__c = listOfContact[0].Id;
        listOfAttendee.add(objAtt1);
        
        Attendee__c objAtt2 = new Attendee__c();
        objAtt2.Email__c = 'demo@gmail.com';
        objAtt2.Session__c = listOfTrainingSess[1].Id;
        objAtt2.Contact__c = listOfContact[0].Id;
        listOfAttendee.add(objAtt2);
        
        //Act
        Test.startTest();
        insert listOfAttendee;
        Test.stopTest();
        
        Contact UpdatedContact = [SELECT Id, No_of_Sessions__c FROM Contact LIMIT 1];
        
        //Assert
        Assert.areEqual(2 , UpdatedContact.No_of_Sessions__c, 'Error in getting Training Sess Count!');
        
    }
    
    
    @isTest(seeAllData = false)
    private static void countUniqueSessionsOnContact_Test(){
        
        //Arrange
        List<Attendee__c> listOfAttendee = new List<Attendee__c>();
        
        List<Training_Session__c> listOfTrainingSess = [SELECT Id FROM Training_Session__c];
        
        List<Contact> listOfContact = [SELECT Id FROM Contact LIMIT 1];
        
        Attendee__c objAtt1 = new Attendee__c();
        objAtt1.Email__c = 'demo@gmail.com';
        objAtt1.Session__c = listOfTrainingSess[0].Id;
        objAtt1.Contact__c = listOfContact[0].Id;
        listOfAttendee.add(objAtt1);
        
        Attendee__c objAtt2 = new Attendee__c();
        objAtt2.Email__c = 'demo@gmail.com';
        objAtt2.Session__c = listOfTrainingSess[0].Id;
        objAtt2.Contact__c = listOfContact[0].Id;
        listOfAttendee.add(objAtt2);
        
        //Act
        Test.startTest();
        insert listOfAttendee;
        Test.stopTest();
        
        Contact UpdatedContact = [SELECT Id, No_of_Sessions__c FROM Contact LIMIT 1];
        
        //Assert
        Assert.areEqual(1 , UpdatedContact.No_of_Sessions__c, 'Error in getting Training Sess Count!');
        
    }
    
    //=====================================Update===========================================================================
    
    @isTest(seeAllData = false)
    private static void countSessionOnContactWhenAttendeeUpdated_Test(){
        
        //Arrange
        List<Attendee__c> listOfAttendee = new List<Attendee__c>();
        
        List<Training_Session__c> listOfTrainingSess = [SELECT Id FROM Training_Session__c];
        
        List<Contact> listOfContact = [SELECT Id FROM Contact];
        
        Attendee__c objAtt1 = new Attendee__c();
        objAtt1.Email__c = 'demo@gmail.com';
        objAtt1.Session__c = listOfTrainingSess[0].Id;
        objAtt1.Contact__c = listOfContact[0].Id;
        listOfAttendee.add(objAtt1);
        
        Attendee__c objAtt2 = new Attendee__c();
        objAtt2.Email__c = 'demo@gmail.com';
        objAtt2.Session__c = listOfTrainingSess[1].Id;
        objAtt2.Contact__c = listOfContact[0].Id;
        listOfAttendee.add(objAtt2);
        
        Attendee__c objAtt3 = new Attendee__c();
        objAtt3.Email__c = 'demo@gmail.com';
        objAtt3.Session__c = listOfTrainingSess[2].Id;
        objAtt3.Contact__c = listOfContact[0].Id;
        listOfAttendee.add(objAtt3); 
        
        insert listOfAttendee;
        
        Attendee__c updateAttendee = [SELECT Id, Contact__c, Session__c FROM Attendee__c LIMIT 1];
        updateAttendee.Contact__c = listOfContact[1].Id;
        
        //Act
        Test.startTest();
        update updateAttendee;
        Test.stopTest();
        
        List<Contact> listOfUpdatedContact = [SELECT Id, No_of_Sessions__c FROM Contact LIMIT 2];
        
        //Assert
        Assert.areEqual(2 , listOfUpdatedContact[0].No_of_Sessions__c, 'Error in getting Training Sess Count!');
        
        Assert.areEqual(1 , listOfUpdatedContact[1].No_of_Sessions__c, 'Error in getting Training Sess Count!');     
    }
    
    
    @isTest(seeAllData = false)
    private static void countSessionOnContactWhenAttendeeUpdated_Test101(){
        
        //Arrange
        List<Attendee__c> listOfAttendee = new List<Attendee__c>();
        
        List<Training_Session__c> listOfTrainingSess = [SELECT Id FROM Training_Session__c];
        
        List<Contact> listOfContact = [SELECT Id FROM Contact];
        
        Attendee__c objAtt1 = new Attendee__c();
        objAtt1.Email__c = 'demo@gmail.com';
        objAtt1.Session__c = listOfTrainingSess[1].Id;
        objAtt1.Contact__c = listOfContact[1].Id;
        listOfAttendee.add(objAtt1);
        
        Attendee__c objAtt2 = new Attendee__c();
        objAtt2.Email__c = 'demo@gmail.com';
        objAtt2.Session__c = listOfTrainingSess[1].Id;
        objAtt2.Contact__c = listOfContact[0].Id;
        listOfAttendee.add(objAtt2);
        
        Attendee__c objAtt3 = new Attendee__c();
        objAtt3.Email__c = 'demo@gmail.com';
        objAtt3.Session__c = listOfTrainingSess[2].Id;
        objAtt3.Contact__c = listOfContact[0].Id;
        listOfAttendee.add(objAtt3); 
        
        insert listOfAttendee;
        
        Attendee__c updateAttendee = [SELECT Id, Contact__c, Session__c FROM Attendee__c LIMIT 1];
        updateAttendee.Contact__c = listOfContact[0].Id;
        
        //Act
        Test.startTest();
        update updateAttendee;
        Test.stopTest();
        
        List<Contact> listOfUpdatedContact = [SELECT Id, No_of_Sessions__c FROM Contact LIMIT 2];
        
        //Assert
        Assert.areEqual(2 , listOfUpdatedContact[0].No_of_Sessions__c, 'Error in getting Training Sess Count!');
        
        Assert.areEqual(0 , listOfUpdatedContact[1].No_of_Sessions__c, 'Error in getting Training Sess Count!');
        
    }
    
    
    @isTest(seeAllData = false)
    private static void countSessOnConWhenBlankConAttendeeUpdated_Test(){
        
        //Arrange
        List<Training_Session__c> listOfTrainingSess = [SELECT Id FROM Training_Session__c];
        
        Contact objContact = [SELECT Id FROM Contact LIMIT 1];
        
        Attendee__c objAtt1 = new Attendee__c();
        objAtt1.Email__c = 'demo@gmail.com';
        objAtt1.Session__c = listOfTrainingSess[0].Id;
        
        insert objAtt1;
        
        Attendee__c updateAttendee = [SELECT Id, Contact__c, Session__c FROM Attendee__c LIMIT 1];
        updateAttendee.Contact__c = objContact.Id;
        
        //Act
        Test.startTest();
        update updateAttendee;
        Test.stopTest();
        
        Contact objOfUpdatedContact = [SELECT Id, No_of_Sessions__c FROM Contact LIMIT 1];
        
        //Assert
        Assert.areEqual(1 , objOfUpdatedContact.No_of_Sessions__c, 'Error in getting Training Sess Count!');   
    }   
    
    //=====================================Delete============================================================================
    
    @isTest(seeAllData = false)
    private static void countSessionOnContactWhenAttendeeDeleted_Test(){
        
        //Arrange
        List<Attendee__c> listOfAttendee = new List<Attendee__c>();
        
        List<Training_Session__c> listOfTrainingSess = [SELECT Id FROM Training_Session__c];
        
        List<Contact> listOfContact = [SELECT Id FROM Contact LIMIT 1];
        
        Attendee__c objAtt1 = new Attendee__c();
        objAtt1.Email__c = 'demo@gmail.com';
        objAtt1.Session__c = listOfTrainingSess[0].Id;
        objAtt1.Contact__c = listOfContact[0].Id;
        listOfAttendee.add(objAtt1);
        
        Attendee__c objAtt2 = new Attendee__c();
        objAtt2.Email__c = 'demo@gmail.com';
        objAtt2.Session__c = listOfTrainingSess[1].Id;
        objAtt2.Contact__c = listOfContact[0].Id;
        listOfAttendee.add(objAtt2);
        
        insert listOfAttendee;
        
        //Act
        Test.startTest();
        delete listOfAttendee[0];
        Test.stopTest();
        
        Contact UpdatedContact = [SELECT Id, No_of_Sessions__c FROM Contact LIMIT 1];
        
        //Assert
        Assert.areEqual(1 , UpdatedContact.No_of_Sessions__c, 'Error in getting Training Ses Count!');   
    }
    
    
    
    @isTest(seeAllData = false)
    private static void countUniqueSessionOnContactWhenAttendeeDeleted_Test(){
        
        //Act
        List<Attendee__c> listOfAttendee = new List<Attendee__c>();
        
        List<Training_Session__c> listOfTrainingSess = [SELECT Id FROM Training_Session__c];
        
        List<Contact> listOfContact = [SELECT Id FROM Contact LIMIT 1];
              
        Attendee__c objAtt1 = new Attendee__c();
        objAtt1.Email__c = 'demo@gmail.com';
        objAtt1.Session__c = listOfTrainingSess[0].Id;
        objAtt1.Contact__c = listOfContact[0].Id;
        listOfAttendee.add(objAtt1);
        
        Attendee__c objAtt2 = new Attendee__c();
        objAtt2.Email__c = 'demo@gmail.com';
        objAtt2.Session__c = listOfTrainingSess[0].Id;
        objAtt2.Contact__c = listOfContact[0].Id;
        listOfAttendee.add(objAtt2);
        
        Attendee__c objAtt3 = new Attendee__c();
        objAtt3.Email__c = 'demo@gmail.com';
        objAtt3.Session__c = listOfTrainingSess[1].Id;
        objAtt3.Contact__c = listOfContact[0].Id;
        listOfAttendee.add(objAtt3);
        
        insert listOfAttendee;
        
        //Act
        Test.startTest();
        delete listOfAttendee[0];
        Test.stopTest();
        
        Contact UpdatedContact = [SELECT Id, No_of_Sessions__c FROM Contact LIMIT 1];
        
        //Assert
        Assert.areEqual(2 , UpdatedContact.No_of_Sessions__c, 'Error in getting Training Ses Count!');
    }
    
    
    @isTest(seeAllData = false)
    private static void countUniqueSessionOnContactWhenOnlyAttendeeDeleted_Test(){
        
        //Act
        List<Training_Session__c> listOfTrainingSess = [SELECT Id FROM Training_Session__c LIMIT 1];
        
        List<Contact> listOfContact = [SELECT Id FROM Contact LIMIT 1];
        
        Attendee__c objAtt1 = new Attendee__c();
        objAtt1.Email__c = 'demo@gmail.com';
        objAtt1.Session__c = listOfTrainingSess[0].Id;
        objAtt1.Contact__c = listOfContact[0].Id;
        
        insert objAtt1;
        
        //Act
        Test.startTest();
        delete objAtt1;
        Test.stopTest();
        
        Contact UpdatedContact = [SELECT Id, No_of_Sessions__c FROM Contact LIMIT 1];
        
        //Assert
        Assert.areEqual(0 , UpdatedContact.No_of_Sessions__c, 'Error in getting Training Ses Count!');
    }    
    
    //=====================================Undelete==========================================================================
    
    @isTest(seeAllData = false)
    private static void countUniqueSessionsOnContact_Test1(){
        
        //Arrange
        List<Attendee__c> listOfAttendee = new List<Attendee__c>();
        
        List<Training_Session__c> listOfTrainingSess = [SELECT Id FROM Training_Session__c];
        
        List<Contact> listOfContact = [SELECT Id FROM Contact LIMIT 1];
        
        Attendee__c objAtt1 = new Attendee__c();
        objAtt1.Email__c = 'demo@gmail.com';
        objAtt1.Session__c = listOfTrainingSess[0].Id;
        objAtt1.Contact__c = listOfContact[0].Id;
        listOfAttendee.add(objAtt1);
        
        Attendee__c objAtt2 = new Attendee__c();
        objAtt2.Email__c = 'demo@gmail.com';
        objAtt2.Session__c = listOfTrainingSess[1].Id;
        objAtt2.Contact__c = listOfContact[0].Id;
        listOfAttendee.add(objAtt2);
        
        insert listOfAttendee;
        
        Attendee__c objAttendeeToDelete = [SELECT Id FROM Attendee__c LIMIT 1];
        
        delete objAttendeeToDelete;
        
        //Act
        Test.startTest();
        undelete objAttendeeToDelete;
        Test.stopTest();
        
        Contact UpdatedContact = [SELECT Id, No_of_Sessions__c FROM Contact LIMIT 1];
        
        //Assert
        Assert.areEqual(2 , UpdatedContact.No_of_Sessions__c, 'Error in getting Training Sess Count!');
    }
}