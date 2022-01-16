import BaseForm from './base';
import employeesRepository from '../repositories/employees_repository';

export default class Invitation extends BaseForm {
  fields = {
    email: '',
  };

  action() {
    return employeesRepository.create(this.fields);
  }
}
