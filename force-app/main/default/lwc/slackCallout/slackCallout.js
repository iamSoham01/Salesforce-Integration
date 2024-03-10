import { LightningElement } from 'lwc';
import SLACK_LOGO from '@salesforce/resourceUrl/slack';
import postMessage from '@salesforce/apex/SlackUtil.postMessage';
import deleteMessage from '@salesforce/apex/SlackUtil.deleteMessage';

export default class SlackCallout extends LightningElement {

  slackLogo = SLACK_LOGO;
  isLoaded = false;
  error;
  message;

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
      this.message = result;
    })
    .catch((error) => {
      this.error = error.message;
      this.message = ``;
    })
    .finally(() => {
      this.isLoaded = !this.isLoaded;
    });

  }

  handleDeleteMsg() {

    const channelId = this.refs.channelId;
    const isChannelIdValid = this.checkFieldValidity(channelId, `channel id`);

    if(!isChannelIdValid || !this.message){
      return;
    }

    this.isLoaded = !this.isLoaded;

    deleteMessage({ timeStamp: this.message, channelId: channelId.value})
      .then((result) => {
        this.error = ``;
        this.message = result;
      })
      .catch((error) => {
        this.error = error.message;
        this.message = ``;
      })
      .finally(() => {
        this.isLoaded = !this.isLoaded;
      });

  }

}