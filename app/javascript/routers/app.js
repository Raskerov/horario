import Vue from 'vue';
import VueRouter from 'vue-router';
import Dashboard from '../components/pages/Dashboard.vue';
import Settings from '../components/pages/Settings.vue'
import SettingsProfile from "../components/pages/settings/Profile";
import SettingsPassword from "../components/pages/settings/Password";
import SettingsCompany from "../components/pages/settings/Company";
import SettingsInvitations from "../components/pages/settings/Invitations";

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
            path: '/settings',
            name: 'settings',
            component: Settings,
            children: [
                {
                    path: 'profile',
                    name: 'settings_profile',
                    component: SettingsProfile,
                },
                {
                    path: 'password',
                    name: 'settings_password',
                    component: SettingsPassword,
                },
                {
                    path: 'company',
                    name: 'settings_company',
                    component: SettingsCompany,
                },
                {
                    path: 'invitations',
                    name: 'settings_invitations',
                    component: SettingsInvitations,
                },
            ],
        },
    ],
});

Vue.router = app;

export default app;
