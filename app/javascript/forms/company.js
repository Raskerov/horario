import BaseForm from './base';
import companyRepository from '../repositories/company_repository';

export default class Company extends BaseForm {
  fields = {
    name: ''
  };

  action() {
    return companyRepository.update(this.fields);
  }
}
