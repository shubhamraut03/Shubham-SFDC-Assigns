/*
 *
 *  Purpose          :	Contact Manager Controller
 *
 *  Created Date     :  	23/1/2025
 *
 *  Created By       :  	Shubham Raut
 *
 *  Revision Logs    :  	V_1.0 - Created - Shubham Raut
 *
 */
public with sharing class ContactManager {
   
    /**
     *
     * @description : To get Contact Records using Wire Service.
     *
     * @args :   Id accountId , String dataSearch , Boolean wantCount.
     *
     * @return : LightningResponse - List<Contact> or String.
     *
     * @revision Log : V1.1 - Created - 23/1/2025 - Shubham Raut
     *
     **/
    @AuraEnabled(cacheable=true)
    public static LightningResponse getContacts(Id accountId, String dataSearch, Boolean wantCount) {
        
        try {
            List<Contact> contacts;
            if(String.isBlank(dataSearch)) {
                if(wantCount) {
                    contacts = [SELECT Id FROM Contact WHERE AccountId = :accountId];
                } else {
                    contacts = [SELECT Id, Name, Email, Phone FROM Contact WHERE AccountId = :accountId];
                }
            } else {
                contacts = [SELECT Id, Name, Email, Phone FROM Contact WHERE AccountId = :accountId AND Name LIKE :('%' + dataSearch + '%')];
            }
            return LightningResponse.success(contacts);
        } catch (Exception e) {
            return LightningResponse.error(e.getMessage());
        }
    }
    
    
    /**
     *
     * @description : To Create Contact Record Imperatively.
     *
     * @args : Contact contact.
     *
     * @return : LightningResponse - String.
     *
     * @revision Log : V1.1 - Created - 31/1/2025 - Shubham Raut
     *
     **/
    @AuraEnabled
    public static LightningResponse createContact(Contact contact) {
        
        try {
            if(contact != null) {
                insert contact;
                return LightningResponse.success('Contact created successfully');
            } else {
                return LightningResponse.error('Contact is null');
            }            
        } catch (Exception e) {
            return LightningResponse.error(e.getMessage());
        }    
    }
}