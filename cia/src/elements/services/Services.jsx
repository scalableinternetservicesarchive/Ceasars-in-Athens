import React, { Component } from 'react';
import { withRouter } from '../../helpers/WithRouter';
// eslint-disable-next-line
import API, { axiosConfig } from '../../helpers/client';

import ServiceItem from './ServiceItem';

import { List, Paper } from '@mui/material';

class Services extends Component {
  constructor(props) {
    super(props)
    this.state = {
      services: []
    }
  }

  componentDidMount() {
    var url = this.props.location.pathname + this.props.location.search
    API.get(url).then(response => {
      console.log(response);
      this.setState({ services: response.data })
    })
  }

  render() {
    return (
      <Paper elevation='0' sx={{ padding: '100px' }}>
        <List
          style={{ width: '100%' }}>
          {this.renderServices()}
        </List>
      </Paper>
    )
  }

  renderServices() {
    return this.state.services
      .map((entry) => {
        return (<ServiceItem entry={entry} />)
      })
  }

}

export default withRouter(Services)