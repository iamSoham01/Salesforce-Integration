import { LightningElement } from 'lwc';
import getResponseMsg from '@salesforce/apex/ChatGTPUtil.getResponseMsg';

export default class ChatGTPCallout extends LightningElement {

  responseMsg;
  error;

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
      });
  }

}