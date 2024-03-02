import { LightningElement } from 'lwc';

export default class OpenCageData extends LightningElement {

  isForwardGeoCoding = true;

  handleGeoCodingType(event){
    if(event.target.label === `Forward GeoCoding`) {
      this.isForwardGeoCoding = true ;
    }else {
      this.isForwardGeoCoding = false;
    }
  }

}