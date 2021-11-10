import 'date-fns';
import React, { useState } from 'react';

import DateFnsUtils from '@date-io/date-fns';
import Grid from '@material-ui/core/Grid';
import {
  MuiPickersUtilsProvider,
  KeyboardDateTimePicker
} from '@material-ui/pickers';

function NewBooking() {

  const [StartDate, setStartDate] = useState(new Date());
  const [EndDate, setEndDate] = useState(new Date());

  const handleStartDateChange = (date) => {
    console.log(date);
    setStartDate(date);
  };
  const handleEndDateChange = (date) => {
    console.log(date);
    setEndDate(date);
  };

  return (
    <div className="NewBooking">
        <h1>Create New Booking</h1>
        <Grid container rowSpacing={1} columnSpacing={{ xs: 1, sm: 2, md: 3 }} >
            <Grid item xs={6}>

                <div >
                    <h3>Booking Start Date and Time</h3>
                    <MuiPickersUtilsProvider utils={DateFnsUtils}>
                        <KeyboardDateTimePicker
                        id="time-picker"
                        variant="dialog"
                        value={StartDate}
                        minDate={new Date()}
                        onChange={handleStartDateChange}
                        />   
                    </MuiPickersUtilsProvider>
                </div>
            </Grid>
            <Grid item xs={6}> 
                <div>
                    <h3>Booking End Date and Time</h3>
                    <MuiPickersUtilsProvider utils={DateFnsUtils}>
                        <KeyboardDateTimePicker
                        id="time-picker"
                        variant="dialog"
                        value={EndDate}
                        minDate={StartDate}
                        onChange={handleEndDateChange}
                        />   
                    </MuiPickersUtilsProvider>
                </div>
            </Grid>
        </Grid>
    </div>
  );
}

export default NewBooking;