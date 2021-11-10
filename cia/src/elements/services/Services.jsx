import React, { Component } from 'react';
import { withRouter } from '../../helpers/WithRouter';
import API, { axiosConfig } from '../../helpers/client';


class Services extends Component {
    constructor(props) {
        super(props)
        this.state = {
            services: []
        }
    }

    componentDidMount() {
        // API.get('/services').then(data => {
        //     debugger
        // })
    }

    render(){
        // debugger
        console.log(this.props.location)
        return(
            <h1>Hello World</h1>
        )
    }
    
}

export default withRouter(Services)