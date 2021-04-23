import {
    LightningElement,
    track,
    wire,
    api
} from 'lwc';
import {
    ShowToastEvent
} from 'lightning/platformShowToastEvent';
import getContactByEmail from '@salesforce/apex/ContactController.getContactByEmail';
export default class Webtocase extends LightningElement {
    @track searchOptions = [];
    @track value = '';
    @track values = '';
    @track email;
    @track contactToEmail = '';
    @track record;
    @track recordId;
    @api objectApiName;
    @track typeOfCase;
    @track aboutInfoToUpdate = [];
    isLoading = false;

    get options() {
        return [{
                label: this.labels.businessAccount,
                value: this.labels.businessAccount
            },
            {
                label: this.labels.personAccount,
                value: this.labels.personAccount
            }
        ];
    }

    @wire(getContactByEmail, {
        email: '$email'
    })

    wiredContact({
        error,
        data
    }) {
        if (data) {
            this.record = JSON.parse(JSON.stringify(data));
            this.contactToEmail = this.record.Name;
            this.recordId = this.record.AccountId;
            this.value = this.record.Account.RecordTypeId;
            if (this.value == this.labels.personAccount) {
                this.searchOptions = [{
                        label: this.labels.changeInfo,
                        value: this.labels.changeInfo
                    },
                    {
                        label: this.labels.incident,
                        value: this.labels.incident
                    }
                ];
                let toastEvent2 = new ShowToastEvent({
                    title: 'Success',
                    message: 'Review your contact info',
                    variant: 'success'
                });

                this.dispatchEvent(toastEvent2);
            } else if (this.value == this.labels.businessAccount) {
                this.searchOptions = [{
                        label: this.labels.changeInfo,
                        value: this.labels.changeInfo
                    },
                    {
                        label: this.labels.incident,
                        value: this.labels.incident
                    },
                    {
                        label: this.labels.inquiry,
                        value: this.labels.inquiry
                    }
                ];
                let toastEvent2 = new ShowToastEvent({
                    title: 'Success',
                    message: 'Review your contact info',
                    variant: 'success'
                });

                this.dispatchEvent(toastEvent2);
            }

        } else if (error) {

        }
    }

    handleChangeEmail(event) {
        this.email = event.detail.value;
    }

    handleChanges(event) {
        this.values = event.detail.value;
        console.log(this.values);
        if (this.values === 'Change Information') {
            this.aboutInfoToUpdate = [{
                    label: this.labels.changeAddress,
                    value: this.labels.changeAddress
                },
                {
                    label: this.labels.changeContact,
                    value: this.labels.changeContact
                },
                {
                    label: this.labels.other,
                    value: this.labels.other

                }
            ];
        } else if (this.values === 'Incident') {
            this.aboutInfoToUpdate = [{
                    label: this.labels.packageDamaged,
                    value: this.labels.packageDamaged
                },
                {
                    label: this.labels.stolenPackage,
                    value: this.labels.stolenPackage
                },
                {
                    label: this.labels.other,
                    value: this.labels.other

                }
            ];
        } else if (this.values === 'Inquiry') {
            this.aboutInfoToUpdate = [{
                    label: this.labels.aboutDeliveryTimes,
                    value: this.labels.aboutDeliveryTimes
                },
                {
                    label: this.labels.aboutShipment,
                    value: this.labels.aboutShipment
                },
                {
                    label: this.labels.aboutShipmentLocation,
                    value: this.labels.aboutShipmentLocation

                },
                {
                    label: this.labels.aboutUniversal,
                    value: this.labels.aboutUniversal

                },
                {
                    label: this.labels.question,
                    value: this.labels.question

                },
                {
                    label: this.labels.other,
                    value: this.labels.other

                }
            ];
        }
    }

    handleType(event) {
        this.typeOfCase = event.detail.value;

    }
    fireEvent() {

        let toastEvent = new ShowToastEvent({
            title: 'Saved',
            message: 'A agent will start working on your case.',
            variant: 'success'
        });
        this.isLoading = false;
        this.dispatchEvent(toastEvent);

    }


    labels = {
        businessAccount: '0125e0000000NGlAAM',
        personAccount: '0125e0000000NPnAAM',
        changeInfo: 'Change Information',
        incident: 'Incident',
        inquiry: 'Inquiry',
        aboutDeliveryTimes: 'About delivery times',
        aboutShipment: 'About shipment confirmation emails',
        aboutShipmentLocation: 'About shipment&#39;s current location',
        aboutUniversal: 'Information about Universal Logistics',
        question: 'Question',
        packageDamaged: 'Package was delivered damaged',
        stolenPackage: 'Package was never delivered or was stolen',
        changeAddress: 'Change delivery address',
        changeContact: 'Change contact information',
        other: 'Other'


    }
}