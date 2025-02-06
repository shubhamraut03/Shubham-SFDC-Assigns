/*
 *
 *  Purpose          :	To Publish the Message for "messengerA" Component and 
 *                      Subscribe the message from "messengerA" Component
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

export default class MessengerB extends LightningElement {
    
    
    @wire(MessageContext)
    messageContext;
    
    messageFromA = '';
    sendMessage = '';
    
    // Method to handle the message and publish the message
    handleMessage() {

        const inp = this.template.querySelector("lightning-input");
        this.sendMessage = inp.value;
        this.publishMessage();
    }

    publishMessage() {
        publish(this.messageContext, MESSAGECHANNEL, { sourceSystem: this.sendMessage, messageToSend: this.messageFromA});
    }    
   
    connectedCallback(){
       
        this.subscribeToMessageChannel();
    }
    
    subscribeToMessageChannel(){
    
        subscribe(this.messageContext, MESSAGECHANNEL, (message) => {
            this.messageFromA = message.messageToSend;
        });
    }
}