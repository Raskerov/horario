import httpClient from '../utils/http_client';

export default {
  async show() {
    const response = await httpClient.get('/user');

    return response.data;
  },
};
