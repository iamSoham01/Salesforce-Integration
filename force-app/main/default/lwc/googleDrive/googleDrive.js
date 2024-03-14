import { LightningElement } from 'lwc';
import uploadFiles from '@salesforce/apex/GoogleUtil.uploadFiles';
import deleteFiles from '@salesforce/apex/GoogleUtil.deleteFiles';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
const MAX_FILE_SIZE = 2097152;

export default class GoogleDrive extends LightningElement {

  isLoaded = false;
  error;
  uploadedFileId;
  fileName;
  fileContent;
  fileType;
  isFileUploaded = false;
  deleteResponse;

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

    const file = event.target.files[0];

    if (file.size > MAX_FILE_SIZE) {
      this.showToast('Error!', 'error', 'File size exceeded the upload size limit.');
      return;
    }

    const reader = new FileReader();
    reader.onload = () => {
      const fileContents = reader.result.split(',')[1];
        
      this.fileName = file.name;
      this.fileContent = fileContents;
      this.fileType = file.type;

      this.isFileUploaded = true;
    };

    reader.onerror = () => {
      console.error('Error occurred while reading file.');
    };

    reader.readAsDataURL(file);
    
  }

  handleUploadToDrive() {

    if (!this.isFileUploaded) {
      this.showToast('Error!', 'error', 'Please upload a file.');
      return;
    }

    let mapAttributes = {
      fileName: this.fileName,
      fileContent: this.fileContent,
      fileType: this.fileType
    };

    this.isLoaded = !this.isLoaded;

    uploadFiles({mapAttributes: mapAttributes})
      .then((result) => {
        this.uploadedFileId = result;
        this.error = ``;
        this.fileName = ``;
        this.fileContent = ``;
        this.fileType = ``;
        this.isFileUploaded = false;
      })
      .catch((error) => {
        this.error = error.message;
        this.uploadedFileId = ``;
      })
      .finally(() => {
        this.deleteResponse = ``;
        this.isLoaded = !this.isLoaded;
      });

  }

  handleDeleteMsg() {

    this.isLoaded = !this.isLoaded;

    deleteFiles({ fileId: this.uploadedFileId})
      .then((result) => {
        this.error = ``;
        this.deleteResponse = result;
        this.fileName = ``;
        this.fileContent = ``;
        this.fileType = ``;
      })
      .catch((error) => {
        this.error = error.message;
        this.deleteResponse = ``;
      })
      .finally(() => {
        this.isLoaded = !this.isLoaded;
        this.uploadedFileId = ``;
      });

  }

}