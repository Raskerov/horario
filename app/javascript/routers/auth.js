import Vue from 'vue';
import VueRouter from 'vue-router';

import AuthLogin from '../components/pages/auth/Login.vue';
import AuthLoginWrap from '../components/pages/auth/LoginWrap.vue';
import AuthRegister from '../components/pages/auth/Register.vue';

Vue.use(VueRouter);

const app = new VueRouter({
  mode: 'history',
  base: '/auth',
  routes: [
    {
      path: '/',
      redirect: '/login',
    },
    {
      path: '/login',
      component: AuthLoginWrap,
      children: [
        {
          path: '',
          component: AuthLogin,
          name: 'login',
        },
      ],
    },
    {
      path: '/register',
      name: 'register',
      component: AuthRegister,
    },
  ],
});
Vue.router = app;

export default app;
