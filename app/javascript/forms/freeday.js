import BaseForm from './base';
import freedays_repository from "../repositories/freedays_repository";

export default class Freeday extends BaseForm {
  fields = {
    user: null,
    dates: null,
    reason: null,
  }

  action() {
    const params = {
      userId: this.fields.user.id,
      startDate: this.fields.dates.start,
      endDate: this.fields.dates.end,
      reason: this.fields.reason.type,
    }

    return freedays_repository.create(params);
  }
}
