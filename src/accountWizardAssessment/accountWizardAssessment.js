import { LightningElement, wire, track } from "lwc";
import getAccounts from "@salesforce/apex/AccountManagerAssessment.getAccounts";
import createAccount from '@salesforce/apex/AccountManagerAssessment.createAccount';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class AccountWizardAssessment extends LightningElement {
    @track accounts = [];
    @track accountsError;
    isAccountModalOpen = false;
    isContactModalOpen = false;
    accountId;

    columnsAccount = [
        { label: "Name", fieldName: "Name" },
        { label: "Type", fieldName: "Type", type: "picklist" },
        { label: "Industry", fieldName: "Industry", type: "picklist" },
        { label: "Phone", fieldName: "Phone", type: "phone" }
    ];

    // To get All related Contacts
    @wire(getAccounts)
    wiredAccounts({ error, data }) {
        if (data) {
            if (data.length > 0) {
                this.accounts = data;
            } else {
                this.accountsError = "No Accounts Found";
            }
        } else if (error) {
            this.accountsError = error.body.message;
        }
    }

    handleCreateNewAccount() {
        this.isAccountModalOpen = true;
    }

    // On click of Cancel
    handleCloseModal() {
        this.isAccountModalOpen = false;
    }

    // On click of Save
    handleSave() {
        // Calling Account Save Form component method
        this.template.querySelector("c-account-create-form").handleAccount();
    }

    // To Handle Custom Event of Account info for Account creation
    handleSaveAccount(event) {
    
        console.log('event.detail', event.detail);
            const accountDetails = event.detail;
    
            let myAccount = { 'sobjectType': 'Account' };
    
            myAccount.Name = accountDetails.firstName;
            myAccount.AccountNumber = accountDetails.AccountNumber;
            myAccount.Phone = accountDetails.phone;
           
    
    
            createAccount({ objAccount : myAccount })
                .then(result => {
                      this.accountId = result;
                        this.showToast('Success', 'Account Created Successfully', 'success');
                        this.isContactModalOpen = true;
                        refreshApex(this.accounts);
      
                })
                .catch(error => {
                    this.showToast('Error', error.body.message, 'error');
                });
        }


    showToast(title, message, variant) {
        this.dispatchEvent(
            new ShowToastEvent({
                title,
                message,
                variant,
            })
        );
    }

}
