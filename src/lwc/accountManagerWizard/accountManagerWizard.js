/*
 *
 *  Purpose          :	Account Manager Wizard to Show Account Details, its Contacts with Contact search functionality 
 *                      and related Contact creation
 *
 *  Created Date     :  	23/1/2025
 *
 *  Created By       :  	Shubham Raut
 *
 *  Revision Logs    :  	V_1.0 - Created - Shubham Raut
 *
 */
import { LightningElement, api, wire } from 'lwc';
import getContacts from '@salesforce/apex/ContactManager.getContacts';
import { getRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import createContact from '@salesforce/apex/ContactManager.createContact';
import { refreshApex } from '@salesforce/apex';


const ACCOUNT_FIELDS = [
    'Account.Name',
    'Account.OwnerId',
    'Account.Description'
];

export default class AccountManagerWizard extends LightningElement {
    @api recordId;
    @api objectApiName;
    searchData = '';
    isModalOpen = false;
    passBlank = '';
    contactsCount;
    wiredContactToCountResult;
    errorsToShow = '';
    contactsError = '';
    contacts = [];

    columnsContact = [
        { label: 'Name', fieldName: 'Name' },
        { label: 'Email', fieldName: 'Email', type: 'email' },
        { label: 'Phone', fieldName: 'Phone', type: 'phone' }
    ]; 


    // To get Account record to show details
    @wire(getRecord, { recordId: '$recordId', fields: ACCOUNT_FIELDS })
    wiredAccount({ error, data }) {
        if (error) {
            this.errorsToShow = this.errorsToShow +' '+ error.body.message ;
        }         
    }

    // To get Total Contacts count to show
    @wire(getContacts, { accountId: '$recordId', dataSearch: '$passBlank', wantCount: true })
    contactsToCount(value) {
       
        this.wiredContactToCountResult = value;
        const { data, error } = value;

        if (data) { 
            if (data.isSuccess) {
                this.contactsCount = data.body.length;
            } else {
                this.errorsToShow = this.errorsToShow +' '+ data.message;
            }
         }
        else if (error) { 

            this.errorsToShow = this.errorsToShow +' '+ error.body.message;
         }
    }

    // To get All related Contacts
    @wire(getContacts, { accountId: '$recordId', dataSearch: '$searchData', wantCount: false })
    wiredContacts({ error, data }) {
        if (data) {
            if (data.body.length > 0) {
            this.contacts = data.body;
            }
            else {
                this.contactsError = 'No Contacts Found';
            }
        } else if (error) {
            this.contactsError = error.body.message;
        }
    }

    // To get Searching Input
    handleKeyUp(event) {

        this.searchData = event.target.value;
    }

    // On click of New Contact
    handleCreateNewContact() {

        this.isModalOpen = true;
    }
   
    // On click of Cancel
    handleCloseModal() {

        this.isModalOpen = false;
    }

    // On click of Save
    handleSave(){

        // Calling Contact Save Form comp. Method to perform Validation & to fire custom Event 
        this.template.querySelector('c-contact-save-form').handleContact();
    }

    // To Handle Custom Event of Contact info for contact creation
    handleSaveContact(event) {

        const contactDetails = event.detail;

        let myContact = { 'sobjectType': 'Contact' };

        myContact.FirstName = contactDetails.firstName;
        myContact.LastName = contactDetails.lastName;
        myContact.Email = contactDetails.email;
        myContact.AccountId = this.recordId;


        createContact({ contact : myContact })
            .then(result => {
                if (result.isSuccess) {
                    this.showToast('Success', result.message, 'success');
                    refreshApex(this.contacts);
                    refreshApex(this.account);
                    refreshApex(this.wiredContactToCountResult);
                    this.isModalOpen = false;
                } else {
                    this.showToast('Error', result.message, 'error');
                }
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