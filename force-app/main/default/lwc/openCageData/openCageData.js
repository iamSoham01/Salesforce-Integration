import { LightningElement } from 'lwc';
import OPENCAGE_LOGO from '@salesforce/resourceUrl/opencage';

export default class OpenCageData extends LightningElement {

  opencageLogo = OPENCAGE_LOGO;
  isForwardGeoCoding = true;
  forwardGeocodingBtnVariant = 'brand';;
  reverseGeocodingBtnVariant = 'brand-outline';
  
  handleGeoCodingType(event){
    this.isForwardGeoCoding = event.target.label === 'Forward GeoCoding';
    this.forwardGeocodingBtnVariant = this.isForwardGeoCoding ? 'brand' : 'brand-outline';
    this.reverseGeocodingBtnVariant = this.isForwardGeoCoding ? 'brand-outline' : 'brand';
  }

}