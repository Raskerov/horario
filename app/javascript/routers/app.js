import Vue from 'vue';
import VueRouter from 'vue-router';
import Dashboard from '../components/pages/Dashboard.vue';
import AdminPanel from '../components/pages/AdminPanel.vue';

Vue.use(VueRouter);

const app = new VueRouter({
    mode: 'history',
    base: '/app',
    routes: [
        {
            path: '/',
            name: 'dashboard',
            component: Dashboard,
        },
        {
            path: '/admin',
            name: 'admin',
            component: AdminPanel,
        },
    ],
});

Vue.router = app;

export default app;
