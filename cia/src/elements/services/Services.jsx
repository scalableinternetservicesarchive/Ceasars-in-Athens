import React, { Component } from 'react';
import { withRouter } from '../../helpers/WithRouter';
import API, { axiosConfig } from '../../helpers/client';

import {
  Grid,
  List,
  ListItemButton,
  Typography
} from '@mui/material';

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
      <React.Fragment>
        <List
          style={{ width: '100%' }}>
          {this.renderServices()}
        </List>
      </React.Fragment>
    )
  }

  renderServices() {
    return this.state.services
      .map((entry) => {
        return (
          <ListItemButton
            key={`${entry.id}-container`}
          >
            <Grid container columns={12}>
              <Grid xs={12} item>
                <Typography key={`${entry.id}-title`} variant="h6">
                  {entry.title}
                </Typography>
              </Grid>
              <Grid xs={12} item>
                <Typography key={`${entry.id}-creation`} variant="subtitle1">
                  Posted on {this.dateFormat(entry.created_at)} by {entry.username}
                </Typography>
              </Grid>
              <Grid xs={12} item>
                <Typography key={`${entry.id}-description`} variant="body1">
                  {entry.description.substring(0, 250)}
                </Typography>
              </Grid>
            </Grid>
          </ListItemButton>
        )
      })
  }

  dateFormat(date_str) {
    var event = new Date(date_str)
    return event.toLocaleString().replace(',', '')
  }

}

export default withRouter(Services)