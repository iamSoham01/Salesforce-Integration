import { LightningElement } from 'lwc';
import OPENCAGE_LOGO from '@salesforce/resourceUrl/opencage';

export default class OpenCageData extends LightningElement {

  opencageLogo = OPENCAGE_LOGO;
  isForwardGeoCoding = true;
  forwardGeocodingBtnVariant = 'brand';;
  reverseGeocodingBtnVariant = 'brand-outline';
  isMapVisible = false;
  mapMarkers = [];
  
  handleGeoCodingType(event){
    this.isMapVisible = false;
    this.isForwardGeoCoding = event.target.label === 'Forward GeoCoding';
    this.forwardGeocodingBtnVariant = this.isForwardGeoCoding ? 'brand' : 'brand-outline';
    this.reverseGeocodingBtnVariant = this.isForwardGeoCoding ? 'brand-outline' : 'brand';
  }

  handleMapCoordinates(event){
    this.isMapVisible = true;
    const lat = event.detail.lat;
    const lng = event.detail.lng;
    this.mapMarkers = [
      {
          location: {
              Latitude: lat,
              Longitude: lng,
          },
      },
    ];
  }

}