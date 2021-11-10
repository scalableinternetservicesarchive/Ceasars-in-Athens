import React, { Component } from "react";
import { BrowserRouter as Router, Routes, Route } from "react-router-dom";
import history from '../../helpers/history';

import Services from "../services/Services";
import ServicePage from "../services/ServicePage";
import Bookings from "../bookings/Bookings";
// import NewBooking from "../bookings/NewBooking";
import Login from "../user/Login";
import Register from "../user/Register";

export default class MyRoutes extends Component {
  debugger
  render() {
    console.log("hello")

    return (
      <Router history={history}>
        {/* <ScrollToTop> */}
        <Routes>
          <Route path="/" element={<Services />} />
          <Route path="/login" element={<Login />} />
          <Route path="/register" element={<Register />} />
          <Route path="/services" element={<Services />} />
          <Route path="/services/:id" element={<ServicePage />} />
          <Route path="/bookings" element={<Bookings />} />
          {/* <Route path="/bookings/new" element={<NewBooking />} /> */}
        </Routes>
        {/* </ScrollToTop> */}
      </Router>
    )
  }
}
