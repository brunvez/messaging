import React, { Component } from "react"

export default class LoginForm extends Component {
  constructor() {
    super()
    this.emailChanged = this.emailChanged.bind(this)
    this.passwordChanged = this.passwordChanged.bind(this)
    this.handleSubmit = this.handleSubmit.bind(this)
  }

  emailChanged(event) {
    this.setState({ email: event.target.value })
  }

  passwordChanged(event) {
    this.setState({ password: event.target.value })
  }

  handleSubmit() {
    const { email, password } = this.state
    this.props.onSubmit(email, password)
  }

  render() {
    return (
      <div>
        <label>
          Email
          <input type="text" onChange={this.emailChanged}/>
        </label>
        <label>
          Password
          <input type="password" onChange={this.passwordChanged}/>
        </label>
        <button onClick={this.handleSubmit}>Log In</button>
      </div>
    )
  }
}
