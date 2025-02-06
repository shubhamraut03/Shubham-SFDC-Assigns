/*
 *
 *  Purpose          :	Parent Component to pass data to child component
 *
 *  Created Date     :  	23/1/2025
 *
 *  Created By       :  	Shubham Raut
 *
 *  Revision Logs    :  	V_1.0 - Created - Shubham Raut
 *
 */
import { LightningElement } from 'lwc';

export default class ParentComponent extends LightningElement {

    message;

    handleEvent(event) {

        this.message = event.target.value;
    }  
}