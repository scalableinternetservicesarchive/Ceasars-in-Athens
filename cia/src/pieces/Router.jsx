import React, { Component } from "react";
import { Router, Switch, Route } from "react-router-dom";
import Services from "./Services";
import history from '../../helpers/history';


export default class Routes extends Component {
    render() {
        return (
            <Router history={history}>
              <ScrollToTop>
                <Switch>
                    <Route path="/hi" exact component={Services} />
                    {/* <Route path="/Posts"  component={Index} />
                    <Route path="/Post/:id" component={Post} />
                    <Route path='/spotify/callback' component={SpotifyCallback} />
                    <Route path="/login" component={Login} />
                    <Route path="/email" exact component={Email} /> */}
                </Switch>
              </ScrollToTop>
            </Router>
        )
    }
}
