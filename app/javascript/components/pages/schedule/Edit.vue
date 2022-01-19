<template>
  <div>
    <ScheduleSelector v-model="selectedSchedule" />
    <form v-if="selectedSchedule" class="edit-form" @submit.prevent="createSchedule">
      <InputBuilder
          v-model.lazy="form.fields.name"
          name="name"
          :label="$t('schedule.form.name')"
          :errors="form.errors.name"
          required
      />

      <div class="edit-form__hour-pickers">
        <div class="edit-form__hour-picker">
          <div class="edit-form__label">
            {{ $t('schedule.form.start_hour') }}
          </div>
          <vue-timepicker format="HH:mm" v-model="form.fields.startHour" minute-interval="15"/>
        </div>
        <div class="edit-form__hour-picker">
          <div class="edit-form__label">
            {{ $t('schedule.form.end_hour') }}
          </div>
          <vue-timepicker format="HH:mm" v-model="form.fields.endHour" minute-interval="15"/>
        </div>
      </div>

      <div class="edit-form__checkboxes">
        <div class="edit-form__label">
          {{ $t('schedule.form.weekdays_label') }}
        </div>
        <div v-for="day in weekdays">
          <input type="checkbox" :checked="weekdaySelected(day)" @change="updateWeekdays($event.target.checked, day)">
          <label :for="day">{{ $t(`schedule.form.weekdays.${day}`) }}</label>
        </div>
      </div>

      <div class="edit-form__checkboxes">
        <div class="edit-form__label">
          {{ $t('schedule.form.workers') }}
        </div>
        <div v-for="worker in workers">
          <input type="checkbox" :checked="workerSelected(worker)" @change="updateWorkers($event.target.checked, worker)">
          <label :for="worker">{{ workerName(worker) }}</label>
        </div>
      </div>

      <button type="submit" class="button edit-form__submit-button">
        {{ $t('schedule.form.update') }}
      </button>

      <button class="button button--reverse-color edit-form__submit-button" @click="deleteSchedule">
        {{ $t('schedule.form.delete') }}
      </button>
    </form>
  </div>
</template>

<script>
import {mapState} from "vuex";
import _ from "lodash";
import InputBuilder from "../../elements/common/InputBuilder";
import VueTimepicker from 'vue2-timepicker/src/vue-timepicker.vue'
import ScheduleForm from "../../../forms/schedule_edit";
import ScheduleSelector from "../../elements/common/ScheduleSelector";
import schedule_repository from "../../../repositories/schedule_repository";

export default {
  components: { ScheduleSelector, InputBuilder, VueTimepicker },
  data() {
    return {
      form: new ScheduleForm(),
      selectedSchedule: null,
    };
  },
  async created() {
    await this.$store.dispatch('company/getCompanyUsers');
  },
  computed: {
    ...mapState({
      users: state => state.company.users,
    }),
    weekdays() {
      return ['monday', 'tuesday', 'wednesday', 'thursday', 'friday', 'saturday', 'sunday'];
    },
    workers() {
      return _.filter(this.users, (user) => {
        return (user.role !== 'owner') && user.joined
      });
    }
  },
  watch: {
    selectedSchedule(schedule) {
      this.form.assign(schedule);
    },
  },
  methods: {
    async createSchedule() {
      await this.form.submit();
      this.$router.push({name: 'schedule_overview'})
    },
    weekdaySelected(day) {
      return _.includes(this.form.fields.weekdays, day);
    },
    updateWeekdays(value, day) {
      if (value) {
        this.form.fields.weekdays.push(day);
      } else {
        _.pull(this.form.fields.weekdays, day);
      }
    },
    workerSelected(worker) {
      return _.includes(this.form.fields.userIds, worker.id);
    },
    updateWorkers(value, worker) {
      if (value) {
        this.form.fields.userIds.push(worker.id);
      } else {
        _.pull(this.form.fields.userIds, worker.id);
      }
    },
    workerName(worker) {
      if (worker.role === 'manager') {
        return `${worker.fullName} (${ this.$t('users.roles.manager') })`
      }
      return worker.fullName;
    },
    async deleteSchedule() {
      await schedule_repository.destroy(this.selectedSchedule.id)
    }
  },
}
</script>

<style lang="scss" scoped>
  .edit-form {
    &__hour-pickers {
       display: flex;
       flex-direction: row;
       margin-bottom: 15px;
     }

    &__hour-picker {
       display: flex;
       flex-direction: column;
       margin-right: 30px;
     }

    &__label {
       font-size: 14px;
       font-weight: 500;
       margin-bottom: 10px;
     }

    &__checkboxes {
      margin-bottom: 25px;
    }

    &__submit-button {
      margin-right: 25px;
    }
  }
</style>
