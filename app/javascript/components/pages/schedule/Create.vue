<template>
  <div>
    <form class="create-form" @submit.prevent="createSchedule">
      <InputBuilder
        v-model.lazy="form.fields.name"
        name="name"
        :label="$t('schedule.form.name')"
        :errors="form.errors.name"
        required
      />

      <div class="create-form__hour-pickers">
        <div class="create-form__hour-picker">
          <div class="create-form__label">
            {{ $t('schedule.form.start_hour') }}
          </div>
          <v-timepicker format="HH:mm" v-model="form.fields.startHour" minute-interval="15"/>
        </div>
        <div class="create-form__hour-picker">
          <div class="create-form__label">
            {{ $t('schedule.form.end_hour') }}
          </div>
          <v-timepicker format="HH:mm" v-model="form.fields.endHour" minute-interval="15"/>
        </div>
      </div>

      <div class="create-form__checkboxes">
        <div class="create-form__label">
          {{ $t('schedule.form.weekdays_label') }}
        </div>
        <div v-for="day in weekdays">
          <input :id='day' type="checkbox" :checked="weekdaySelected(day)" @change="updateWeekdays($event.target.checked, day)">
          <label :for="day">{{ $t(`schedule.form.weekdays.${day}`) }}</label>
        </div>
      </div>

      <div class="create-form__checkboxes">
        <div class="create-form__label">
          {{ $t('schedule.form.workers') }}
        </div>
        <div v-for="worker in workers">
          <input :id="`worker_${worker.id}`" type="checkbox" :checked="workerSelected(worker)" @change="updateWorkers($event.target.checked, worker)">
          <label :for="worker">{{ workerName(worker) }}</label>
        </div>
      </div>

      <button type="submit" class="button">
        {{ $t('schedule.form.create') }}
      </button>
    </form>
  </div>
</template>

<script>
import _ from 'lodash';
import {mapState} from "vuex";
import InputBuilder from "../../elements/common/InputBuilder";
import VueTimepicker from 'vue2-timepicker/src/vue-timepicker.vue'
import ScheduleForm from "../../../forms/schedule_create";

export default {
  components: { InputBuilder, VueTimepicker },
  data() {
    return {
      form: new ScheduleForm(),
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
    }
  },
}
</script>

<style lang="scss" scoped>
  .create-form {
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
  }
</style>
