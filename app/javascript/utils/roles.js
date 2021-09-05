function hasRole(role) {
  return this.$auth.user.role === role;
}

export default {
  install(Vue) {
    Vue.hasRole = hasRole;
    Vue.prototype.$hasRole = hasRole;
  },
};
