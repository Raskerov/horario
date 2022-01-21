import Vue from 'vue';
import Vuex from 'vuex';

import company from './company';
import employees from './employees';
import freedays from "./freedays";

Vue.use(Vuex);

export default new Vuex.Store({
  modules: {
    company,
    employees,
    freedays
  },
});
