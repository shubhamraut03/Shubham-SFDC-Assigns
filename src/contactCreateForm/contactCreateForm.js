import { LightningElement, api } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import CONTACT_OBJECT from "@salesforce/schema/Contact";
import NAME_FIELD from "@salesforce/schema/Contact.Name";
import ACCOUNTID_FIELD from "@salesforce/schema/Contact.AccountId";
import EMAIL_FIELD from "@salesforce/schema/Contact.Email";
import PHONE_FIELD from "@salesforce/schema/Contact.Phone";

export default class ContactCreateForm extends LightningElement {
    @api accountId;

    contactObject = CONTACT_OBJECT;
    nameField = NAME_FIELD;
    emailField = EMAIL_FIELD;
    phoneField = PHONE_FIELD;
    accountIdField = ACCOUNTID_FIELD;

    handleSuccess() {
        this.showToast('Success', 'Contact Created Successfully', 'success');
    }

    handleError() {
        this.showToast('Error', 'Error in Creating Contact', 'error');
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