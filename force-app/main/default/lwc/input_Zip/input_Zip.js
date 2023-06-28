import { LightningElement, api, track } from 'lwc';

import getCountryZipCode from '@salesforce/apex/Get_Country_ZipCode.getCountryZipCode';
import successModal from "c/success_Zip";

export default class Input_Zip extends LightningElement{
    @api zipC;
    @track disabledSubmit = true;

    connectedCallback(){
        console.log('ConnectedCallback.....');
    }

    assignValue(event){
        this.zipC = event.target.value;
        this.disabledSubmit = !(/^\d{5}(-\d{4})?$/.test(this.zipC));
        console.log('Value Assigned -----> ' + this.disabledSubmit);
        console.log('Disabled -----> ' + this.zipC);
    }

    makeCallout(){
        console.log('Zip Code --> ' + this.zipC);
        getCountryZipCode({ zipCode: this.zipC })
        .then(res => {
            console.log("Country code --> "  + res);
            console.log(res);
            this.handleClick(res);
        }).catch(error => {
            console.log('Error... ');
            console.log(error);
        }).finally(() => {  
            this.isShowModal = false; 
        });
    }

    async handleClick(wsResM){
        console.log(wsResM);
        const result = await successModal.open({
            size: 'small',
            description: 'Web Service response',
            country: wsResM.Country,
            resBody: JSON.stringify(wsResM.Result),
        });
        // if modal closed with X button, promise returns result = 'undefined'
        // if modal closed with OK button, promise returns result = 'okay'
        console.log(result);
    }
}