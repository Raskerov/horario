import employeesRepository from '../repositories/employees_repository';

const getters = {};

const mutations = {
  setUsers(state, users) {
    state.users = users;
  },
};

const actions = {
  async getCompanyUsers(context) {
    const users = await employeesRepository.getUsers();

    context.commit('setUsers', users);
  },
};

export default {
  namespaced: true,
  state: {
    users: [],
  },
  getters,
  mutations,
  actions,
};
