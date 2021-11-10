import React, { Component } from 'react';
import { withRouter } from '../../helpers/WithRouter';

import {
  Grid,
  ListItemButton,
  Typography
} from '@mui/material';

class ServiceItem extends Component {
  constructor(props) {
    super(props)
  }

  render() {
    return (
      <ListItemButton
        onClick={(event) => this._onClick(event)}
        key={`${this.props.entry.id}-container`}
      >
        <Grid container columns={12}>
          <Grid xs={12} item>
            <Typography key={`${this.props.entry.id}-title`} variant="h6">
              {this.props.entry.title}
            </Typography>
          </Grid>
          <Grid xs={12} item>
            <Typography key={`${this.props.entry.id}-creation`} variant="subtitle1">
              Posted on {this.dateFormat(this.props.entry.created_at)} by {this.props.entry.username}
            </Typography>
          </Grid>
          <Grid xs={12} item>
            <Typography key={`${this.props.entry.id}-description`} variant="body1">
              {this.props.entry.description.substring(0, 250).replaceAll('\n', ' ')}
            </Typography>
          </Grid>
        </Grid>
      </ListItemButton>
    )
  }

  dateFormat(date_str) {
    var event = new Date(date_str)
    return event.toLocaleString().replace(',', '')
  }

  _onClick(_event) {
    console.log(this.props)
    this.props.navigate(`/services/${this.props.entry.id}`)
  }
}

export default withRouter(ServiceItem)