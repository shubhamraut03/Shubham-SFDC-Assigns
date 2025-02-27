/*
 *
 *  Purpose          :	Account REST API Service to fetch Account Info by ID and Create Account & Contact
 *
 *  Created Date     :  	20/02/2025
 *
 *  Created By       :  	Shubham Raut
 *
 *  Revision Logs    :  	V_1.0 - Created - Shubham Raut
 *
 */
@RestResource(urlMapping='/AccountServices/*')
global with sharing class AccountRestAPIService {
    
    // GET Account Info by ID
    @HttpGet
    global static AccountResponseWrapper getAccountInfo() {
        try {
            String accountId = RestContext.request.requestURI.substringAfterLast('/');
            Account acc = [SELECT Id, Name FROM Account WHERE Id = :accountId LIMIT 1];
            
            return new AccountResponseWrapper(acc.Id, null, true, 'Success');
        } catch (Exception e) {
            return new AccountResponseWrapper(null, null, false, 'Account Not Found or Invalid ID');
        }
    }
    
    // POST Create Account & Contact (Ensures No Duplicate Contact)
    @HttpPost
    global static AccountResponseWrapper createAccountAndContact() {
        
        RestRequest req = RestContext.request;
        
        try {
            // Deserialize the request body to the AccountRequest class
            AccountRequestWrapper accountRequest = (AccountRequestWrapper) JSON.deserialize(req.requestBody.toString(), AccountRequestWrapper.class);
            
            if (String.isEmpty(accountRequest.accountName) || String.isEmpty(accountRequest.email) || String.isEmpty(accountRequest.lastName)) {
                
                return new AccountResponseWrapper(null, null, false, 'Missing required fields: Account Name Or Email Or LastName');
            }
            
            Account acc;
            
            // Fetch Existing Account
            List<Account> accList = [SELECT Id, Name FROM Account WHERE Name = :accountRequest.accountName LIMIT 1];
            
            if (accList.isEmpty()) {
                // Create a new Account if it does not exist
                acc = new Account(Name = accountRequest.accountName);
                insert acc;  
                return contactCreation(acc, accountRequest, 'Account and Contact created successfully');
            } else {
                // Retrieve the first (and only) account from the list
                acc = accList[0];
                return contactCreation(acc, accountRequest, 'Contact created successfully on Existing Account');
            }         
        } catch (Exception e) {
            return new AccountResponseWrapper(null, null, false, 'Error: ' + e.getMessage());
        }
    }
    
    // Handling Contact creation (Generic method)
    global static AccountResponseWrapper contactCreation(Account acc, AccountRequestWrapper accountRequest, String msg){
        
        // Check for duplicate Contact in the same Account
        List<Contact> listContact = [SELECT Id FROM Contact WHERE AccountId = :acc.Id AND Email = :accountRequest.email LIMIT 1];
        if (!listContact.isEmpty()) {
            return new AccountResponseWrapper(acc.Id, null, false, 'Duplicate contact found with the same email.');
        }
        else{
            // Create Contact
            Contact con = new Contact(
                FirstName = accountRequest.firstName, 
                LastName = accountRequest.lastName, 
                Email = accountRequest.email, 
                AccountId = acc.Id
            );
            
            insert con;              
            return new AccountResponseWrapper(acc.Id, con.Id, true, msg);
        }
    }
    
    // Response Wrapper
    global class AccountResponseWrapper {
        public String accountId, contactId, message;
        public Boolean success;
        
        public AccountResponseWrapper(String accId, String conId, Boolean success, String message) {
            this.accountId = accId;
            this.contactId = conId;
            this.success = success;
            this.message = message;
        }
    }
    
    // Request Wrapper
    global class AccountRequestWrapper {
        public String accountName, firstName, lastName, email;
    }
}