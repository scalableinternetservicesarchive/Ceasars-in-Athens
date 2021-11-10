import React, { Component } from 'react'
import { withRouter } from '../../helpers/WithRouter'
// eslint-disable-next-line
import API, { axiosConfig } from '../../helpers/client';
import ServiceEditor from './ServiceEditor';

import {
  Grid,
  IconButton,
  Paper,
  Typography
} from '@mui/material';

import ArrowBackIcon from '@mui/icons-material/ArrowBack';
import EditIcon from '@mui/icons-material/Edit';

class ServicePage extends Component {
  constructor(props) {
    super(props)

    this.state = {
      username: "",
      service: {},
      open: false
    }
    this.requestService.bind(this)
  }

  componentDidMount() {
    this.requestService()
  }

  render() {
    console.log(this.state)
    return (
      <React.Fragment>
        {this.state.open &&
          <ServiceEditor
            service={this.state.service}
            create={false}
            open={this.state.open}
            page={this} />}
        <Paper elevation='0' sx={{ padding: '100px' }}>
          <Grid container columns={12}>
            <Grid xs={12} item>
              <IconButton size="large" onClick={event => { this.props.navigate(-1) }}>
                <ArrowBackIcon fontSize="inherit" />
              </IconButton>
            </Grid>
            <Grid xs={8} item>
              <Typography variant="h6">
                {this.state.service.title}
              </Typography>
            </Grid>
            <Grid xs={4} item>
              <IconButton size="large" onClick={event => { this.setState({ open: true })}}>
                <EditIcon fontSize="inherit" />
              </IconButton>
            </Grid>
            <Grid xs={12} item>
              <Typography variant="subtitle1">
                {this.serviceInfo()}
              </Typography>
            </Grid>
            <Grid xs={12} item>
              <Typography variant="body1">
                {this.state.service.description}
              </Typography>
            </Grid>
          </Grid>
        </Paper>
      </React.Fragment>
    )
  }

  requestService() {
    var url = this.props.location.pathname
    API.get(url).then(response => {
      console.log(response)
      this.setState({
        username: response.data.username,
        service: response.data.service,
        open: false
      })
    })
  }

  serviceInfo() {
    return this.state.username ?
      `Posted on ${this.dateFormat(this.state.service.created_at)} by ${this.state.username}` : ""
  }

  dateFormat(date_str) {
    var event = new Date(date_str)
    return event.toLocaleString().replace(',', '')
  }

}

export default withRouter(ServicePage)