import React from 'react'
import { connect } from "react-redux"
import Login from "../containers/login.jsx"
import MessageList from "../containers/message_list.jsx"

const App = ({ session }) => {
  return !session.user ? <Login /> : <MessageList />
}

export default connect(({ session }) => ({ session }))(App)
