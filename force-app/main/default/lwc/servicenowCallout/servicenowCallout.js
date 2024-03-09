import { LightningElement, wire } from 'lwc';
import SERVICENOW_LOGO from '@salesforce/resourceUrl/servicenow';
import createIncident from '@salesforce/apex/ServicenowUtil.createIncident';
import getCallerInfo from '@salesforce/apex/ServicenowUtil.getCallerDetails';

export default class ServicenowCallout extends LightningElement {

  servicenowLogo = SERVICENOW_LOGO;
  incidentNumber;
  error;
  callerNames = [{ label: 'None', value: '' }];
  isCallerSelected = false;
  callerId;
  isLoaded = false;

  @wire(getCallerInfo) 
  servicenowCallerInfo({data, error}) {
    if(data){
      const options = Object.keys(data).map(key => ({
        label: key,
        value: data[key]
      }));
      this.callerNames = this.callerNames.concat(options);
    }else {
      this.error = JSON.stringify(error);
    }
  }

  handleSelectedCaller(){
    const selectedCaller = this.refs.caller;
    if(selectedCaller.value){
      this.callerId = selectedCaller.value;
      this.isCallerSelected = true;
    }else{
      this.isCallerSelected = false;
    }
  }

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
    
    this.isLoaded = !this.isLoaded;

    createIncident({callerId: this.callerId, description: message.value})
      .then(result => {
        this.incidentNumber = result;
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
        this.incidentNumber = ``;
      })
      .finally(() => {
        this.isLoaded = !this.isLoaded;
      });
  }

}