import BaseForm from './base';
import authRepository from '../repositories/auth_repository';

export default class Login extends BaseForm {
  errors = []

  fields = {
    email: '',
    password: '',
  }

  clearErrors() {
    this.errors = [];
  }

  action() {
    return authRepository.signIn({ user: this.fields });
  }
}
