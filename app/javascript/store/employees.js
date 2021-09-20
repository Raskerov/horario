import employeesRepository from '../repositories/employees_repository';

const getters = {};

const mutations = {};

const actions = {
  async removeUser(context, user) {
    await employeesRepository.removeUser(user.id);

    await this.$store.dispatch('company/getCompanyUsers');
  },
};

export default {
  namespaced: true,
  state: {},
  getters,
  mutations,
  actions,
};
