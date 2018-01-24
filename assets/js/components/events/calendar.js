import React, { Component } from 'react'
import { Calendar } from 'react-calendar-component'
import { thisMonth, getYear, getMonthName } from 'js/time_helpers'

export default class EventCalendar extends Component {
  render() {

    const prevMonthButton = (date, onPrevMonth) => {
      if (date > thisMonth()) {
        return <button onClick={onPrevMonth}>&laquo;</button>;
      } else {
        return <button className="is-disabled">&laquo;</button>;
      }
    };

    const headerMarkup = ({ date, onPrevMonth, onNextMonth }) => (
      <div>
        <div className="Calendar-header">
          {prevMonthButton(date, onPrevMonth)}
          <div className="Calendar-header-currentDate">
            <span className="Calendar-header-currentDate-month">{getMonthName(date)}</span>
            <span className="Calendar-header-currentDate-year">{getYear(date)}</span>
          </div>
          <button onClick={onNextMonth}>&raquo;</button>
        </div>
        <div className="Calendar-grid-header">
          <div className="Calendar-grid">
            <div className="Calendar-grid-item">Sun</div>
            <div className="Calendar-grid-item">Mon</div>
            <div className="Calendar-grid-item">Tue</div>
            <div className="Calendar-grid-item">Wed</div>
            <div className="Calendar-grid-item">Thu</div>
            <div className="Calendar-grid-item">Fri</div>
            <div className="Calendar-grid-item">Sat</div>
          </div>
        </div>
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
