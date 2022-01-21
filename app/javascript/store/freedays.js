import freedaysRepository from "../repositories/freedays_repository";

const getters = {};

const mutations = {
  setFreedays(state, freedays) {
    state.freedays = freedays;
  },
};

const actions = {
  async getFreedays(context) {
    const freedays = await freedaysRepository.index();

    context.commit('setFreedays', freedays);
  },
};

export default {
  namespaced: true,
  state: {
    freedays: [],
  },
  getters,
  mutations,
  actions,
};
