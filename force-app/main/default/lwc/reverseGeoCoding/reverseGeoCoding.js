import { LightningElement } from 'lwc';
import reverseGeoCoding from '@salesforce/apex/OpenCageUtil.reverseGeoCoding';

export default class ReverseGeoCoding extends LightningElement {
  
  address;
  error;
  isLoaded = false;

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

  sendMapCoordinates(latitude, longitude){
    const mapEvt = new CustomEvent('mapcoordinates', {
      detail: { 
        lat: latitude,
        lng: longitude 
      }
    });
    this.dispatchEvent(mapEvt);
  }

  handleAddress() {

    const lat = this.refs.lat;
    const lng = this.refs.lng;

    const latValid = this.checkFieldValidity(lat, `Latitude`);
    const lngValid = this.checkFieldValidity(lng, `Longitude`);

    if(!latValid || !lngValid){
      return;
    }

    this.isLoaded = !this.isLoaded;

    reverseGeoCoding({ lat: lat.value, lng: lng.value })
      .then((result) => {
        this.address = result;
        this.error = ``;
        this.sendMapCoordinates(lat.value, lng.value);
      })
      .catch((error) => {
        const err = error.body.message;
        if(this.isJSONString(err)){
          this.error = JSON.parse(err).status.message;
        }else{
          this.error = err;
        }
        this.address = ``;
      })
      .finally(() => {
        this.isLoaded = !this.isLoaded;
      });
  }
}