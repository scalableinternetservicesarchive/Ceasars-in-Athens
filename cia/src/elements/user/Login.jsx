import React, { Component } from 'react';
// eslint-disable-next-line
import API, { axiosConfig } from '../../helpers/client';
import { withRouter } from '../../helpers/WithRouter'

import {
  Button,
  TextField
} from '@mui/material';

class Login extends Component {
  constructor(props) {
    super(props)
    this.state = {
      username: "",
      password: ""
    }
  }

  render() {
    // debugger
    console.log(this.props.location)
    return (
      <React.Fragment>
        <TextField
          fullWidth
          label="Username"
          variant="outlined"
          onChange={event => { this.setState({ username: event.target.value }) }}
          onKeyPress={event => { this._onKeyPress(event) }}
        />
        <TextField
          fullWidth
          type="password"
          label="Password"
          variant="outlined"
          onChange={event => { this.setState({ password: event.target.value }) }}
          onKeyPress={event => { this._onKeyPress(event) }}
        />
        <Button
          fullWidth
          onClick={event => { this._onSubmit() }}
        > Log In </Button>
        <Button
          fullWidth
          variant="text"
          onClick={event => { this.props.navigate('/register') }}
        > Create New Account </Button>
      </React.Fragment>
    )
  }

  _onKeyPress(event) {
    if (event.key === "Enter")
      this._onSubmit()
  }

  _onSubmit() {
    // Call API to send login request
    // API.get('/services').then(data => {
    //     debugger
    // })
    console.log("submit")
  }
}

export default withRouter(Login)