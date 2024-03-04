import { LightningElement } from 'lwc';
import createPost from '@salesforce/apex/LinkedinUtil.createPost';


export default class LinkedinCallout extends LightningElement {

  error;
  message;
  profileId;

  checkFieldValidity(inputType, errorMsg) {

    if (!inputType.value) {
      inputType.setCustomValidity(`Please enter ${errorMsg}`);
    } else {
      inputType.setCustomValidity(``);
    }
    return inputType.reportValidity();
  }

  handleSendPost() {

    const msg = this.refs.msg;
    const linkedInVersion = this.refs.linkedInVersion;

    const checkMsgValid = this.checkFieldValidity(msg, `your Message`);
    const checkLinkedinVersionValid = this.checkFieldValidity(linkedInVersion, `linkedin version`);

    if(!checkMsgValid || !checkLinkedinVersionValid){
      return;
    }
    
    createPost({ msg: msg.value, linkedinVersion: linkedInVersion.value})
      .then((result) => {
        this.error = ``;
        msg.value = ``;
        linkedInVersion.value = ``;
        this.message = result;
      })
      .catch((error) => {
        this.error = error.message;
        this.message = ``;
      });

  }

}