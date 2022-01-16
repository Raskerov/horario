import BaseForm from './base';
import employeesRepository from '../repositories/employees_repository';

export default class AcceptInvitation extends BaseForm {
  token = null
  currentData = null
  fields = {
    password: '',
    passwordConfirmation: '',
    fullName: '',
  }

  constructor(token) {
    super();
    this.token = token;
    employeesRepository.checkConfirmation(token)
        .then((data) => {
          this.currentData = data;
        });
  }

  action() {
    return employeesRepository.register({
      token: this.token,
      params: this.fields,
    });
  }
}
