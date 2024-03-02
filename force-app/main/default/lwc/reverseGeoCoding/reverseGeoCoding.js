import { LightningElement } from 'lwc';
import reverseGeoCoding from '@salesforce/apex/OpenCageUtil.reverseGeoCoding';

export default class ReverseGeoCoding extends LightningElement {
  
  address;
  error;

  checkFieldValidity(inputType, msg) {

    if (!inputType.value) {
      inputType.setCustomValidity(`Please Enter a valid ${msg}`);
    } else {
      inputType.setCustomValidity(``);
    }
    return inputType.reportValidity();
  }

  isJSONString(str) {
    return typeof str === 'string' && str.trim().startsWith('{') && str.trim().endsWith('}');
  }

  handleAddress() {

    const lat = this.refs.lat;
    const lng = this.refs.lng;

    const latValid = this.checkFieldValidity(lat, `Latitude`);
    const lngValid = this.checkFieldValidity(lng, `Longitude`);

    if(!latValid || !lngValid){
      return;
    }

    reverseGeoCoding({ lat: lat.value, lng: lng.value })
      .then((result) => {
        this.address = result;
        this.error = ``;
      })
      .catch((error) => {
        const err = error.body.message;
        if(this.isJSONString(err)){
          this.error = JSON.parse(err).status.message;
        }else{
          this.error = err;
        }
        this.address = ``;
      });
    }
}