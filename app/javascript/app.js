import Vue from 'vue';
import VueAxios from 'vue-axios';
import VueSimpleAlert from 'vue-simple-alert';
import VCalendar from 'v-calendar';
import VueTimepicker from 'vue2-timepicker';
import 'vue2-timepicker/dist/VueTimepicker.css'
import vSelect from 'vue-select';
import 'vue-select/dist/vue-select.css';

import httpClient from './utils/http_client';
import router from './routers/app';
import i18n from './config/i18n';

import App from './components/App.vue';
import store from './store';
import auth from './utils/auth';
import roles from './utils/roles';

Vue.use(VueAxios, httpClient);
Vue.axios.defaults.baseURL = '/api/';

Vue.use(auth, {});
Vue.use(roles, {});
Vue.use(VueSimpleAlert);
Vue.use(VCalendar);
Vue.use(VueTimepicker);
Vue.component('v-timepicker', VueTimepicker)
Vue.component('v-select', vSelect)

const app = new Vue({
  router,
  store,
  i18n,
  render: h => h(App),
}).$mount('#app');

export default app;
