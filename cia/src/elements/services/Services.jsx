import React, { Component } from 'react';
import { withRouter } from '../../helpers/WithRouter';
import API, { axiosConfig } from '../../helpers/client';


class Services extends Component {
    render(){
        // debugger
        console.log(this.props.location)
        return(
            <h1>Hello World</h1>
        )
    }
    componentDidMount() {
        API.get('/services').then(data => {
            debugger
        })
    }
}

export default withRouter(Services)