import httpClient from '../utils/http_client';
import { snakeCase } from '../utils/convert_keys';

export default {
  async create(params) {
    const response = await httpClient.post(`/employees`, params);

    return response.data;
  },

  async getUsers() {
    const response = await httpClient.get(`/employees`);

    return response.data;
  },

  async removeUser(id) {
    const response = await httpClient.delete(`/employees/${id}`);

    return response.data;
  },

  async changeRole(id, role) {
    const response = await httpClient.put(`/employees/${id}/change_role`, { role });

    return response.data;
  },

  async checkConfirmation(token) {
    const response = await httpClient.get(`/accept_invitations/fetch_confirmation/${token}`);

    return response.data;
  },

  async register({ token, params }) {
    const formData = new FormData();

    _.each(params, (value, key) => formData.append(snakeCase(key), value));
    const config = { headers: { 'Content-Type': 'multipart/form-data' } };
    const response = await httpClient.put(`accept_invitations/register/${token}`, formData, config);

    return response.data;
  },
};
