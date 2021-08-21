import BaseForm from './base';
import authRepository from '../repositories/auth_repository';

export default class Register extends BaseForm {
  fields = {
    email: '',
    password: '',
    passwordConfirmation: '',
    company: '',
    fullName: '',
  }

  constructor() {
    super();
  }

  action() {
    return authRepository.signUp({ user: { ...this.fields } });
  }
}
