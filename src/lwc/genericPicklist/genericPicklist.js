/*
 *
 *  Purpose          :	Genereic Picklist Component
 *
 *  Created Date     :  	31/1/2025
 *
 *  Created By       :  	Shubham Raut
 *
 *  Revision Logs    :  	V_1.0 - Created - Shubham Raut
 *
 */
import { LightningElement, api, track, wire } from 'lwc';
import { getPicklistValues, getObjectInfo } from 'lightning/uiObjectInfoApi';

export default class GenericPicklist extends LightningElement {

    @api objectApiName;
    @api fieldApiName;
    @track options;
    @track value;
    recordTypeId;
    fieldLabel;

    
    // To retrieve Object's default record type id
    @wire(getObjectInfo, { objectApiName: '$objectApiName' })
    objectInfo({ data, error }) {
        if (data) {
            this.recordTypeId = data.defaultRecordTypeId;

            // Retrieving the picklist field label to Show on UI
            if (data.fields && data.fields[this.fieldApiName]) {
                this.fieldLabel = data.fields[this.fieldApiName].label;
            }

        } else if (error) {
            console.error('Error fetching object info:', error);
        }
    }


    // To retrieve the picklist field values
    @wire(getPicklistValues, { recordTypeId: '$recordTypeId', fieldApiName: '$getFieldApi' })
    picklistValues({ error, data }) {
        if (data) {

            // will return an Array of PicklistValues
            this.options = data.values.map(picklistValue => ({
                label: picklistValue.label,
                value: picklistValue.value
            }));
        } else if (error) {
            console.error('Error fetching picklist values: ', error);
        }
    }

    /*To set the selected picklist value and 
     pass the selected value to parent component*/
    handleChange(event) {
        this.value = event.detail.value;
        const picklistChangeEvent = new CustomEvent('picklistchange', {
            detail: {
                value: this.value
            }
        });
        this.dispatchEvent(picklistChangeEvent);
    }

    // Will concatenate objectApiName & fieldApiName to pass in wire 'fieldApiName' parameter
    get getFieldApi() {
        return this.objectApiName && this.fieldApiName ? this.objectApiName+'.'+this.fieldApiName : null;
    }
}