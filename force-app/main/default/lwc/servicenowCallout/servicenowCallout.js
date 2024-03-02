import { LightningElement } from 'lwc';
import createIncident from '@salesforce/apex/ServicenowUtil.createIncident';

export default class ServicenowCallout extends LightningElement {

  responseMsg;
  error;

  checkFieldValidity(inputType) {

    if (!inputType.value) {
      inputType.setCustomValidity(`Please enter your message`);
    } else {
      inputType.setCustomValidity(``);
    }
    return inputType.reportValidity();
  }

  isJSONString(str) {
    return typeof str === 'string' && str.trim().startsWith('{') && str.trim().endsWith('}');
  }  

  handleIncident() {
    
    const message = this.refs.message;
    const isMessageValid = this.checkFieldValidity(message);

    if(!isMessageValid){
      return;
    }

    createIncident({description: message.value})
      .then(result => {
        this.responseMsg = result;
        this.error = ``;
        message.value = ``;
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