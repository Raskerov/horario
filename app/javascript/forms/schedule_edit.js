import BaseForm from './base';
import scheduleRepository from '../repositories/schedule_repository';
import _ from "lodash";

export default class ScheduleEdit extends BaseForm {
  fields = {
    id: null,
    name: '',
    startHour: '00:00',
    endHour: '00:00',
    weekdays: [],
    userIds: [],
  };

  action() {
    this.fields.weekdays = this.fields.weekdays.toString()

    return scheduleRepository.update(this.fields.id, this.fields);
  }
}
