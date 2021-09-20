import httpClient from '../utils/http_client';

export default {
  async getUsers() {
    const response = await httpClient.get(`/employees`);

    return response.data;
  },

  async removeUser(id) {
    const response = await httpClient.delete(`/employees/${id}`);

    return response.data;
  }
};
