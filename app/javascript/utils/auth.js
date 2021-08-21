import usersRepository from '../repositories/users_repository';
import authRepository from '../repositories/auth_repository';

class Auth {
  userData = null
  loaded = false
  loading = null

  constructor() {
    this.fetch();
  }

  wait() {
    return this.loading;
  }

  get ready() {
    return this.loaded;
  }

  get user() {
    return this.userData;
  }

  setUser(data) {
    this.userData = data;
  }

  fetch() {
    this.loading = new Promise(async (resolve) => {
      this.userData = await usersRepository.show();
      this.loaded = true;
      resolve();
    });
    return this.loading;
  }

  /* eslint-disable class-methods-use-this */
  logout() {
    return authRepository.signOut();
  }
}

export default {
  install(Vue) {
    const auth = Vue.observable(new Auth());

    Vue.auth = auth;
    Vue.prototype.$auth = auth;
  },
};
