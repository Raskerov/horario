import httpClient from '../utils/http_client';

export default {
  async index() {
    const response = await httpClient.get('/messages');

    return response.data;
  },

  async create(message, receiverId) {
    const response = await httpClient.post('/messages', { message: message, receiver_id: receiverId })

    return response.data;
  },

  async getConversation(personId) {
    const response = await httpClient.get('/messages/conversation', { params: { person_id: personId } })

    return response.data;
  },
};
