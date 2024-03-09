import { LightningElement } from 'lwc';
import SPOTIFY_LOGO from '@salesforce/resourceUrl/spotify';
import getSongInformations from "@salesforce/apex/SpotifyUtil.getSongInformations";

export default class SpotifyCallout extends LightningElement {

  spotifyLogo = SPOTIFY_LOGO;
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