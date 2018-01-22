import React, { Component } from 'react';
import { getYear, getMonth } from 'js/date_helpers';
import groupBy from 'lodash/groupBy';

export default class EventList extends Component {
  render() {
    let month = getMonth(this.props.date),
        year = getYear(this.props.date);

    let header = (text) => {
      return (
        <h4 className="subtitle is-5 has-text-weight-normal is-hidden-mobile">
          {text}
        </h4>
      );
    };

    return (
      <div>
        {header(`Showing upcoming events for ${month} ${year}`)}
      </div>
    );
  }
}
