import { LightningElement } from 'lwc';

export default class ParentComponent extends LightningElement {

    message;

    handleEvent(event) {

        this.message = event.target.value;
    }  
}