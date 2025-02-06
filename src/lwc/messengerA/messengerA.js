/*
 *
 *  Purpose          :	To Publish the Message for "messengerB" Component and 
 *                      Subscribe the message from "messengerB" Component
 *
 *  Created Date     :  	30/1/2025
 *
 *  Created By       :  	Shubham Raut
 *
 *  Revision Logs    :  	V_1.0 - Created - Shubham Raut
 *
 */
import { LightningElement, wire} from 'lwc';
import { publish, subscribe, MessageContext } from 'lightning/messageService';
import MESSAGECHANNEL from "@salesforce/messageChannel/DemoChannel__c";


export default class MessengerA extends LightningElement {

    @wire(MessageContext)
    messageContext;

    messageFromB = '';
    sendMessage = '';

    // Method to handle the message and publish the message
    handleMessage() {

        const inp = this.template.querySelector("lightning-input");
        this.sendMessage = inp.value;
        this.publishMessage();
    }


    publishMessage() {
        publish(this.messageContext, MESSAGECHANNEL, { messageToSend: this.sendMessage , sourceSystem: this.messageFromB});
    }

    connectedCallback() {
        
        this.subscribeToMessageChannel();
    }

    subscribeToMessageChannel() {

        subscribe(this.messageContext, MESSAGECHANNEL, (message) => {
            this.messageFromB = message.sourceSystem;
        });
    }
}