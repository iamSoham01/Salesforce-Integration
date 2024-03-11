import { LightningElement } from 'lwc';
import SLACK_LOGO from '@salesforce/resourceUrl/slack';
import postMessage from '@salesforce/apex/SlackUtil.postMessage';
import deleteMessage from '@salesforce/apex/SlackUtil.deleteMessage';

export default class SlackCallout extends LightningElement {

  slackLogo = SLACK_LOGO;
  isLoaded = false;
  error;
  postResponse = ``;
  deleteResponse = ``;

  checkFieldValidity(inputType, errorMsg) {

    if (!inputType.value) {
      inputType.setCustomValidity(`Please enter ${errorMsg}`);
    } else {
      inputType.setCustomValidity(``);
    }
    return inputType.reportValidity();
  }

  handleSendMsg(){

    const channelId = this.refs.channelId;
    const msg = this.refs.msg;

    const isChannelIdValid = this.checkFieldValidity(channelId, `channel id`);
    const isMsgValid = this.checkFieldValidity(msg, `your message`);

    if(!isChannelIdValid || !isMsgValid){
      return;
    }

    this.isLoaded = !this.isLoaded;

    postMessage({ message: msg.value, channelId: channelId.value})
    .then((result) => {
      this.error = ``;
      msg.value = ``;
      this.postResponse = result;
    })
    .catch((error) => {
      this.error = error.message;
      this.postResponse = ``;
    })
    .finally(() => {
      this.isLoaded = !this.isLoaded;
      this.deleteResponse = ``;
    });

  }

  handleDeleteMsg() {

    const channelId = this.refs.channelId;
    const isChannelIdValid = this.checkFieldValidity(channelId, `channel id`);

    if(!isChannelIdValid || !this.postResponse){
      return;
    }

    this.isLoaded = !this.isLoaded;

    deleteMessage({ timeStamp: this.postResponse, channelId: channelId.value})
      .then((result) => {
        this.error = ``;
        this.deleteResponse = result;
      })
      .catch((error) => {
        this.error = error.message;
        this.deleteResponse = ``;
      })
      .finally(() => {
        this.isLoaded = !this.isLoaded;
        this.postResponse = ``;
      });

  }

}