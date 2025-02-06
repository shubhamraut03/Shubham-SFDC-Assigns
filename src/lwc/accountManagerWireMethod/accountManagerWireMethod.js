/*
 *
 *  Purpose          :	To display the list of Accounts using wire Apex call.
 *
 *  Created Date     :  	31/1/2025
 *
 *  Created By       :  	Shubham Raut
 *
 *  Revision Logs    :  	V_1.0 - Created - Shubham Raut
 *
 */
import { LightningElement, track, wire } from 'lwc';
import getAccountListWire from '@salesforce/apex/AccountManager.getAccountListWire';

const columnsAcc = [
    { label: 'Name', fieldName: 'Name' },
    { label: 'Phone', fieldName: 'Phone', type: 'phone' },
    { label: 'Rating', fieldName: 'Rating', type: 'picklist' },
    { label: 'Domain', fieldName: 'Domain__c', type: 'email' },
    { label: 'Website', fieldName: 'Website', type: 'url' },
];

export default class AccountManagerWireMethod extends LightningElement {

    @track dataAcc = null;
    @track columns = columnsAcc;
    error = null;

    @wire(getAccountListWire)
    wiredAccounts({ error, data }) {
        if (data) {
            this.dataAcc = data;
            this.error = undefined;
        } else if (error) {
            this.error = error;
            this.dataAcc = undefined;
        }
    }
}