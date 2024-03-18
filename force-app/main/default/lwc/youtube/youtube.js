import { LightningElement, track } from 'lwc';
import searchYoutubeVideos from '@salesforce/apex/GoogleUtil.searchYoutubeVideos';

export default class Youtube extends LightningElement {

  isLoaded = false;
  @track searchedVideos = [];
  selectedYoutubeURL = false;

  checkFieldValidity(inputType) {

    if (!inputType.value) {
      inputType.setCustomValidity(`Please enter your query`);
    } else {
      inputType.setCustomValidity(``);
    }
    return inputType.reportValidity();
  }

  // Search handler
  handleSearch(){

    const searchQuery = this.refs.searchQuery;
    const isSearchQueryValid = this.checkFieldValidity(searchQuery);

    if(!isSearchQueryValid){
      return;
    }

    this.isLoaded = !this.isLoaded;

    //Passing search string to apex
    searchYoutubeVideos({searchQuery: searchQuery.value})
      .then((result) => {
        console.log(`result: `,result);
        this.searchedVideos = result;
        this.error = ``;
      })
      .catch((error) => {
        this.error = error.message;
        this.searchedVideos = [];
        this.selectedYoutubeURL = false;
      })
      .finally(() => {
        this.isLoaded = !this.isLoaded;
      });

  }

  handlePlayClick(event){
    //Assign selected youtube url 
    this.selectedYoutubeURL = 'https://www.youtube.com/embed/' + event.target.dataset.url;
  }

}