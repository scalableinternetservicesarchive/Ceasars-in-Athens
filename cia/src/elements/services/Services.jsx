import React, { Component } from 'react'
import { withRouter } from '../../helpers/WithRouter'


class Services extends Component {
    render(){
        // debugger
        console.log(this.props.location)
        return(
            <h1>Hello World</h1>
        )
    }
}

export default withRouter(Services)