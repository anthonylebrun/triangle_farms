import "phoenix_html"
import { setupBurgerNav } from "./hamburger"
import { EventCalendar } from './components/event_calendar'
import { render } from 'react-dom';

export var App = {
  run: () => {
    setupBurgerNav();
    render(<Calendar />, document.getElementById('calendar'));
  }
}
