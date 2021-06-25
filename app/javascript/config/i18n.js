import Vue from 'vue';
import VueI18n from 'vue-i18n';
import plLocale from '../../../config/locales/pl.yml';

Vue.use(VueI18n);

const i18n = new VueI18n({
  locale: 'pl',
  fallbackLocale: 'pl',
  messages: plLocale,
});

export default i18n;
