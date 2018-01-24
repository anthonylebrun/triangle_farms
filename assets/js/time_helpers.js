import moment from 'moment'

export const parseDate = (timestamp) => {
  return moment(timestamp);
}

export const now = () => {
  return moment();
}

export const today = () => {
  return moment().startOf('day');
}

export const getYear = (date) => {
  return date.format('Y');
}

export const getMonth = (date) => {
  return date.format('M');
}

export const getDay = (date) => {
  return date.format('D');
}

export const getMonthName = (date) => {
  return date.format('MMMM');
}

export const getTime = (date) => {
  return date.format('h:mm a');
}

export const humanize = (date) => {
  if (date.isSame(moment(), 'day')) {
    return 'Today';
  } else {
    return date.format('dddd MMMM Do');
  }
}

export const keyify = (date) => {
  let month = date.format('M'),
      year = date.format('Y'),
      key = `${month}-${year}`;

  return key;
}
