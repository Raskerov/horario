import httpClient from '../utils/http_client';

export default {

  async signUp(data) {
    const response = await httpClient.post('/auth/sign_up', data);

    return response.data;
  },

  async signIn(data) {
    const response = await httpClient.post('/auth/sign_in', data);

    return response.data;
  },

  async signOut() {
    const response = await httpClient.delete('/auth/sign_out');

    return response.data;
  },

  async changePassword(data) {
    const response = await httpClient.post('/auth/update', data);

    return response.data;
  },

  async forgotPassword(data) {
    const response = await httpClient.post('/auth/password', data);

    return response.data;
  },

  async resetPassword(data) {
    const response = await httpClient.put('/auth/password', data);

    return response.data;
  },
};
