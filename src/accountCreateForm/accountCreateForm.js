import { LightningElement, api, track } from 'lwc';

export default class AccountCreateForm extends LightningElement {

    @track isLoading = false;
    @api accountId;
    @api isContactModalOpen = false;


    @api handleAccount() {

        let isError = false;

        let account = {
            Name: '',
            AccountNumber: '',
            Phone: ''
        };
        console.log('account1', JSON.stringify(account));

        const inp = this.template.querySelectorAll("lightning-input");

        inp.forEach(function (element) {

            if (element.name == "name") {

                if (!element.value) {

                    element.setCustomValidity("Account Name should not be blank.");
                    element.reportValidity();
                    isError = true;

                } else {

                    element.setCustomValidity("");
                    account.Name = element.value;
                    isError = false;
                }

                element.reportValidity();
            }
            if (element.name == "accountNumber") {

                account.AccountNumber = element.value;
            }

            if (element.name == "phone") {

                account.Phone = element.value;
            }

        });


        console.log('account', JSON.stringify(account));



        // spinner show
        this.isLoading = true;

        // Fires event to "accountWizardAssessment" Comp. only if Account Name is not blank
        if (!isError) {
            const selectEvent = new CustomEvent('save', {
                detail: account
            });
            this.dispatchEvent(selectEvent);
        }

        // spinner hide
        this.isLoading = false;

    }

    handleCloseModal() {
        this.isContactModalOpen = false;
    }
   
}