import React, { Component } from "react";
import { BrowserRouter as Router, Routes, Route } from "react-router-dom";
import Services from "../services/Services";
import history from '../../helpers/history';
import Bookings from "../bookings/Bookings";

export default class MyRoutes extends Component {
    debugger
    render() {
    console.log("hello")

        return (
            <Router history={history}>
              {/* <ScrollToTop> */}
                <Routes>
                    <Route path="/hi" element={<Services />} />
                    <Route path="/" element={<Bookings />} />
                    {/* <Route path="/Posts"  component={Index} />
                    <Route path="/Post/:id" component={Post} />
                    <Route path='/spotify/callback' component={SpotifyCallback} />
                    <Route path="/login" component={Login} />
                    <Route path="/email" exact component={Email} /> */}
                </Routes>
              {/* </ScrollToTop> */}
            </Router>
        )
    }
}
