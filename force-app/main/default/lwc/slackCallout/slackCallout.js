import { LightningElement, wire } from 'lwc';
import SLACK_LOGO from '@salesforce/resourceUrl/slack';
import getAllChannels from '@salesforce/apex/SlackUtil.getAllChannels';
import postMessage from '@salesforce/apex/SlackUtil.postMessage';
import deleteMessage from '@salesforce/apex/SlackUtil.deleteMessage';

export default class SlackCallout extends LightningElement {

  slackLogo = SLACK_LOGO;
  isLoaded = false;
  allChannels = [{ label: 'None', value: '' }];
  error;
  postResponse = ``;
  deleteResponse = ``;

  @wire(getAllChannels) 
  servicenowCallerInfo({data, error}) {
    if(data){
      const options = Object.keys(data).map(key => ({
        label: key,
        value: data[key]
      }));
      this.allChannels = this.allChannels.concat(options);
    }else {
      this.error = JSON.stringify(error);
    }
    this.isLoaded = !this.isLoaded;
  }

  checkFieldValidity(inputType, errorMsg) {

    if (!inputType.value) {
      inputType.setCustomValidity(`Please  ${errorMsg}`);
    } else {
      inputType.setCustomValidity(``);
    }
    return inputType.reportValidity();
  }

  handleSendMsg(){

    const channelId = this.refs.channelId;
    console.log(`channelId: `, channelId.value);
    const msg = this.refs.msg;

    const isChannelIdValid = this.checkFieldValidity(channelId, `select your channel`);
    const isMsgValid = this.checkFieldValidity(msg, `enter your message`);

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