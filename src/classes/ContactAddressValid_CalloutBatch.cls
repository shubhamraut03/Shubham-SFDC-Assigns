/**
* Description : This Batch will make Callout to Smarty API to varify Address of Contacts
*               (Contact Trigger will execute this Batch)                
*
* Created By : Shubham Raut
*
* Created Date : 17/02/25
*
* Revision Logs : V1.0 - Created - Shubham Raut
*
*
**/
public class ContactAddressValid_CalloutBatch implements Database.Batchable<sObject>, Database.Stateful, Database.AllowsCallouts{
    
    private Set<Id> contactIdSet = new Set<Id>();
    
    public ContactAddressValid_CalloutBatch(Set<Id> setOfConId){
        contactIdSet = setOfConId;
    }
    
    public Database.QueryLocator start(Database.BatchableContext BC){
        
        String query = 'SELECT Id, MailingStreet, MailingCity, MailingState, MailingPostalCode ' + 
            'FROM Contact ' + 
            'WHERE Id IN :contactIdSet ' + 
            'AND MailingStreet != \'\' ' + 
            'AND MailingState != \'\' ' + 
            'AND MailingCity != \'\'';
        
        return Database.getQueryLocator(query);
    }
    
    public void execute(Database.BatchableContext BC, List<Contact> listOfContact){
        
        List<Contact> contactToUpdateList = new List<Contact>();
        
        for(Contact objCon : listOfContact){
            
            // Combine address components into a freeform input
            String freeformAddress = objCon.MailingStreet + ', ' + objCon.MailingCity + ', ' + objCon.MailingState + ' ' + objCon.MailingPostalCode;
            String freeformAddressEncoded = EncodingUtil.urlEncode(freeformAddress, 'UTF-8');
            
            // Smarty API Creds
            String authId = '73208ddc-42cb-c937-3c85-e6fb65841ed8';
            String authToken = 'Z4sWDICw2gf7tWUM8xfy';
            
            //Create a new instance of Http
            Http http = new Http();
            HttpRequest request = new HttpRequest();
            request.setEndpoint('https://us-street.api.smarty.com/street-address?'+authId+'&'+authToken+'&street=' + freeformAddressEncoded);
            request.setMethod('GET');
            request.setHeader('Content-Type','application/json');
            
            // Send the request
            HttpResponse response = http.send(request);
            
            
            // To Handle the response
            if (response.getStatusCode() == 200) {
                
                String responseBody = response.getBody();
                
                // In Smarty API -If Address is Invalid then it returns '[]' in Response Body
                if(!responseBody.contains('[]')){
                    // Update the contact record to mark AddressVerified as true
                    Contact updateCon = new Contact(Id = objCon.Id, AddressVerified__c = true);
                    contactToUpdateList.add(updateCon);
                }                
            } else {
                // To Handle the error response
                System.debug('Callout failed with status code: ' + response.getStatusCode());
                System.debug('Status: ' + response.getStatus());
                System.debug('Response: ' + response.getBody());
            }
        }
        
        if(!contactToUpdateList.isEmpty()){
            Database.SaveResult[] saveResults = Database.update(contactToUpdateList, false);
            for (Database.SaveResult sr : saveResults) {
                if (!sr.isSuccess()) {
                    Database.Error[] errors = sr.getErrors();
                    for (Database.Error err : errors) {
                        System.debug('Failed to update contact with Id: ' + sr.getId() + '. Error: ' + err.getMessage());
                    }
                }
            }
        }
        
    }
    
    public void finish(Database.BatchableContext BC){
        
    }
}