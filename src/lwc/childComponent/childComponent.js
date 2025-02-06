/*
 *
 *  Purpose          :	Child Component to receive data from parent component
 *
 *  Created Date     :  	23/1/2025
 *
 *  Created By       :  	Shubham Raut
 *
 *  Revision Logs    :  	V_1.0 - Created - Shubham Raut
 *
 */
import { LightningElement, api } from 'lwc';

export default class ChildComponent extends LightningElement {
    
    @api childMessage;
}