import BaseForm from './base';
import users_repository from "../repositories/users_repository";

export default class Profile extends BaseForm {
  fields = {
    email: '',
    fullName: '',
  }

  action() {
    return users_repository.update(this.fields);
  }
}
