import { LightningElement,api,wire, track } from 'lwc';
import getAllTracks from '@salesforce/apex/TrackingLocationController.getAllTracks';
export default class TrackLocation extends LightningElement {
    @api recordId;
    @api value;
    name;
    mapMarkers = [];
    @wire(getAllTracks, {search:'$value'})
    loadShippemnt({error, data}){
        console.log(data);
        if(error){

        }else if (data){
            let tempMarkers = [];
            data.forEach((info)=>{
                let marker = {
                    location:{
                        Latitude: info.Location__Latitude__s,
                        Longitude: info.Location__Longitude__s
                    },
                    title: info.Name,
                    description: '',
                    icon:'utility:salesforce1'
                }
                tempMarkers.push(marker);
            });
       ;
            this.mapMarkers = tempMarkers;
        }
    }
    get cardTitle(){
        return (this.name) ? `${this.name}'s location` : 'Tracking location';
    }
}