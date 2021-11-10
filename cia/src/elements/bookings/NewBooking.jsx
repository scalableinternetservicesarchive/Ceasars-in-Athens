// import React, { Component, useState } from 'react';
// // eslint-disable-next-line
// import API, { axiosConfig } from '../../helpers/client';
// import 'date-fns';
// // import React, { useState } from 'react';
// import DateFnsUtils from '@date-io/date-fns';
// import {
//   MuiPickersUtilsProvider,
//   KeyboardDatePicker
// } from '@material-ui/pickers';


// // import {
// //   Button,
// //   TextField
// // } from '@mui/material';

// class NewBooking extends Component {
    
//   constructor(props) {
//     super(props)
//     this.state = {
//       booking_start_time: "",
//       booking_end_time: "",
//       create_booking: ""
//     }
//   }

//   render() {
//     // debugger
//     console.log(this.props.location)
//     const [selectedDate, setSelectedDate] = useState(new Date());

//   const handleDateChange = (date) => {
//     console.log(date);
//     setSelectedDate(date);
//   };
//     return (
//       <React.Fragment>
//           <div> <MuiPickersUtilsProvider utils={DateFnsUtils}>

// <KeyboardDatePicker
//   label="Material Date Picker"
//   value={selectedDate}
//   onChange={handleDateChange}
// />

// </MuiPickersUtilsProvider> 
// </div>
//         {/* <TextField
//           fullWidth
//           label="Booking Start Time"
//           variant="outlined"
//           onChange={event => { this.setState({ booking_start_time: event.target.value }) }}
//           onKeyPress={event => { this._onKeyPress(event) }}
//         />
//         <TextField
//           fullWidth
//           label="Booking End Time"
//           variant="outlined"
//           onChange={event => { this.setState({ booking_end_time: event.target.value }) }}
//           onKeyPress={event => { this._onKeyPress(event) }}
//         />
//         <Button
//           fullWidth
//           onClick={event => { this._onSubmit() }}
//         > Create Booking </Button> */}
//       </React.Fragment>
//     )
//   }

//   _onKeyPress(event) {
//     if (event.key === "Enter")
//       this._onSubmit()
//   }

//   _onSubmit() {
//     // TODO: Call API to add new booking
//     // API.get('/bookings').then(data => {
//     //     debugger
//     // })
//     console.log("submit")
//   }
// }

// export default NewBooking