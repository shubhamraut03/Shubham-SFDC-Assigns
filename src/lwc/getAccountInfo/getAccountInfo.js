/*
 *
 *  Purpose          :	To get Account Information and Create Contact for that Account with LDS
 *
 *  Created Date     :  	25/1/2025
 *
 *  Created By       :  	Shubham Raut
 *
 *  Revision Logs    :  	V_1.0 - Created - Shubham Raut
 *
 */
import { LightningElement, api } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

import CONTACT_OBJECT from "@salesforce/schema/Contact";
import NAME_FIELD from "@salesforce/schema/Contact.Name";
import ACCOUNTID_FIELD from "@salesforce/schema/Contact.AccountId";
import EMAIL_FIELD from "@salesforce/schema/Contact.Email";
import PHONE_FIELD from "@salesforce/schema/Contact.Phone";
import LEADSOURCE from "@salesforce/schema/Contact.LeadSource";

export default class GetAccountInfo extends LightningElement {

    @api recordId;
    @api objectApiName;

    isShowContactForm = false;

    contactObject = CONTACT_OBJECT;
    nameField = NAME_FIELD;
    emailField = EMAIL_FIELD;
    phoneField = PHONE_FIELD;
    accountIdField = ACCOUNTID_FIELD;
    leadSourceField = LEADSOURCE;


    showCreateContactHandler() {

        this.isShowContactForm = true;
    }

    handleContactCreated() {

        this.isShowContactForm = false;

        this.dispatchEvent(
            new ShowToastEvent({
                title: 'Success',
                message: 'Contact is created',
                variant: 'success'
            })
        );
        // window.location.reload(true);
    }

    handleError(error) {
        this.dispatchEvent(
            new ShowToastEvent({
                title: 'Error',
                message: error.body.message,
                variant: 'error'
            })
        );
    }

    handleReset() {
        const inputFields = this.template.querySelectorAll("lightning-input-field");
        if (inputFields) {
            inputFields.forEach((field) => {
                field.reset();
            });
        }

        this.isShowContactForm = false;
    }


}