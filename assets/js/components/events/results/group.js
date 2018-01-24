import React, { Component } from 'react'
import { map } from 'lodash'
import { humanize } from 'js/time_helpers'
import EventResultsItem from 'js/components/events/results/item'

export default class EventResultsGroup extends Component {
  render() {
    const { day, events } = this.props

    const dateHeader = (date) => {
      return (
        <h4 className="title is-5">{humanize(date)}</h4>
      );
    };

    const renderEventItems = (events) => {
      return map(events, (event) => {
        return <EventResultsItem key={event.name} event={event} />;
      });
    };

    return (
      <div className="event-group">
        {dateHeader(day)}
        {renderEventItems(events)}
      </div>
    );
  }
}
