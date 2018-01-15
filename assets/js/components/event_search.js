import React, { Component } from 'react'
import EventCalendar from 'js/components/event_calendar'
import { now, keyify } from 'js/date_helpers'

let initialState = {
  date: now(),
  events: {},
  filters: []
};

export default class EventSearch extends Component {
  constructor(props) {
    super(props);
    this.state = initialState;
  }

  componentDidMount() {
    this.loadEvents(keyify(this.state.date));
  }

  maybeLoadEvents(dateKey) {
    if (!this.state.events[dateKey]) this.loadEvents(dateKey);
  }

  loadEvents(dateKey) {
    console.log(`LOADING for ${dateKey}`);
    this.setState({events: {...this.state.events, [dateKey]: []}});
  }

  render() {
    let onChangeMonth = date => {
      this.setState({ date });
      this.maybeLoadEvents(keyify(date));
    };

    return (
      <div className="columns">
        <div id="calendar" className="column is-narrow">
          <EventCalendar onChangeMonth={onChangeMonth} date={this.state.date} />
        </div>
        <div id="events" className="column">
        </div>
      </div>
    );
  }
}
