import "phoenix_html"
import { setupBurgerNav } from "./hamburger"
import React from 'react'
import EventSearch from './components/events/search'
import { render } from 'react-dom'

export var App = {
  run: () => {
    setupBurgerNav();
    render(<EventSearch />, document.getElementById('eventSearch'));
  }
}
