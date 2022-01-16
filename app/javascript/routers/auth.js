import Vue from 'vue';
import VueRouter from 'vue-router';

import AuthLogin from '../components/pages/auth/Login.vue';
import AuthLoginWrap from '../components/pages/auth/LoginWrap.vue';
import AuthRegister from '../components/pages/auth/Register.vue';
import AuthForgotPassword from '../components/pages/auth/ForgotPassword.vue';
import EmployeeAcceptInvitation from '../components/pages/auth/EmployeeAcceptInvitation.vue';

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
    {
      path: '/forgot_password',
      name: 'forgot_password',
      component: AuthForgotPassword,
    },
    {
      path: '/accept_invitations/:token',
      name: 'accept_invitations',
      component: EmployeeAcceptInvitation,
    },
  ],
});
Vue.router = app;

export default app;
