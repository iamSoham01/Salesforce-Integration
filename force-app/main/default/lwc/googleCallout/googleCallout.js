import { LightningElement } from 'lwc';
import GOOGLE_LOGO from '@salesforce/resourceUrl/google';
import CALENDAR_LOGO from '@salesforce/resourceUrl/googleCalendar';
import GMAIL_LOGO from '@salesforce/resourceUrl/gmail';
import DRIVE_LOGO from '@salesforce/resourceUrl/googleDrive';
import YOUTUBE_LOGO from '@salesforce/resourceUrl/youtube';

export default class GoogleCallout extends LightningElement {

  resources = {
    googleLogo: GOOGLE_LOGO,
    calnedarLogo: CALENDAR_LOGO,
    gmailLogo: GMAIL_LOGO,
    driveLogo: DRIVE_LOGO,
    youtubeLogo: YOUTUBE_LOGO
  };

  isCalendar = true;
  isGmail = false;
  isYoutube = false;
  isDrive = false;

  handleMenuBtn(event){
    this.isCalendar = event.target.dataset.name === 'Calendar';
    this.isGmail = event.target.dataset.name === 'Gmail';
    this.isYoutube = event.target.dataset.name === 'Youtube';
    this.isDrive = event.target.dataset.name === 'Drive';
  }

}