import React, { Component } from 'react';
import {
  Button,
  TextField
} from '@mui/material';
import { UserContext } from '../../context/UserContext';

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
    return (
      <UserContext.Consumer>{ (userContext) => {
        const {registerUser} = userContext

        function _onSubmit(username, password, confirm) {
          debugger
          if (password !== confirm) {
            throw Error("Password doesn't match")
          }
          
          console.log("submit")
          registerUser({username: username, password: password, password_confirmation: confirm })
        }

        function _onKeyPress(event) {
          if (event.key === "Enter")
            this._onSubmit()
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
        <TextField
          fullWidth
          type="password"
          label="Confirm Password"
          variant="outlined"
          onChange={event => { this.setState({ confirm: event.target.value }) }}
          onKeyPress={event => { _onKeyPress(event) }}
        />
        <Button
          fullWidth
          onClick={event => { _onSubmit(this.state.username, this.state.password, this.state.confirm) }}
        > Register </Button>
        <Button
          fullWidth
          variant="text"
          onClick={event => { this.props.navigate('/login') }}
        > Create New Account </Button>
      </React.Fragment>
        )
      }
        }</UserContext.Consumer>
    )
  }  
}

export default Register