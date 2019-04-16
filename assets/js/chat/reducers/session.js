import {
  LOG_USER_IN_STARTED,
  LOG_USER_IN_SUCCESS,
  LOG_USER_IN_FAILURE,

  GET_CURRENT_USER_STARTED,
  GET_CURRENT_USER_SUCCESS,
  GET_CURRENT_USER_FAILURE
} from "../actions/session/types"

const INITIAL_STATE = { loading: false }

export default function session(state = INITIAL_STATE, action) {
  switch(action.type) {
  case LOG_USER_IN_STARTED:
    return { ...state, loading: true }
  case LOG_USER_IN_SUCCESS:
    return { ...state, ...action.payload, loading: false }
  case LOG_USER_IN_FAILURE:
    return { ...state, loading: false }
  case GET_CURRENT_USER_STARTED:
    return { ...state, loading: true }
  case GET_CURRENT_USER_SUCCESS:
    return { ...state, ...action.payload, loading: false }
  case GET_CURRENT_USER_FAILURE:
    return { ...state, loading: false }     
  default:
    return state
  }
}
