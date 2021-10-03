import employeesRepository from '../repositories/employees_repository';

const getters = {};

const mutations = {};

const actions = {
  async removeUser(context, user) {
    await employeesRepository.removeUser(user.id);

    await context.dispatch('company/getCompanyUsers', {}, { root: true });
  },

  async changeRole(context, payload) {
    await employeesRepository.changeRole(payload.user.id, payload.role);

    await context.dispatch('company/getCompanyUsers', {}, { root: true });
  },
};

export default {
  namespaced: true,
  state: {},
  getters,
  mutations,
  actions,
};
