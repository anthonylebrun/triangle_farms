import moment from 'moment'

export const now = () => {
  return moment();
}

export const getYear = (date) => {
  return date.format('YYYY');
}

export const getMonth = (date) => {
  return date.format('MMMM');
}

export const keyify = (date) => {
  let month = date.format('M'),
      year = date.format('Y'),
      key = `${month}-${year}`;

  return key;
}
