import BaseForm from './base';
import scheduleRepository from '../repositories/schedule_repository';

export default class ScheduleCreate extends BaseForm {
  fields = {
    name: '',
    startHour: null,
    endHour: null,
    weekdays: [],
    userIds: [],
  };

  action() {
    return scheduleRepository.create(this.fields);
  }
}
