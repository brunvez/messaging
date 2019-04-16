import React from 'react'
import { applyMiddleware, createStore } from "redux"
import { Provider } from "react-redux"
import App from "./components/app.jsx"
import reducers from "./reducers"
import thunk from 'redux-thunk';

const store = createStore(reducers, applyMiddleware(thunk))

const Chat = () => (
  <Provider store={store}>
    <App/>
  </Provider>
)

export default Chat
