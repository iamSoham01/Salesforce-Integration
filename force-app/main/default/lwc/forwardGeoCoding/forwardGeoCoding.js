import { LightningElement } from 'lwc';
import forwardGeoCoding from '@salesforce/apex/OpenCageUtil.forwardGeoCoding';

export default class ForwardGeoCoding extends LightningElement {

  lat;
  lng;
  error;

  checkFieldValidity(inputType) {

    if (!inputType.value) {
      inputType.setCustomValidity(`Please Enter a valid address`);
    } else {
      inputType.setCustomValidity(``);
    }
    return inputType.reportValidity();
  }

  isJSONString(str) {
    return typeof str === 'string' && str.trim().startsWith('{') && str.trim().endsWith('}');
  }

  handleCoordinate() {

    const address = this.refs.address;
    const addressValid = this.checkFieldValidity(address);

    if(!addressValid){
      return;
    }
    
    forwardGeoCoding({ address: address.value })
      .then((result) => {
        const coordinate = result;
        this.lat = coordinate.lat;
        this.lng = coordinate.lng;
        this.error = ``;
      })
      .catch((error) => {
        const err = error.body.message;
        if(this.isJSONString(err)){
          this.error = JSON.parse(err).status.message;
        }else{
          this.error = err;
        }
        this.lat = ``;
        this.lng = ``;
      });

  }

}