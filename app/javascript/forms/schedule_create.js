import BaseForm from './base';
import scheduleRepository from '../repositories/schedule_repository';

export default class ScheduleCreate extends BaseForm {
  fields = {
    name: '',
    startHour: '00:00',
    endHour: '00:00',
    weekdays: [],
    userIds: [],
  };

  action() {
    this.fields.weekdays = this.fields.weekdays.toString()

    return scheduleRepository.create(this.fields);
  }
}
