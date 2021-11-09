import React, { Component } from 'react'
import { withRouter } from '../../helpers/WithRouter'


class ServiceEntry extends Component {
    render(){
        return(
            <h1>Single Entry </h1>
        )
    }
}

export default withRouter(ServiceEntry)