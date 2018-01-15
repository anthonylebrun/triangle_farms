import React, { Component } from 'react'
import EventCalendar from 'js/components/event_calendar'
import moment from 'moment'

let initialState = {
  date: moment()
};

export default class EventSearch extends Component {
  constructor(props) {
    super(props);
    this.state = initialState;
  }

  render() {
    let onChangeMonth = date => {
      this.setState({ date });
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
