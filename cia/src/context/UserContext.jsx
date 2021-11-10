import React, { Component, createContext } from 'react'
// eslint-disable-next-line
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
  }

  async componentDidMount(){
    await this.refresh()
  }

  async loginUser(data){
    await API.post('/login', data)
      .then((response) => {
        this.setState({
          currUserId: response.data.user_id, 
          currUsername: response.data.username 
        })
      }).catch((error) => {
        window.alert('Something went wrong. Please try again.')
      })
  }

  async logoutUser(event){
    this.setState({ currUserId: null, currUsername: null })
  }

  async registerUser(data){
    await API.post('/register', data)
      .then((response) => {
        this.setState({
          currUserId: response.data.user_id, 
          currUsername: response.data.username 
        })
      }
    ).catch((error) => {
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
          registerUser: this.registerUser
        }}>
        {this.props.children}
      </UserContext.Provider>
    )
  }
}

export default UserProvider