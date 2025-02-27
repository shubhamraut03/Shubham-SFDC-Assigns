/*
 *
 *  Purpose          :	To handle Contact creation 
 *
 *  Created Date     :  	31/1/2025
 *
 *  Created By       :  	Shubham Raut
 *
 *  Revision Logs    :  	V_1.0 - Created - Shubham Raut
 *
 */
import { LightningElement, api, track } from 'lwc';

export default class ContactSaveForm extends LightningElement {

    @api isLoading = false;
    
    // To handle Inputs & validations (method will get called from Parent component "accountManagerWizard" on Save)
    @api handleContact() {
        
        this.isLoading = !this.isLoading;

        let isError = false;

        let contact = {
            firstName: '',
            lastName: '',
            email: ''
        };

        const inp = this.template.querySelectorAll("lightning-input");

        inp.forEach(function (element) {

            if (element.name == "firstName") {

                contact.firstName = element.value;
            }


            if (element.name == "lastName") {
               
                if (!element.value) {

                    element.setCustomValidity("Last Name should not be blank.");
                    element.reportValidity();
                    isError = true;

                } else {

                    element.setCustomValidity("");
                    contact.lastName = element.value;
                }

                element.reportValidity();
            }


            if (element.name == "email") {

                const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

                if (!element.value || !emailPattern.test(element.value)) {
                  
                    element.setCustomValidity("Please enter a valid email address.");
                    isError = true;
                } else {

                    element.setCustomValidity("");
                    contact.email = element.value;
                }

                element.reportValidity();
            }
        }, this);


        // Fires event to "accountManagerWizard" Comp. only if all fields values are valid
        if (!isError) {
            const selectEvent = new CustomEvent('save', {
                detail: contact
            });
            this.dispatchEvent(selectEvent);
        }

        this.isLoading = !this.isLoading;

    }

}