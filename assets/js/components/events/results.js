import React, { Component } from 'react'
import { filter, groupBy, map } from 'lodash'
import EventResultsGroup from 'js/components/events/results/group'
import { parseDate, keyify, getYear, getMonthName, getDay, today } from 'js/time_helpers'

export default class EventResults extends Component {
  render() {
    const { date, events } = this.props

    const dateKey = keyify(date),
          monthlyEvents = events[dateKey] || [],
          month = getMonthName(date),
          year = getYear(date);

    const header = (events, text) => {
      const verbage = events.length > 0 ? text : "No events found for this month (yet)!"

      return (
        <h4 className="subtitle is-5 has-text-weight-normal is-hidden-mobile">
          {verbage}
        </h4>
      );
    };

    const renderEventsByDayView = (events, date) => {
      const futureEventsOnly = filter(events, (event) => {
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
        {header(monthlyEvents, `Showing upcoming events for ${month} ${year}`)}
        {renderEventsByDayView(monthlyEvents, date)}
      </div>
    );
  }
}
