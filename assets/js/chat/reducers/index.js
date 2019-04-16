import { combineReducers } from "redux"
import session from "./session"
import messages from "./messages"

export default combineReducers({
  session,
  messages
})
