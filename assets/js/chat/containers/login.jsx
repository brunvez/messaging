import React, { Component } from "react"
import { bindActionCreators } from "redux"
import { connect } from "react-redux"
import LoginForm from "../components/login_form.jsx"
import { logInAndGetUser } from "../actions/session"

class MessageList extends Component {
  render() {
    return (
      <LoginForm onSubmit={this.props.logInAndGetUser} />
    )
  }
}

function mapStateToProps({ session }) {
  return { session }
}

const mapDispatchToProps = (dispatch) => {
  return bindActionCreators({ logInAndGetUser }, dispatch)
}

export default connect(mapStateToProps, mapDispatchToProps)(MessageList)
