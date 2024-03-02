import { LightningElement } from 'lwc';
import getSongInformations from "@salesforce/apex/SpotifyUtil.getSongInformations";

export default class SpotifyCallout extends LightningElement {

  error; 
  song; 

  callSpotifyAPI() {
    getSongInformations() 
      .then((result) => {
        this.song = result;
      })
      .catch((error) => {
        this.error = error; 
      });
  }

  //When the page loads, we call Spotify API for the first time. After it, we call it again, but now it's every 30000ms(ie every 30s)
  connectedCallback() {
    this.callSpotifyAPI();
    setInterval(() => {
      this.callSpotifyAPI();
    }, 30000);
  }

}