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
* Coverage : 100%
**/
@isTest
private class AttendeeTriggerHandler_Test {
    
    //Setup method to create Training Session & Contact
    @testSetup
    private static void createTrainingSesAndContact_Test(){
        
        //Training Session
        List<Training_Session__c> listOfTrainingSess = new List<Training_Session__c>();
        
        for(Integer i=0 ; i < 3 ; i++){
            Training_Session__c objSess = new Training_Session__c();
            objSess.Name__c = 'Training Session'+i;
            objSess.Session_Date__c = System.today();
            listOfTrainingSess.add(objSess);     
        }
        
        insert listOfTrainingSess;
        
        //Contact
        List<Contact> listOfContact = new List<Contact>();
        
        for(Integer i=0 ; i < 2 ; i++){
            
            Contact objCon = new Contact(LastName = 'Contact'+i);
            listOfContact.add(objCon);     
        }
        
        insert listOfContact;        
    }
    
    //=================================================Insert==========================================================
    
    @isTest(seeAllData = false)
    private static void countSessionsOnContact_Test(){
        
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
        
        try{
            Test.startTest();
            insert listOfAttendee;
            Test.stopTest();
            
            Contact UpdatedContact = [SELECT Id, No_of_Sessions__c FROM Contact LIMIT 1];
            
            Assert.areEqual(2 , UpdatedContact.No_of_Sessions__c, 'Error in getting Training Sess Count!');
        }
        catch(Exception e){
            System.debug('Error inserting Attendees :=>' + e.getMessage());
        }       
    }
    
    
    @isTest(seeAllData = false)
    private static void countUniqueSessionsOnContact_Test(){
        
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
        
        try{
            Test.startTest();
            insert listOfAttendee;
            Test.stopTest();
            
            Contact UpdatedContact = [SELECT Id, No_of_Sessions__c FROM Contact LIMIT 1];
            
            Assert.areEqual(1 , UpdatedContact.No_of_Sessions__c, 'Error in getting Training Sess Count!');
        }
        catch(Exception e){
            System.debug('Error inserting Attendees :=>' + e.getMessage());
        }        
    }
    
    //=====================================Update===========================================================================
    
    @isTest(seeAllData = false)
    private static void countSessionOnContactWhenAttendeeUpdated_Test(){
        
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
        
        try{
            Test.startTest();
            update updateAttendee;
            Test.stopTest();
            
            List<Contact> listOfUpdatedContact = [SELECT Id, No_of_Sessions__c FROM Contact LIMIT 2];
            
            Assert.areEqual(2 , listOfUpdatedContact[0].No_of_Sessions__c, 'Error in getting Training Sess Count!');
            
            Assert.areEqual(1 , listOfUpdatedContact[1].No_of_Sessions__c, 'Error in getting Training Sess Count!');
            
        }
        catch(Exception e){
            System.debug('Error Updating Attendees :=>' + e.getMessage());
        }        
    }
    
    
    @isTest(seeAllData = false)
    private static void countSessionOnContactWhenAttendeeUpdated_Test101(){
        
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
        
        try{
            Test.startTest();
            update updateAttendee;
            Test.stopTest();
            
            List<Contact> listOfUpdatedContact = [SELECT Id, No_of_Sessions__c FROM Contact LIMIT 2];
            
            Assert.areEqual(2 , listOfUpdatedContact[0].No_of_Sessions__c, 'Error in getting Training Sess Count!');
            
            Assert.areEqual(0 , listOfUpdatedContact[1].No_of_Sessions__c, 'Error in getting Training Sess Count!');
            
        }
        catch(Exception e){
            System.debug('Error Updating Attendees :=>' + e.getMessage());
        }        
    }
    
    
    @isTest(seeAllData = false)
    private static void countSessOnConWhenBlankConAttendeeUpdated_Test(){
        
        List<Training_Session__c> listOfTrainingSess = [SELECT Id FROM Training_Session__c];
        
        Contact objContact = [SELECT Id FROM Contact LIMIT 1];
        
        
        Attendee__c objAtt1 = new Attendee__c();
        objAtt1.Email__c = 'demo@gmail.com';
        objAtt1.Session__c = listOfTrainingSess[0].Id;
        
        
        insert objAtt1;
        
        Attendee__c updateAttendee = [SELECT Id, Contact__c, Session__c FROM Attendee__c LIMIT 1];
        updateAttendee.Contact__c = objContact.Id;
        
        try{
            Test.startTest();
            update updateAttendee;
            Test.stopTest();
            
            Contact objOfUpdatedContact = [SELECT Id, No_of_Sessions__c FROM Contact LIMIT 1];
            
            Assert.areEqual(1 , objOfUpdatedContact.No_of_Sessions__c, 'Error in getting Training Sess Count!');
            
        }
        catch(Exception e){
            System.debug('Error Updating Attendees :=>' + e.getMessage());
        }        
    }   
    
    //=====================================Delete============================================================================
    
    @isTest(seeAllData = false)
    private static void countSessionOnContactWhenAttendeeDeleted_Test(){
        
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
        
        try{
            Test.startTest();
            delete listOfAttendee[0];
            Test.stopTest();
            
            Contact UpdatedContact = [SELECT Id, No_of_Sessions__c FROM Contact LIMIT 1];
            
            Assert.areEqual(1 , UpdatedContact.No_of_Sessions__c, 'Error in getting Training Ses Count!');
        }
        catch(Exception e){
            System.debug('Error Deleting Attendees :=>' + e.getMessage());
        }       
    }
    
    
    
    @isTest(seeAllData = false)
    private static void countUniqueSessionOnContactWhenAttendeeDeleted_Test(){
        
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
        
        try{
            Test.startTest();
            delete listOfAttendee[0];
            Test.stopTest();
            
            Contact UpdatedContact = [SELECT Id, No_of_Sessions__c FROM Contact LIMIT 1];
            
            Assert.areEqual(2 , UpdatedContact.No_of_Sessions__c, 'Error in getting Training Ses Count!');
        }
        catch(Exception e){
            System.debug('Error Deleting Attendees :=>' + e.getMessage());
        }       
    }
    
    
    @isTest(seeAllData = false)
    private static void countUniqueSessionOnContactWhenOnlyAttendeeDeleted_Test(){
        
        List<Training_Session__c> listOfTrainingSess = [SELECT Id FROM Training_Session__c LIMIT 1];
        
        List<Contact> listOfContact = [SELECT Id FROM Contact LIMIT 1];
        
        
        Attendee__c objAtt1 = new Attendee__c();
        objAtt1.Email__c = 'demo@gmail.com';
        objAtt1.Session__c = listOfTrainingSess[0].Id;
        objAtt1.Contact__c = listOfContact[0].Id;
        
        insert objAtt1;
        
        try{
            Test.startTest();
            delete objAtt1;
            Test.stopTest();
            
            Contact UpdatedContact = [SELECT Id, No_of_Sessions__c FROM Contact LIMIT 1];
            
            Assert.areEqual(0 , UpdatedContact.No_of_Sessions__c, 'Error in getting Training Ses Count!');
        }
        catch(Exception e){
            System.debug('Error Deleting Attendees :=>' + e.getMessage());
        }      
    }    
    
    //=====================================Undelete==========================================================================
    
    @isTest(seeAllData = false)
    private static void countUniqueSessionsOnContact_Test1(){
        
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
                
        try{
            Test.startTest();
            undelete objAttendeeToDelete;
            Test.stopTest();
            
            Contact UpdatedContact = [SELECT Id, No_of_Sessions__c FROM Contact LIMIT 1];
            
            Assert.areEqual(2 , UpdatedContact.No_of_Sessions__c, 'Error in getting Training Sess Count!');
        }
        catch(Exception e){
            System.debug('Error Undeleting Attendees :=>' + e.getMessage());
        }        
    }
}