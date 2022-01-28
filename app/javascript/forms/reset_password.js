import BaseForm from './base';
import authRepository from '../repositories/auth_repository';

export default class ResetPassword extends BaseForm {
  resetPasswordToken = null;
  fields = {
    password: '',
    passwordConfirmation: '',
  };

  constructor(resetPasswordToken) {
    super();
    this.resetPasswordToken = resetPasswordToken;
  }

  action() {
    return authRepository.resetPassword({
      user: {
        ...this.fields,
        resetPasswordToken: this.resetPasswordToken,
      },
    });
  }
}
