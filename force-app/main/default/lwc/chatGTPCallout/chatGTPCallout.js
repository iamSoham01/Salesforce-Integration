import { LightningElement } from 'lwc';
import getResponseMsg from '@salesforce/apex/ChatGTPUtil.getResponseMsg';
import CHATGTP_LOGO from '@salesforce/resourceUrl/chatgtp';

export default class ChatGTPCallout extends LightningElement {

  chatGTPLogo = CHATGTP_LOGO;
  responseMsg;
  error;
  isLoaded = false;

  checkFieldValidity(inputType) {

    if (!inputType.value) {
      inputType.setCustomValidity(`Please enter your prompt`);
    } else {
      inputType.setCustomValidity(``);
    }
    return inputType.reportValidity();
  }

  isJSONString(str) {
    return typeof str === 'string' && str.trim().startsWith('{') && str.trim().endsWith('}');
  }  

  handleAskQuestion() {
    
    const question = this.refs.question;
    const isQuestionValid = this.checkFieldValidity(question);

    if(!isQuestionValid){
      return;
    }
    
    this.isLoaded = !this.isLoaded;

    getResponseMsg({message: question.value})
      .then(result => {
        this.responseMsg = result;
        this.error = ``;
      })
      .catch((error) => {
        const err = error.body.message;
        if(this.isJSONString(err)){
          this.error = JSON.parse(err).error.message;
        }else{
          this.error = err;
        }
        this.responseMsg = ``;
      })
      .finally(() => {
        this.isLoaded = !this.isLoaded;
      });
  }

}