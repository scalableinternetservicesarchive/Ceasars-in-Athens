import React, { Component, createContext } from 'react'
import API, { axiosConfig } from '../helpers/client';

export const UserContext = createContext()

export class UserProvider extends Component {
  state = { 
    currUserId: null,
    currUsername: null
  }
  
  constructor(props){
    super(props)

    this.loginUser = this.loginUser.bind(this)
    this.logoutUser = this.logoutUser.bind(this)
    this.registerUser = this.registerUser.bind(this)
    this.getUserInfo = this.getUserInfo.bind(this)
  }

  async loginUser(data){
    await API.post('/login', data)
      .then((response) => {
        debugger
        localStorage.setItem("jwt", response.data.auth_token)
      }).catch((error) => {
        debugger
        window.alert('Something went wrong. Please try again.')
      })
  }

  async getUserInfo(data){
    await API.get('/checkuser', axiosConfig())
      .then((response) => {
        debugger
      }).catch((error) => {
        debugger
        window.alert('Something went wrong. Please try again.')
      })
  }

  async logoutUser(event){
    this.setState({ currUserId: null, currUsername: null })
  }

  async registerUser(data){
    await API.post('/register', data)
      .then((response) => {
        debugger
        localStorage.setItem("jwt", response.data.auth_token)
        localStorage.setItem("username", data.username)
      }
    ).catch((error) => {
      debugger
      window.alert('Something went wrong. Please try again.')
    })
  }

  render() {
    return (
      <UserContext.Provider 
        value={{
          ...this.state, 
          loginUser: this.loginUser, 
          logoutUser: this.logoutUser, 
          registerUser: this.registerUser,
          getUserInfo: this.getUserInfo
        }}>
        {this.props.children}
      </UserContext.Provider>
    )
  }
}

export default UserProvider