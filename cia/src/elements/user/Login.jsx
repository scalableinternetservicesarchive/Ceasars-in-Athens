import React, { Component } from 'react';
// eslint-disable-next-line
import API, { axiosConfig } from '../../helpers/client';
import { withRouter } from '../../helpers/WithRouter'

import {
  Button,
  TextField
} from '@mui/material';
import { UserContext } from '../../context/UserContext';

class Login extends Component {
  constructor(props) {
    super(props)
    this.state = {
      username: "",
      password: ""
    }
  }

  render() {
    return (
      <UserContext.Consumer>{ (userContext) => {
        const {loginUser, getUserInfo} = userContext

        function _onKeyPress(event) {
          if (event.key === "Enter")
            _onSubmit()
        }
      
        function _onSubmit(username, password) {
          // Call API to post login request
          console.log("submit")
          loginUser({username: username, password: password})
        }

        return(
      <React.Fragment>
        <TextField
          fullWidth
          label="Username"
          variant="outlined"
          onChange={event => { this.setState({ username: event.target.value }) }}
          onKeyPress={event => { _onKeyPress(event) }}
        />
        <TextField
          fullWidth
          type="password"
          label="Password"
          variant="outlined"
          onChange={event => { this.setState({ password: event.target.value }) }}
          onKeyPress={event => { _onKeyPress(event) }}
        />
        <Button
          fullWidth
          onClick={event => { _onSubmit(this.state.username, this.state.password) }}
        > Log In </Button>
        <Button
          fullWidth
          onClick={event => { getUserInfo(localStorage.getItem("jwt")) }}
        > Click Me for a Great Time </Button>
      </React.Fragment>)
      }
  }</UserContext.Consumer>)
}
}

export default withRouter(Login)