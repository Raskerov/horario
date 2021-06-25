import axios from 'axios';
import qs from 'qs';
import { deepHashSnakeCase, deepHashCamelCase } from './convert_keys';

const httpClient = axios.create({
  transformRequest: [
    (data => (data ? deepHashSnakeCase(data) : undefined)),
    ...axios.defaults.transformRequest,
  ],
  transformResponse: [...axios.defaults.transformResponse, deepHashCamelCase],
  paramsSerializer: params => qs.stringify(deepHashSnakeCase(params), { arrayFormat: 'brackets', skipNulls: true }),
});

const csrf = document.querySelector('meta[name="csrf-token"]');
if (csrf) {
  httpClient.defaults.headers.common = {
    'X-CSRF-TOKEN': csrf.getAttribute('content'),
  };
}
export default httpClient;
