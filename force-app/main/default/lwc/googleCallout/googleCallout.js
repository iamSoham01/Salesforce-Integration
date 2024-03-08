import { LightningElement } from 'lwc';
import GOOGLE_LOGO from '@salesforce/resourceUrl/google';
import CALENDAR_LOGO from '@salesforce/resourceUrl/googleCalendar';
import GMAIL_LOGO from '@salesforce/resourceUrl/gmail';
import DRIVE_LOGO from '@salesforce/resourceUrl/googleDrive';
import MAPS_LOGO from '@salesforce/resourceUrl/googleMaps';

export default class GoogleCallout extends LightningElement {

  resources = {
    googleLogo: GOOGLE_LOGO,
    calnedarLogo: CALENDAR_LOGO,
    gmailLogo: GMAIL_LOGO,
    driveLogo: DRIVE_LOGO,
    mapsLogo: MAPS_LOGO
  };

  isCalendar = true;
  isGmail = false;
  isMaps = false;
  isDrive = false;

  handleMenuBtn(event){
    this.isCalendar = event.target.dataset.name === 'Calendar';
    this.isGmail = event.target.dataset.name === 'Gmail';
    this.isMaps = event.target.dataset.name === 'Maps';
    this.isDrive = event.target.dataset.name === 'Drive';
  }

}