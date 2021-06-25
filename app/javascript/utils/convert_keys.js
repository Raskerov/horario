import _ from 'lodash';

export const snakeCase = value => value && value.replace(/([A-Z0-9])/g, x => `_${x.toLowerCase()}`)
  .replace(/\[_/, '[');


export const camelCase = value => value && value.replace(/_([a-z0-9])/g, (x, y) => y.toUpperCase());

const deepHashConvert = (obj, func) => {
  if (_.isArray(obj)) {
    return _.map(obj, element => deepHashConvert(element, func));
  }

  if (!_.isPlainObject(obj)) {
    return obj;
  }

  const output = {};
  _.each(obj, (value, key) => {
    output[func(key)] = deepHashConvert(value, func);
  });
  return output;
};

export const deepHashSnakeCase = obj => deepHashConvert(obj, snakeCase);

export const deepHashCamelCase = obj => deepHashConvert(obj, camelCase);
