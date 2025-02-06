/*
 *
 *  Purpose          :	 Error Panel to display error messages
 *
 *  Created Date     :  	31/1/2025
 *
 *  Created By       :  	Shubham Raut
 *
 *  Revision Logs    :  	V_1.0 - Created - Shubham Raut
 *
 */
import { LightningElement, api } from 'lwc';

export default class ErrorPanel extends LightningElement {
  @api errors;
}