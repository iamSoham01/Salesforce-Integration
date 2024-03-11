import { LightningElement } from 'lwc';
import sendEmail from '@salesforce/apex/GoogleUtil.sendEmail';

export default class Gmail extends LightningElement {

  isLoaded = false;
  error;
  responseMsg;
  fileName;
  fileContents;

  isValidEmail(inputType) {
    // Email validation regex
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

    if (!emailRegex.test(inputType.value)) {
      inputType.setCustomValidity(`Please enter a valid email`);
    } else {
      inputType.setCustomValidity(``);
    }
    return inputType.reportValidity();
  }

  checkFieldValidity(inputType, errorMsg) {

    if (!inputType.value) {
      inputType.setCustomValidity(`Please enter ${errorMsg}`);
    } else {
      inputType.setCustomValidity(``);
    }
    return inputType.reportValidity();
  }

  handleFileUpload(event) {
    const file = event.target.files[0];
    if (file) {
      this.fileName = file.name;
      const reader = new FileReader();
      reader.onload = this.handleFileReaderOnLoad.bind(this);
      reader.readAsDataURL(file);
    }
  }

  handleFileReaderOnLoad(event) {
      const base64 = event.target.result;
      const base64Parts = base64.split(',');
      this.fileContents = base64Parts[1];
  }

  handleSendEmail() {

    const emailSubject = this.refs.emailSubject;
    const emailDescription = this.refs.emailDescription;
    const receiverAddress = this.refs.receiverAddress;

    const isEmailSubValid = this.checkFieldValidity(emailSubject, `email subject`);
    const isEmailDescValid = this.checkFieldValidity(emailDescription, `email description`);
    const isReceiverAddressValid = this.checkFieldValidity(receiverAddress, `receiver email`);
    const isReceiverEmailValid = this.isValidEmail(receiverAddress);

    if(!isEmailSubValid || !isEmailDescValid || !isReceiverAddressValid || !isReceiverEmailValid){
      return;
    }

    this.isLoaded = !this.isLoaded;

    let mapAttributes = {
      receiverEmail: receiverAddress.value,
      emailSubject: emailSubject.value,
      emailBody: emailDescription.value,
      fileContents: this.fileContents,
      fileName: this.fileName
    };

    sendEmail({mapAttributes: mapAttributes})
      .then((result) => {
        console.log(`Result: `,result);
        this.responseMsg = result;
        this.error = ``;
        emailSubject.value = ``;
        emailDescription.value = ``;
        receiverAddress.value = ``;
        this.fileContents = ``;
        this.fileName = '';
      })
      .catch((error) => {
        this.error = error.message;
        this.responseMsg = ``;
      })
      .finally(() => {
        this.isLoaded = !this.isLoaded;
      });

  }

}