import React, { Component, createContext } from 'react'
// eslint-disable-next-line
import API, { axiosConfig } from '../helpers/client';

export const BookingsContext = createContext()

export class BookingsProvider extends Component {
  state={ bookings: [], isLoading: true}
  constructor(){
    super({})

    this.refresh = this.refresh.bind(this)
    this.deleteBooking = this.deleteBooking.bind(this)
  }
  async componentDidMount(){
    await this.refresh()
  }

  async postBooking(event){
    return await API.post('/bookings/', event).then(
      (reply) => {
        debugger
      }).catch( (reply) => {
        window.alert('Something went wrong. Please try again.')
      })
  }

  async refresh(){
    await API.get('/bookings/').then( 
      (reply) => {
        debugger
        this.setState({
          bookings: reply.data.map( (data) => { return {start: new Date(data.booking_start_time), end: new Date(data.booking_end_time)}}),
          isLoading: false
        })
      }
    ).catch( (data) => {
      debugger
      console.log('Something went wrong.')
    })
  }

  async deleteBooking(id){
    await API.delete(`/bookings/${id}`).then(
      async () => await this.refresh()
    ).catch( () => window.alert('Something went wrong deleting that post. Please try again.')
    )
  }

  render() {
    return this.state.isLoading? <div>Loading...</div> : (
      <BookingsContext.Provider value={{...this.state, postBooking: this.postBooking, refresh: this.refresh, deleteBooking: this.deleteBooking}}>
        {this.props.children}
      </BookingsContext.Provider>
    )
  }
}

export default BookingsProvider