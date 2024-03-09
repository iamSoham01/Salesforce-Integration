import { LightningElement} from 'lwc';
import createCalenderMeeting from '@salesforce/apex/GoogleUtil.createCalenderMeeting';

export default class GoogleCalendar extends LightningElement {
  
  timezones = [];
  error;
  meetingURL;
  isLoaded = false;

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

  checkFieldValidity(inputType, errorMsg) {

    if (!inputType.value) {
      inputType.setCustomValidity(`Please enter ${errorMsg}`);
    } else {
      inputType.setCustomValidity(``);
    }
    return inputType.reportValidity();
  }     

  handleCreateMeeting() {

    const startDate = this.refs.startDate;
    const startTime = this.refs.startTime;
    const endDate = this.refs.endDate;
    const endTime = this.refs.endTime;
    const timeZone = this.refs.timeZone;
    const meetingSubject = this.refs.meetingSubject;
    const meetingDescription = this.refs.meetingDescription;
    const attendeesEmail = this.refs.attendeesEmail;

    const checkStartDateValid = this.checkFieldValidity(startDate, `start date`);
    const checkStartTimeValid = this.checkFieldValidity(startTime, `start time`);
    const checkEndDateValid = this.checkFieldValidity(endDate, `end date`);
    const checkEndTimeValid = this.checkFieldValidity(endTime, `end time`);
    const checkTimeZoneValid = this.checkFieldValidity(timeZone, `time zone`);
    const checkMeetingSubjectValid =this.checkFieldValidity(meetingSubject, `meeting subject`);
    const checkAttendeeEmailsValid = this.checkFieldValidity(attendeesEmail, `attendees email address`);

    if(!checkStartDateValid || !checkStartTimeValid || !checkEndDateValid || !checkEndTimeValid || !checkTimeZoneValid || !checkMeetingSubjectValid || !checkAttendeeEmailsValid){
      return;
    }

    this.isLoaded = !this.isLoaded;

    const attendeesEmailList = attendeesEmail.value.split('\n').filter(email => email.trim() !== '').filter(email => this.isValidEmail(email));
    const startDateTime = `${startDate.value}T${startTime.value.substring(0, 8)}`;
    const endDateTime = `${endDate.value}T${endTime.value.substring(0, 8)}`;

    let mapAttributes = {
      endDateTime: endDateTime,
      startDateTime: startDateTime,
      timeZone: timeZone.value,
      meetingSubject: meetingSubject.value,
      meetingDescription: meetingDescription.value,
      attendeesEmailList: attendeesEmailList
    };

    createCalenderMeeting({mapAttributes: mapAttributes})
      .then((result) => {
        this.meetingURL = result;
        this.error = ``;
        startDate.value = ``;
        startTime.value = ``;
        endDate.value = ``;
        endTime.value = ``;
        meetingSubject.value = ``;
        meetingDescription.value = ``;
        attendeesEmail.value = ``;
        this.timezones = [];
      })
      .catch((error) => {
        this.error = error.message;
        this.meetingURL = ``;
      })
      .finally(() => {
        this.isLoaded = !this.isLoaded;
      });
    

  }

}