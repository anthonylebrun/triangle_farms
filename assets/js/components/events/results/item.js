import React, { Component } from 'react'
import { parseDate, getTime } from 'js/time_helpers'

export default class EventResultsItem extends Component {
  render() {
    const { event } = this.props;
    const { start_at, end_at } = event;

    const eventTime = (event) => {
      return `${getTime(parseDate(start_at))} - ${getTime(parseDate(end_at))}`
    };

    return (
      <div className="event-item card">
        <div className="card-content">
          <div className="media">
            <div className="media-left">
              <figure className="image is-32x32">
                <img src="/images/calendar.png" alt="Placeholder image" />
              </figure>
            </div>
            <div className="media-content">
              <p className="event-name">{event.name}</p>
              <p className="event-details">
                <span className="event-time">{eventTime(event)}</span>
                <span className="event-location">{event.location}</span>
              </p>
            </div>
          </div>
          <div className="content">{event.description}</div>
        </div>
      </div>
    );
  }
}
