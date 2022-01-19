import httpClient from '../utils/http_client';
import {snakeCase} from "../utils/convert_keys";

export default {
  async index() {
    const response = await httpClient.get('/schedules');

    return response.data;
  },

  async create(params) {
    const formData = new FormData();

    _.each(params, (value, key) => formData.append(snakeCase(key), value));

    const response = await httpClient.post(`/schedules`, formData, { headers: { 'Content-Type': 'multipart/form-data' } });

    return response.data;
  },

  async update(id, params) {
    const formData = new FormData();

    _.each(params, (value, key) => formData.append(snakeCase(key), value));

    const response = await httpClient.put(`/schedules/${id}`, formData, { headers: { 'Content-Type': 'multipart/form-data' } });

    return response.data;
  },

  async destroy(id) {
    const response = await httpClient.delete(`/schedules/${id}`);

    return response.data;
  }
};
