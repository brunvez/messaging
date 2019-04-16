import getCurrentUser from "./get_current_user"
import logUserIn from "./log_user_in"

function logInAndGetUser(email, password) {
  return function(dispatch, getState) {
    dispatch(logUserIn(email, password)).then(() => {
      dispatch(getCurrentUser(getState().session.token))
    })
  } 
}

export {
  getCurrentUser,
  logUserIn,
  logInAndGetUser
}

