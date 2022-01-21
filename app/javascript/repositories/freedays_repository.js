import httpClient from '../utils/http_client';
import {snakeCase} from "../utils/convert_keys";

export default {
  async index() {
    const response = await httpClient.get('/freedays');

    return response.data;
  },

  async create(params) {
    const formData = new FormData();

    _.each(params, (value, key) => formData.append(snakeCase(key), value));
    const response = await httpClient.post(`/freedays`, formData, { headers: { 'Content-Type': 'multipart/form-data' } });

    return response.data;
  },

  async update(id, params) {
    const formData = new FormData();

    _.each(params, (value, key) => formData.append(snakeCase(key), value));
    const response = await httpClient.put(`/freedays/${id}`, formData, { headers: { 'Content-Type': 'multipart/form-data' } });

    return response.data;
  },
};
