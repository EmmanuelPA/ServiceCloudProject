import { LightningElement, wire, api } from 'lwc';
import { refreshApex } from '@salesforce/apex';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import getTracking from '@salesforce/apex/trackHandler.getTracking';
import getAllTracking from '@salesforce/apex/trackHandler.getAllTracking';
import deleteTrackingRecord from '@salesforce/apex/trackHandler.deleteTrackingRecord';

const ACTIONS = [
    { label: 'Edit', name: 'edit' },
    { label: 'View', name: 'view' },
    { label: 'Delete', name: 'delete' },
];

const COLUMNS = [
    { label: 'Tracking Number', fieldName: 'TrackingNumber', type: 'text' },
    { label: 'Customer Name', fieldName: 'CustomerName', type: 'text' },
    { label: 'Customer Type', fieldName: 'CustomerType', type: 'text' },
    { label: 'Case Type', fieldName: 'CaseType', type: 'text' },
    { label: 'Company Level', fieldName: 'CustomerPriority', type: 'text' },
    { label: 'Company Level', fieldName: 'ShipmentsThisMonth', type: 'number' },
    { label: 'Status', fieldName: 'Status', type: 'text' },
    {
        type: 'action',
        typeAttributes: { rowActions: ACTIONS },
    },
];

export default class ShippingStatusTracker extends LightningElement {
    searchKeyword = '';

    columns = COLUMNS;

    error;

    trackings;

    wiredTrackings;

    noRecords = false;
    //If no data -> noRecords = true -> button enabled
    //If data -> noRecords = false -> button disabled
    get disableButton() {
        return !this.noRecords;
    }

    changeHandler(event) {
        const searchKeyword = event.target.value;
        this.searchKeyword = searchKeyword;
    }

    handleSearch(event) {
        getAllTracking({ trackingNumber: this.searchKeyword })
            .then((data) => {
                if (data.length == 0) {
                    this.trackings = undefined;
                    this.noRecords = true;

                } else {
                    this.trackings = this.prepareData(data);
                    this.noRecords = false;
                }
                this.error = null;
            })
            .catch(error => {
                this.trackings = undefined;
                this.error = error;
                this.noRecords = true;
            });
    }

    handleRegister(event) {
        const customevent = new CustomEvent('create');
        this.dispatchEvent(customevent);
    }

    @wire(getTracking, { trackingNumber: '$searchKeyword' })
    wiredTracking(result) {
        this.wiredTrackings = result;
        const { data, error } = result;
        if (data) {
            if (data.length != 0) {
                this.trackings = this.prepareData(data);
                this.noRecords = false;
            } else {
                this.trackings = undefined;
                this.noRecords = true;
            }
            this.error = null;
        }
        if (error) {
            this.trackings = undefined;
            this.error = error;
            this.noRecords = true;
        }
    }

    prepareData(data) {
        let preparedData = [];
        data.forEach(row => {
            let preparedRow = {};
            preparedRow.Id = row.Id;
            preparedRow.TrackingNumber = row.trackingNumber;
            preparedRow.CustomerName = row.customerName;
            preparedRow.CustomerType = row.customerType;
            preparedRow.CaseType = row.caseType;
            preparedRow.CustomerPriority = row.customerPriority;
            preparedRow.ShipmentsThisMonth = row.shipmentsThisMonth;
            preparedRow.Status = row.status;
            preparedData.push(preparedRow);
        });
        return preparedData;
    }

    handleRowAction(event) {
        const actionName = event.detail.action.name;
        const row = event.detail.row;
        switch (actionName) {
            case 'edit':
                this.editRowDetails(row);
                break;
            case 'view':
                this.viewRowDetails(row);
                break;
            case 'delete':
                this.deleteRow(row);
                break;
            default:
        }
    }

    viewRowDetails(row) {
        const detail = { detail: { recordId: row.Id } };
        const customevent = new CustomEvent('view', detail);
        this.dispatchEvent(customevent);
    }

    editRowDetails(row) {
        const detail = { detail: { recordId: row.Id } };
        const customevent = new CustomEvent('edit', detail);
        this.dispatchEvent(customevent);
    }

    deleteRow(row) {
        deleteTrackingRecord({ recordId: row.Id })
            .then(() => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Deleted',
                        message: 'The record has been deleted',
                        variant: 'success'
                    }));
            })
            .catch(error => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error',
                        message: 'Record could not be deleted',
                        variant: 'error'
                    }));
            })
            .finally(() => {
                this.refreshDatatable();
            });
    }

    @api
    refreshDatatable() {
        refreshApex(this.wiredTrackings);
    }

}