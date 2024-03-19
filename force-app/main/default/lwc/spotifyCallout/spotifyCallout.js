import { LightningElement } from 'lwc';
import SPOTIFY_LOGO from '@salesforce/resourceUrl/spotify';
import searchTracks from '@salesforce/apex/SpotifyUtil.searchTracks';
import getSongInformations from "@salesforce/apex/SpotifyUtil.getSongInformations";
import startPlayback from "@salesforce/apex/SpotifyUtil.startPlayback";
import pausePlayback from "@salesforce/apex/SpotifyUtil.pausePlayback";

export default class SpotifyCallout extends LightningElement {

  spotifyLogo = SPOTIFY_LOGO;
  isLoaded = false;
  searchResults = [];
  error; 
  song;
  togglePlayPauseIcon;
  currentTrackURI;

  connectedCallback() {
    this.currentPlayingTrack();
    setInterval(() => {
      this.currentPlayingTrack();
    }, 10000);
  }

  handleTrackName(event) {
    const searchTerm = event.target.value;
    if (searchTerm.length > 2) { 
        this.searchSpotify(searchTerm);
    }
  }

  searchSpotify(searchTerm) {
    searchTracks({ trackName: searchTerm })
      .then((result) => {
        this.searchResults = result;
        // console.log(`result: `,JSON.stringify(result));
      })
      .catch((error) => {
        console.error(error);
        this.error = error;
        this.searchResults = [];
      });
  }

  handlePlayClick(event) {
    
    const selectedSongURI = event.target.dataset.uri;
    this.modifyPlaylistIcons(selectedSongURI);

  }

  modifyPlaylistIcons(selectedSongURI){

    const lightningIcons = this.template.querySelectorAll(`.play-icon`);

    if (lightningIcons) {
      lightningIcons.forEach(icon => {
        if (icon.dataset.uri === selectedSongURI) {
          if(icon.iconName === 'utility:pause'){
            this.pauseTrack();
            icon.iconName = 'utility:play';
          }else {
            this.startTrack(selectedSongURI);
            icon.iconName = 'utility:pause';
          }
        } else if (icon.iconName === 'utility:pause') {
            icon.iconName = 'utility:play';
        }
        icon.size = 'x-small';
      });
    }

  }

  currentPlayingTrack() {
    getSongInformations() 
      .then((result) => {
        this.song = result;
        this.currentTrackURI = result.trackURI;
        this.togglePlayPauseIcon = result.isPlaying === 'true' ? 'utility:pause' : 'utility:play';
        console.log(`Song: `,result);
      })
      .catch((error) => {
        console.error(error);
        this.error = error; 
      });
  }

  startTrack(selectedSongURI) {
    startPlayback({ trackURI: selectedSongURI })
      .then((result) => {
        this.currentPlayingTrack();
      })
      .catch((error) => {
        console.error(error);
        this.error = error;
      });
  }

  pauseTrack() {
    pausePlayback()
      .then((result) => {
      })
      .catch((error) => {
        console.error(error);
        this.error = error;
      });
  }

  handlePlayPause(){

    this.togglePlayPauseIcon = (this.togglePlayPauseIcon === `utility:play`) ? 'utility:pause' : 'utility:play';
    if(this.togglePlayPauseIcon === 'utility:play'){
      this.pauseTrack();
      this.modifyPlaylistIcons(this.currentTrackURI);
    }else{
      this.startTrack(this.currentTrackURI);
    }

  }

}