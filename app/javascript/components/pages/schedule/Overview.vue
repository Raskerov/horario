<template>
  <div>
    <ScheduleSelector v-model="selectedSchedule" />

    <v-calendar
      v-if="selectedSchedule"
      :attributes="scheduleAttributes"
      is-expanded
    />
  </div>
</template>

<script>
import ScheduleSelector from "../../elements/common/ScheduleSelector";

export default {
  components: { ScheduleSelector },
  data() {
    return {
      selectedSchedule: null,
    };
  },
  computed: {
    scheduleAttributes() {
      return [
        {
          dates: { weekdays: this.scheduleWeekdays },
          bar: {
            color: 'red',
          },
          popover: {
            label: `${this.selectedSchedule.name} ${this.selectedSchedule.startHour} - ${this.selectedSchedule.endHour}`,
          },
        }
      ]
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
  /deep/ .vc-day  {
    height: 75px;
  }

  /deep/ .vc-day-content {
    height: 100%;
    width: 75%;
    border-radius: 0;

    &:hover {
      background-color: #f6d9db;
    }
  }
</style>
