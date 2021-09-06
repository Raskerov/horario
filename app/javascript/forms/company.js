import BaseForm from './base';
import companyRepository from '../repositories/company_repository';

export default class ChangePassword extends BaseForm {
  fields = {
    name: ''
  };

  action() {
    return companyRepository.update(this.fields);
  }
}
