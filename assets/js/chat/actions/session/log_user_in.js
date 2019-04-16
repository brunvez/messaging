import axios from "axios"
import {
  LOG_USER_IN_STARTED,
  LOG_USER_IN_SUCCESS,
  LOG_USER_IN_FAILURE,
} from "./types"

export default function logUserIn(email, password) {
  return function(dispatch) {
    dispatch(logUserInStarted())
    return axios
      .post(`http://localhost:5000/api/v1/sessions`, {
        email,
        password
      })
      .then(({ headers }) => {
        dispatch(logUserInSuccess(headers.authorization));

      })
      .catch(error => {
        dispatch(logUserInFailure(error.message));
      })
  }
}

const logUserInStarted = () => (
  { type: LOG_USER_IN_STARTED }
)

const logUserInSuccess = (token) => (
  { 
    type: LOG_USER_IN_SUCCESS,
    payload: {
      token 
    }
  }
)

const logUserInFailure = (message) => (
  { type: LOG_USER_IN_FAILURE, message }
)
