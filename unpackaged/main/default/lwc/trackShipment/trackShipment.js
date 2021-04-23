import { LightningElement, api, wire, track } from 'lwc';
import { getRecord, getFieldValue } from 'lightning/uiRecordApi';
import getShippingInformation from '@salesforce/apex/ShippingController.getShippingInformation';

const columns = [
    {label:'Tracking Number', fieldName: 'Name', type: 'text', hideDefaultActions: true},
    {label:'Return City', fieldName: 'Return_City__c', type: 'text', hideDefaultActions: true},
    {label:'Return Country', fieldName: 'Return_Country__c', type: 'text', hideDefaultActions: true},
    {label:'Delivery City', fieldName: 'Delivery_City__c', type: 'text',hideDefaultActions: true},
    {label:'Delivery Country', fieldName: 'Delivery_Country__c', type: 'text', hideDefaultActions: true},
    {label:'Status', fieldName: 'Status__c', type: 'text', hideDefaultActions: true}
]

export default class TrackShipment extends LightningElement {
    @track trackingNum = '';

    searchShipping(event) {
        this.trackingNum = event.target.value;
    }


    error;
    columns = columns;

    @wire(getShippingInformation, {trackingNumber: '$trackingNum'}) shipping;
    @track shippingRecord;

    handleSearchShipping() {
        
        if (this.trackingNum !== '') {
            getShippingInformation({
                    trackingNumber: this.trackingNum
                })
                .then(result => { 
                    this.shippingRecord = result;
                })
                .catch(error => { 
                    this.shippingRecord = null;
                });
        } 
   }
}