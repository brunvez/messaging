import React, { Component } from "react"
import { bindActionCreators } from "redux"
import { connect } from "react-redux"
import { getMessages } from "../actions/messages"

class MessageList extends Component {
  renderMessages() {
    return this.props.messages.map((message) =>(
      <div key={message.id}>
        <p>{message.content}</p>
      </div>
    ))
  }

  render() {
    return (
      <div>
        <h1>Messages</h1>
        {this.renderMessages()}
      </div>
    )
  }
}

function mapStateToProps({ messages }) {
  return { messages }
}

const mapDispatchToProps = (dispatch) => {
  return bindActionCreators({ getMessages }, dispatch)
}

export default connect(mapStateToProps, mapDispatchToProps)(MessageList)
