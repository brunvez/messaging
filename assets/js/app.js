// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import css from "../css/app.css"
import Chat from "./chat"
import React from "react"
import ReactDOM from "react-dom"

ReactDOM.render(<Chat />, document.getElementById('wrapper'))
