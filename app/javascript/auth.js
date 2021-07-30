import Auth from './components/Auth.vue';
import router from './routers/auth';
import i18n from './config/i18n';
import Vue from 'vue';
import VueAxios from 'vue-axios';
import httpClient from './utils/http_client';

Vue.use(VueAxios, httpClient);
Vue.axios.defaults.baseURL = '/api/';

window.EventBus = new Vue();

const app = new Vue({
  router,
  i18n,
  render: h => h(Auth),
}).$mount('#auth');

export default app;
