import React, { Component } from 'react'
import { filter, groupBy, map } from 'lodash'
import EventResultsGroup from 'js/components/events/results/group'
import { parseDate, keyify, getYear, getMonthName, getDay, today } from 'js/time_helpers'

export default class EventResults extends Component {
  render() {
    const { date, events } = this.props

    const month = getMonthName(date),
          year = getYear(date);

    const header = (text) => {
      return (
        <h4 className="subtitle is-5 has-text-weight-normal is-hidden-mobile">
          {text}
        </h4>
      );
    };

    const renderEventsByDayView = (events, date) => {
      const monthlyEvents = events[keyify(date)];

      const futureEventsOnly = filter(monthlyEvents, (event) => {
        return parseDate(event.start_at) > today();
      });

      const eventsByDay = groupBy(futureEventsOnly, (e) => {
        return getDay(parseDate(e.start_at))
      });

      const eventsByDayView = map(eventsByDay, (events) => {
        const day = parseDate(events[0].start_at);
        return <EventResultsGroup key={day} day={day} events={events} />
      });

      return eventsByDayView;
    };


    return (
      <div>
        {header(`Showing upcoming events for ${month} ${year}`)}
        {renderEventsByDayView(events, date)}
      </div>
    );
  }
}
