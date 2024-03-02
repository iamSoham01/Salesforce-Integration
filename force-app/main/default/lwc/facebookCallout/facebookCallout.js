import { LightningElement, wire } from 'lwc';
import getPageInfo from '@salesforce/apex/FacebookUtil.getPageInfo';
import postFeedMessage from '@salesforce/apex/FacebookUtil.postFeedMessage';

export default class FacebookCallout extends LightningElement {

  isPageSelected;
  facebookPageNames = [{ label: 'None', value: '' }];
  error;
  successResponse;
  selectedPageInfo;

  @wire(getPageInfo) 
  facebookPages({data, error}) {
    if(data){
      const options = Object.keys(data).map(key => ({
        label: key,
        value: data[key]
      }));
      this.facebookPageNames = this.facebookPageNames.concat(options);
    }else {
      this.error = error;
    }
  }

  handleSelectedPage(){
    const selectedPage = this.refs.pageName;
    if(selectedPage.value){
      this.selectedPageInfo = selectedPage.value;
      this.isPageSelected = true;
    }else{
      this.isPageSelected = false;
    }
  }

  checkFieldValidity(inputType, errorMsg) {

    if (!inputType.value) {
      inputType.setCustomValidity(`Please enter ${errorMsg}`);
    } else {
      inputType.setCustomValidity(``);
    }
    return inputType.reportValidity();
  }

  handlePost(){

    const msg = this.refs.msg;
    const isMsgValid = this.checkFieldValidity(msg, `your message`);
    if(!isMsgValid){
      return;
    }

    const facbookPageId = this.selectedPageInfo.split(`:`)[0];
    const facbookPageToken = this.selectedPageInfo.split(`:`)[1];

    postFeedMessage({pageId: facbookPageId, access_token: facbookPageToken, message: msg.value})
    .then((result) => {
      this.error = ``;
      msg.value = ``;
      this.selectedPageInfo = ``;
      this.successResponse = `Your message has been posted successfully with Id: ${result}`;
    })
    .catch((error) => {
      this.error = error.message;
      this.successResponse = ``;
    });

  }


}