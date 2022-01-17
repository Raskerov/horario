import Vue from 'vue';
import VueRouter from 'vue-router';
import Schedule from '../components/pages/Schedule.vue';
import Settings from '../components/pages/Settings.vue'
import SettingsProfile from "../components/pages/settings/Profile.vue";
import SettingsPassword from "../components/pages/settings/Password.vue";
import SettingsCompany from "../components/pages/settings/Company.vue";
import SettingsInvitations from "../components/pages/settings/Invitations.vue";
import Messages from "../components/pages/Messages.vue";
import Employees from "../components/pages/Employees.vue";

Vue.use(VueRouter);

const app = new VueRouter({
    mode: 'history',
    base: '/app',
    routes: [
        {
            path: '/',
            name: 'schedule',
            component: Schedule,
        },
        {
            path: '/messages',
            name: 'messages',
            component: Messages,
        },
        {
            path: '/employees',
            name: 'employees',
            component: Employees,
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
