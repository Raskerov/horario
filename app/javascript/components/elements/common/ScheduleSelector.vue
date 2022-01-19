<template>
  <div class="selector">
    <div class="selector__title">
      {{ $t('schedule.select_schedule') }}
    </div>
    <div :class="value ? 'schedules-container--selected' : null">
      <div
          v-for="schedule in schedules"
          :key="schedule.name"
          class="selector__schedule"
          :class="selectedSchedule(schedule)"
          @click="selectSchedule(schedule)"
      >
        <div class="selector__schedule__property">
          <div class="property__name">
            {{ $t('schedule.form.name')}}
          </div>
          <div class="property__value">
            {{ schedule.name }}
          </div>
        </div>

        <div class="selector__schedule__property">
          <div class="property__name">
            {{ $t('schedule.hours')}}
          </div>
          <div class="property__value">
            {{ scheduleHours(schedule) }}
          </div>
        </div>

        <div class="selector__schedule__property">
          <div class="property__name">
            {{ $t('schedule.days')}}
          </div>
          <div class="property__value">
            {{ scheduleDays(schedule) }}
          </div>
        </div>

        <div class="selector__schedule__property">
          <div class="property__name">
            {{ $t('schedule.workers_amount')}}
          </div>
          <div class="property__value">
            {{ schedule.userIds.length }}
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import schedule_repository from "../../../repositories/schedule_repository";

export default {
  props: {
    value: {
      type: Object,
    },
  },
  data() {
    return {
      schedules: [],
    }
  },
  async created() {
    this.schedules = await schedule_repository.index();
  },
  methods: {
    scheduleHours(schedule) {
      return `${schedule.startHour} - ${schedule.endHour}`
    },
    scheduleDays(schedule) {
      return schedule.weekdays.map((day) => {
        return this.$t(`schedule.form.weekdays.${day}`);
      }).join(' ');
    },
    selectSchedule(schedule) {
      this.$emit('input', schedule)
    },
    selectedSchedule(schedule) {
      if (schedule === this.value) {
        return 'selector__schedule--selected';
      }
    },
  },
}
</script>

<style lang="scss" scoped>
  .schedules-container--selected {
    height: 100px;
    overflow-y: scroll;
  }

  .selector {
    margin-bottom: 30px;

    &__title {
      font-size: 22px;
      font-weight: 500;
      margin-bottom: 30px;
    }

    &__schedule {
      padding: 10px;
      display: flex;
      flex-direction: row;
      border-radius: 12px;

      &:hover {
        background-color: #f6bec3;
        cursor: pointer;
      }

      &--selected {
        background-color: #bf7275 !important;
      }

      &__property {
        display: flex;
        flex-direction: column;
        width: 25%;
        margin-bottom: 15px;
      }
    }
  }

  .property__name {
    font-size: 16px;
    font-weight: 500;
    margin-bottom: 10px;
  }

  .property__value {
    padding: 0 10px 0 0;
  }
</style>
