import React, { Component } from "react";
import { Router, Routes, Route } from "react-router-dom";
import Services from "./Services";
import history from '../helpers/history';
import ScrollToTop from "../helpers/ScrollToTop";


export default class myRoutes extends Component {

    render() {
        return (
            <Router history={history}>
              <ScrollToTop>
                <Routes>
                    <Route path="/hi" exact component={Services} />
                    {/* <Route path="/Posts"  component={Index} />
                    <Route path="/Post/:id" component={Post} />
                    <Route path='/spotify/callback' component={SpotifyCallback} />
                    <Route path="/login" component={Login} />
                    <Route path="/email" exact component={Email} /> */}
                </Routes>
              </ScrollToTop>
            </Router>
        )
    }
}
