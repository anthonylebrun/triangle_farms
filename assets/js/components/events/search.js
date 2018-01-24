import React, { Component } from 'react'
import axios from 'axios'
import EventCalendar from 'js/components/events/calendar'
import EventResults from 'js/components/events/results'
import { now, keyify, getMonth, getYear } from 'js/time_helpers'

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
    this.loadEvents(this.state.date);
  }

  maybeLoadEvents(date) {
    if (!this.state.events[keyify(date)]) this.loadEvents(date);
  }

  loadEvents(date) {
    const month = getMonth(date),
          year = getYear(date);

    const request = axios.get('/api/events', { params: { month, year } });

    request.then((response) => {
      this.setState({events: {...this.state.events, [keyify(date)]: response.data.events}});
    });

    request.catch((error) => {
      console.log(error);
    });
  }

  render() {
    const onChangeMonth = date => {
      this.setState({ date });
      this.maybeLoadEvents(date);
    };

    return (
      <div className="columns">
        <div id="calendar" className="column is-narrow">
          <EventCalendar onChangeMonth={onChangeMonth} date={this.state.date} />
        </div>
        <div id="events" className="column">
          <EventResults events={this.state.events} filters={this.state.filters} date={this.state.date} />
        </div>
      </div>
    );
  }
}
