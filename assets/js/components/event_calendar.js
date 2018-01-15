import React, { Component } from 'react';
import { Calendar } from 'react-calendar-component';

export default class EventCalendar extends Component {
  render() {
    return (
      <Calendar
        onChangeMonth={date => this.props.onChangeMonth(date)}
        date={this.props.date}
        onPickDate={date => null}
        renderHeader={({ date, onPrevMonth, onNextMonth }) => (
          <div className="Calendar-header">
            <button onClick={onPrevMonth}>«</button>
            <div className="Calendar-header-currentDate">
              <span className="Calendar-header-currentDate-month">{date.format('MMMM')}</span>
              <span className="Calendar-header-currentDate-year">{date.format('YYYY')}</span>
            </div>
            <button onClick={onNextMonth}>»</button>
          </div>
        )}
      />
    );
  }
}
