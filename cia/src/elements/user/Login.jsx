import React, { Component } from 'react';
import API, { axiosConfig } from '../../helpers/client';

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

export default Login