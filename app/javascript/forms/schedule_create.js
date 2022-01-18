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
    this.fields.startHour = `${this.fields.startHour.HH}:${this.fields.startHour.mm}`;
    this.fields.endHour = `${this.fields.endHour.HH}:${this.fields.endHour.mm}`;
    this.fields.weekdays = this.fields.weekdays.toString()

    return scheduleRepository.create(this.fields);
  }
}
