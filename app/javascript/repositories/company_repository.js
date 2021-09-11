import httpClient from '../utils/http_client';
import {snakeCase} from "../utils/convert_keys";

export default {
  async update(params) {
    const formData = new FormData();

    _.each(params, (value, key) => formData.append(snakeCase(key), value));

    const response = await httpClient.put('/company', formData, { headers: { 'Content-Type': 'multipart/form-data' } });

    return response.data;
  },

  async delete({ password }) {
    const response = await httpClient.post('/company', { password }, { headers: { 'X-Http-Method-Override': 'delete' } });

    return response.data;
  }
};
