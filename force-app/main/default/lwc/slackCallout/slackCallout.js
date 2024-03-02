import { LightningElement } from 'lwc';
import postMessage from '@salesforce/apex/SlackUtil.postMessage';
import deleteMessage from '@salesforce/apex/SlackUtil.deleteMessage';

export default class SlackCallout extends LightningElement {

  isPostMsg = true;
  error;
  message;

  handleMessage(event){
    this.isPostMsg = event.target.label === 'Post Message';
  }

  get btnLabel(){
    return this.isPostMsg ? `Send` : `Delete`;
  }

  checkFieldValidity(inputType, errorMsg) {

    if (!inputType.value) {
      inputType.setCustomValidity(`Please enter ${errorMsg}`);
    } else {
      inputType.setCustomValidity(``);
    }
    return inputType.reportValidity();
  }

  handleBtn(){

    const channelId = this.refs.channelId;
    const msg = this.refs.msg;
    const ts = this.refs.ts;

    const isChannelIdValid = this.checkFieldValidity(channelId, `channel id`);

    if(this.isPostMsg){
      
      const isMsgValid = this.checkFieldValidity(msg, `your message`);

      if(!isChannelIdValid || !isMsgValid){
        return;
      }

      postMessage({ message: msg.value, channelId: channelId.value})
      .then((result) => {
        this.error = ``;
        msg.value = ``;
        channelId.value = ``;
        this.message = result;
      })
      .catch((error) => {
        this.error = error.message;
        this.message = ``;
      });

    }else {

      const isTsValid = this.checkFieldValidity(ts, `time stamp`);

      if(!isChannelIdValid || !isTsValid){
        return;
      }

      deleteMessage({ timeStamp: ts.value, channelId: channelId.value})
      .then((result) => {
        this.error = ``;
        ts.value = ``;
        channelId.value = ``;
        this.message = result;
      })
      .catch((error) => {
        this.error = error.message;
        this.message = ``;
      });

    }

  }

}