import React, { Component } from 'react'
import { BookingsContext } from '../../context/BookingsContext'


class Bookings extends Component {

    render(){
        return(
            <BookingsContext.Consumer>{ (bookingsContext) => {
                const {bookings, postBooking, refresh, deleteBooking} = bookingsContext
                console.log(bookings)
            return(
                <h1>Hello World1</h1>
            )
            }
    }</BookingsContext.Consumer>)
    }
}

export default Bookings