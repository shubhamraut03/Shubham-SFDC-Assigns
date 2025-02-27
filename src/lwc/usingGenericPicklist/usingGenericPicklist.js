/*
 *
 *  Purpose          :	To show picklist field values for any sObject using Generic Picklist Component
 *
 *  Created Date     :  	31/1/2025
 *
 *  Created By       :  	Shubham Raut
 *
 *  Revision Logs    :  	V_1.0 - Created - Shubham Raut
 *
 */
import { LightningElement } from 'lwc';

export default class UsingGenericPicklist extends LightningElement {

    selectedValue;
    objectApiName;
    fieldApiName;

    // To handle Inputs
    handleClick() {

        const inputs = this.template.querySelectorAll('lightning-input');

        inputs.forEach(input => {
            if (input.name == 'objectApiName') {
                this.objectApiName = input.value;
            }
            if (input.name == 'fieldApiName') {
                this.fieldApiName = input.value;
            }
        })

        this.selectedValue = null;
    }

    // To set the selected picklist value
    handlePicklistChange(event) {

        this.selectedValue = event.detail.value;
    }
}