<template>
  <div>
    <ScheduleSelector v-model="selectedSchedule" />

    <div class="calendar-wrapper">
      <v-calendar
          v-if="selectedSchedule"
          :attributes="scheduleAttributes"
          is-expanded
      />
    </div>
  </div>
</template>

<script>
import _ from 'lodash';
import ScheduleSelector from "../../elements/common/ScheduleSelector";
import scheduleRepository from "../../../repositories/schedule_repository";

export default {
  components: { ScheduleSelector },
  data() {
    return {
      selectedSchedule: null,
      freedays: null,
    };
  },
  watch: {
    async selectedSchedule(schedule) {
      this.freedays = await scheduleRepository.getFreedays(schedule.id);
    },
  },
  computed: {
    scheduleAttributes() {
      const freedays = _.map(this.freedays, (freeday) => {
        const I18nReason = this.$t(`freedays.reasons.${freeday.reason}`)
        return {
          dates: {
            start: new Date(`${freeday.dates.split(' - ')[0]}`),
            end: new Date(`${freeday.dates.split(' - ')[1]}`)
          },
          bar: {
            color: 'red',
            fillMode: 'light',
          },
          popover: {
            label: `${freeday.user.fullName} - ${I18nReason}`,
          },
        }
      });
      const schedule = [
        {
          dates: { weekdays: this.scheduleWeekdays },
          highlight: {
            color: 'red',
            fillMode: 'light',
          },
          popover: {
            label: `${this.selectedSchedule.name} ${this.selectedSchedule.startHour} - ${this.selectedSchedule.endHour}`,
          },
        },
      ];
      return _.concat(freedays, schedule);
    },
    scheduleWeekdays() {
      const weekdaysMap = {
        'sunday': 1,
        'monday': 2,
        'tuesday': 3,
        'wednesday': 4,
        'thursday': 5,
        'friday': 6,
        'saturday': 7,
      }
      return this.selectedSchedule.weekdays.map((day) => {
        return weekdaysMap[day];
      })
    }
  }
}
</script>

<style lang="scss" scoped>
  .calendar-wrapper {
    width: 75%;
    margin: 0 auto;
  }

  /deep/ .vc-day  {
    height: 50px;
  }

  /deep/ .vc-day-content {
    width: 35px !important;
    height: 35px !important;
    border-radius: 12px !important;

    &:hover {
      background-color: #f6d9db;
    }
  }

  /deep/ .vc-highlight {
    width: 35px !important;
    height: 35px !important;
    border-radius: 12px !important;
  }

  /deep/ .vc-highlight.vc-highlight-base-middle {
    width: 100% !important;
  }

  /deep/ .vc-container {
    --red-200: #f6bec3;
  }
</style>
