import React, { Component } from 'react';
import { Calendar } from 'react-calendar-component';
import { getYear, getMonth } from 'js/date_helpers';

export default class EventCalendar extends Component {
  render() {
    let headerMarkup = ({ date, onPrevMonth, onNextMonth }) => (
      <div className="Calendar-header">
        <button onClick={onPrevMonth}>«</button>
        <div className="Calendar-header-currentDate">
          <span className="Calendar-header-currentDate-month">{getMonth(date)}</span>
          <span className="Calendar-header-currentDate-year">{getYear(date)}</span>
        </div>
        <button onClick={onNextMonth}>»</button>
      </div>
    );

    return (
      <Calendar
        onChangeMonth={date => this.props.onChangeMonth(date)}
        date={this.props.date}
        onPickDate={date => null}
        renderHeader={headerMarkup}
      />
    );
  }
}
