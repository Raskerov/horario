import BaseForm from './base';
import authRepository from '../repositories/auth_repository';

export default class ForgotPassword extends BaseForm {
  fields = {
    email: '',
  };

  action() {
    return authRepository.forgotPassword({ user: this.fields });
  }
}
