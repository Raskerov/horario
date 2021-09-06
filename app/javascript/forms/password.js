import BaseForm from './base';
import authRepository from '../repositories/auth_repository';

export default class ChangePassword extends BaseForm {
  fields = {
    currentPassword: '',
    password: '',
    passwordConfirmation: '',
  };

  action() {
    return authRepository.changePassword({ user: this.fields });
  }
}
