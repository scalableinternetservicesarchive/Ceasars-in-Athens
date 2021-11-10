import React, { Component } from 'react';
import { withRouter } from '../../helpers/WithRouter';
import API, { axiosConfig } from '../../helpers/client';

import {
  Button,
  Dialog,
  DialogContent,
  DialogTitle,
  FormHelperText,
  TextField,
} from '@mui/material';

class ServiceEditor extends Component {
  constructor(props) {
    super(props)

    this.state = {
      title: this.props.service.title.toString(),
      description: this.props.service.description.toString()
    }
  }

  render() {
    return (
      <Dialog open={this.props.open} fullWidth>
        <DialogTitle>
          {this.props.create ? "Create New Service" : "Edit Service"}
        </DialogTitle>
        <DialogContent>
          <FormHelperText> Service Name </FormHelperText>
          <TextField
            fullWidth
            variant="outlined"
            defaultValue={this.state.title}
            onChange={event => { this.setState({ title: event.target.value }) }}
          />
          <FormHelperText> Description </FormHelperText>
          <TextField
            fullWidth
            variant="outlined"
            defaultValue={this.state.description}
            onChange={event => { this.setState({ description: event.target.value }) }}
          />
          <br />
          <Button
            variant="outlined"
            onClick={event => { this.props.page.setState({ open: false }) }}>Cancel</Button>
          {this.renderDelete()}
          <Button
            variant="contained"
            onClick={event => { this.handleSave() }}>Save</Button>
        </DialogContent>
      </Dialog>
    );
  }

  renderDelete() {
    if (!this.props.create)
      return (
        <Button
          variant="contained"
          color="error"
          onClick={event => { this.handleDelete() }}>
          Delete
        </Button>)
  }

  handleSave() {
    var url = this.props.location.pathname
    var data = {
      title: this.state.title, 
      description: this.state.description
    }
    API.put(url, data, axiosConfig).then(response => {
      console.log(response)
      this.props.page.requestService()
    })
  }

  handleDelete() {
    var url = this.props.location.pathname
    API.delete(url, axiosConfig).then(response => {
      console.log(response)
      this.props.navigate(-2)
    })
  }

}

export default withRouter(ServiceEditor)