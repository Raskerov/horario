import Vue from 'vue';
import VueAxios from 'vue-axios';
import httpClient from './utils/http_client';
import router from './routers/app';
import i18n from './config/i18n';

import App from './components/App.vue';
import auth from './utils/auth';

Vue.use(VueAxios, httpClient);
Vue.axios.defaults.baseURL = '/api/';

Vue.use(auth, {});

const app = new Vue({
  router,
  i18n,
  render: h => h(App),
}).$mount('#app');

export default app;
