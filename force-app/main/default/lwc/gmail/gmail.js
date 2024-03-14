import { LightningElement, track } from 'lwc';
import sendEmail from '@salesforce/apex/GoogleUtil.sendEmail';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
const MAX_FILE_SIZE = 2097152;

export default class Gmail extends LightningElement {

  isLoaded = false;
  error;
  responseMsg;
  @track filesData = [];

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

  showToast(title, variant, message) {
    this.dispatchEvent(
        new ShowToastEvent({
            title: title,
            variant: variant,
            message: message,
        })
    );
  }

  handleFileUpload(event) {

    for (const file of event.target.files) {
      if (file.size > MAX_FILE_SIZE) {
          this.showToast('Error!', 'error', 'File size exceeded the upload size limit.');
          return;
      }
      const reader = new FileReader();
      reader.onload = () => {
          const fileContents = reader.result.split(',')[1];
          this.filesData.push({ fileName: file.name, fileContent: fileContents, fileType: file.type.split("/")[1] });
      };
      reader.readAsDataURL(file);
    }
  }

  removeReceiptImage(event) {
    var index = event.currentTarget.dataset.id;
    this.filesData.splice(index, 1);
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
      filesData: this.filesData,
    };

    sendEmail({mapAttributes: mapAttributes})
      .then((result) => {
        this.responseMsg = result;
        this.error = ``;
        emailSubject.value = ``;
        emailDescription.value = ``;
        receiverAddress.value = ``;
        this.filesData = [];
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