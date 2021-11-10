import React, { Component } from 'react';
import API, { axiosConfig } from '../../helpers/client';

import {
  Button,
  TextField
} from '@mui/material';

class Register extends Component {
  constructor(props) {
    super(props)
    this.state = {
      username: "",
      password: "",
      confirm: ""
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
        <TextField
          fullWidth
          type="password"
          label="Confirm Password"
          variant="outlined"
          onChange={event => { this.setState({ password: event.target.value }) }}
          onKeyPress={event => { this._onKeyPress(event) }}
        />
        <Button
          fullWidth
          onClick={event => { this._onSubmit() }}
        > Register </Button>
        <Button
          fullWidth
          variant="text"
          onClick={event => { this.props.navigate('/login') }}
        > Create New Account </Button>
      </React.Fragment>
    )
  }

  _onKeyPress(event) {
    if (event.key === "Enter")
      this._onSubmit()
  }

  _onSubmit() {
    if (this.state.password != this.state.confirm) {
      // password & confirm password doesn't match
    }
    // Call API to send login request
    // API.get('/services').then(data => {
    //     debugger
    // })
    console.log("submit")
  }
}

export default Register