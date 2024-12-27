/**
* Description : It Contains Methods to Create Test Records Of Objects for Test Classes
*               
* Created By : Shubham Raut
*
* Created Date : 25/12/24
*
* Revision Logs : V1.0 - Created - Shubham Raut
*
**/
@isTest
public class TestDataFactory {

    //Account
    public static List<Account> createAccountRec(String name, Integer countOfAccToCreate, Boolean isInsert){
       
        List<Account> listOfAcc = new List<Account>();
        
        for(Integer i=1; i <= countOfAccToCreate; i++){
            
            Account objAcc = new Account(Name = name+' '+i);
            listOfAcc.add(objAcc);
        }
        
        if(isInsert){
          insert listOfAcc;
        }
        
        return listOfAcc;
    }
    
    
    //Contact
    public static List<Contact> createContactRec(String name, Integer countOfContactToCreate, Boolean isInsert){
       
        List<Contact> listOfContact = new List<Contact>();
        
        for(Integer i=1; i <= countOfContactToCreate; i++){
            
            Contact objCon = new Contact(LastName = name+' '+i);
            listOfContact.add(objCon);
        }
        
        if(isInsert){
          insert listOfContact;
        }
        
        return listOfContact;
    }
    
    
    //Training Session 
    public static List<Training_Session__c> createTrainingSessionRec(String name, Integer countOfTrainingSessToCreate, Boolean isInsert){
       
        List<Training_Session__c> listOfTrainingSess = new List<Training_Session__c>();
        
         for(Integer i=1 ; i <= countOfTrainingSessToCreate ; i++){
            Training_Session__c objSess = new Training_Session__c();
            objSess.Name__c = name+' '+i;
            objSess.Session_Date__c = System.today()+30;
            listOfTrainingSess.add(objSess);     
        }
        
        if(isInsert){
          insert listOfTrainingSess;
        }
        
        return listOfTrainingSess;
    }


    //Lead
    public static List<Lead> createLeadRec(String lastName, Integer countOfLeadToCreate, Boolean isInsert){
       
        List<Lead> listOfLead = new List<Lead>();
        
        for(Integer i=1; i <= countOfLeadToCreate; i++){
            
            Lead objLead = new Lead();
            objLead.LastName = lastName+' '+i;
            objLead.Company = 'GS Dynamics';
            objLead.Status = 'Open - Not Contacted';
            listOfLead.add(objLead);
        }
        
        if(isInsert){
          insert listOfLead;
        }
        
        return listOfLead;
    }
    
}