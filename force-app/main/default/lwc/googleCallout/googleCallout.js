import { LightningElement } from 'lwc';
import googleAuthenticationPage from '@salesforce/label/c.GoogleToken';
import createCalenderMeeting from '@salesforce/apex/GoogleUtil.createCalenderMeeting';

export default class GoogleCallout extends LightningElement {

  timezones = [];
  error;
  meetingURL;

  connectedCallback() {
    this.loadTimeZoneData();
  }

  async loadTimeZoneData() {
    try {
        // Load the time zone data from the World Time API
        const response = await fetch('https://worldtimeapi.org/api/timezone');
        const timezones = await response.json();

        // Populate the combobox options
        this.timezones = timezones.map(timezone => ({
            label: timezone,
            value: timezone
        }));
    } catch(error) {
        console.error('Error fetching time zone data:', error);
    }
  }

  isValidEmail(email) {
    // Email validation regex
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    return emailRegex.test(email);
  }

  // handleAuthentication() {
  //   window.open('/apex/'+ googleAuthenticationPage, '_blank');
  // }

  checkFieldValidity(inputType, errorMsg) {

    if (!inputType.value) {
      inputType.setCustomValidity(`Please enter ${errorMsg}`);
    } else {
      inputType.setCustomValidity(``);
    }
    return inputType.reportValidity();
  }

  attendeesJSON(emails) {

    let jsonStrings = [];
    // Iterate over each email address
    emails.forEach(email => {
      // Construct a JSON object with the current email address
      let jsonObject = {
          email: email
      };
      // Convert the JSON object to a string and push it to the array
      jsonStrings.push(JSON.stringify(jsonObject));
    });
    return jsonStrings;
  }            

  handleCreateMeeting() {

    const senderEmail = this.refs.senderEmail;
    const startDate = this.refs.startDate;
    const startTime = this.refs.startTime;
    const endDate = this.refs.endDate;
    const endTime = this.refs.endTime;
    const timeZone = this.refs.timeZone;
    const meetingSubject = this.refs.meetingSubject;
    const meetingDescription = this.refs.meetingDescription;
    const attendeesEmail = this.refs.attendeesEmail;

    const checkSenderEmailValid = this.checkFieldValidity(senderEmail, `sender email`);
    const checkStartDateValid = this.checkFieldValidity(startDate, `start date`);
    const checkStartTimeValid = this.checkFieldValidity(startTime, `start time`);
    const checkEndDateValid = this.checkFieldValidity(endDate, `end date`);
    const checkEndTimeValid = this.checkFieldValidity(endTime, `end time`);
    const checkTimeZoneValid = this.checkFieldValidity(timeZone, `time zone`);
    const checkMeetingSubjectValid =this.checkFieldValidity(meetingSubject, `meeting subject`);
    const checkAttendeeEmailsValid = this.checkFieldValidity(attendeesEmail, `attendees email address`);

    if(!checkSenderEmailValid || !checkStartDateValid || !checkStartTimeValid || !checkEndDateValid || !checkEndTimeValid || !checkTimeZoneValid || !checkMeetingSubjectValid || !checkAttendeeEmailsValid){
      return;
    }

    const attendeesEmailList = attendeesEmail.value.split('\n').filter(email => email.trim() !== '').filter(email => this.isValidEmail(email));
    const startDateTime = `${startDate.value}T${startTime.value.substring(0, 8)}`;
    const endDateTime = `${endDate.value}T${endTime.value.substring(0, 8)}`;

    let requestBody = '{'
                        +'"end": {'
                        +  '"dateTime": "' + endDateTime + '",'
                        +  '"timeZone": "' + timeZone.value + '"'
                        + '},'
                        + '"start": {'
                        + '"dateTime": "' + startDateTime + '",'
                        + '"timeZone": "' + timeZone.value + '"'
                        + '},'
                        + '"summary": "' + meetingSubject.value + '",'
                        + '"location": "Online",'
                        + '"sendUpdates": "all",'
                        + '"reminders": {'
                        +  '"useDefault": false,'
                        +  '"overrides": ['
                        +    '{'
                        +      '"method": "email",'
                        +      '"minutes": 1440'
                        +    '},'
                        +    '{'
                        +      '"method": "popup",'
                        +      '"minutes": 60'
                        +    '}'
                        +  ']'
                        + '},'
                        + '"description": "' + meetingDescription.value + '",'
                        + '"attendees":' + '[' 
                        + this.attendeesJSON(attendeesEmailList) 
                        + ']'
                      +'}';

    createCalenderMeeting({ calendarId: senderEmail.value, requestBody: requestBody})
      .then((result) => {
        this.meetingURL = result;
        this.error = ``;
        senderEmail.value = ``;
        startDate.value = ``;
        startTime.value = ``;
        endDate.value = ``;
        endTime.value = ``;
        meetingSubject.value = ``;
        meetingDescription.value = ``;
        attendeesEmail.value = ``;
      })
      .catch((error) => {
        this.error = error.message;
        this.meetingURL = ``;
      });
    

  }

}