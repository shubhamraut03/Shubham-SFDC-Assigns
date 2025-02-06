/*
 *
 *  Purpose          :	To display the list of Accounts using imperative apex method
 *
 *  Created Date     :  	31/1/2025
 *
 *  Created By       :  	Shubham Raut
 *
 *  Revision Logs    :  	V_1.0 - Created - Shubham Raut
 *
 */
import { LightningElement, track } from 'lwc';
import getAccountList from '@salesforce/apex/AccountManager.getAccountList';

const columnsAcc = [
    { label: 'Name', fieldName: 'Name' },
    { label: 'Phone', fieldName: 'Phone', type: 'phone' },
    { label: 'Rating', fieldName: 'Rating', type: 'picklist' },
    { label: 'Domain', fieldName: 'Domain__c', type: 'email' },
    { label: 'Website', fieldName: 'Website', type: 'url' }
];

export default class AccountManagerImperative extends LightningElement {

    @track data = null;
    @track columns = columnsAcc;
    error = null;

    connectedCallback() {

        getAccountList()
            .then(result => {
                if (result.length > 0) {
                    this.data = result;
                } else {
                    throw new Error('No data available');
                }
            })
            .catch(error => {
                this.error = error.message;
            });
    }
}