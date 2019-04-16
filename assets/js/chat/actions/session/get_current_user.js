import axios from "axios"
import { 
  GET_CURRENT_USER_STARTED,
  GET_CURRENT_USER_SUCCESS,
  GET_CURRENT_USER_FAILURE
} from "./types"

export default function getCurrentUser(token) {
  return function(dispatch) {
    dispatch(getCurrentUserStarted())
    const headers = { authorization: `Bearer ${token}` }
    return axios
      .get(`http://localhost:5000/api/v1/user`, { headers })
      .then(({ data: { data } }) => {
        dispatch(getCurrentUserSuccess(data));
      })
      .catch(error => {
        dispatch(getCurrentUserFailure(error.message));
      })
  }
}

const getCurrentUserStarted = () => (
  { type: GET_CURRENT_USER_STARTED }
)

const getCurrentUserSuccess = (user) => (
  { 
    type: GET_CURRENT_USER_SUCCESS,
    payload: {
      user
    }
  }
)

const getCurrentUserFailure = (message) => (
  { type: GET_CURRENT_USER_FAILURE, message }
)

