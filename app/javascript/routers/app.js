import Vue from 'vue';
import VueRouter from 'vue-router';
import Dashboard from '../components/pages/Dashboard.vue';

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
    ],
});

Vue.router = app;

export default app;
