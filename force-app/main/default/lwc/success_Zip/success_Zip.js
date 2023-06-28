import { api, track } from "lwc";
import LightningModal from "lightning/modal";

export default class success_Zip extends LightningModal{
    @api country;
    @api resBody;

    connectedCallback(){
        console.log('ConnectedCallback modal.....');
    }

    handleOptionClick(e) {
        const { target } = e;
        const { id } = target.dataset;
        this.close(id);
    }
}