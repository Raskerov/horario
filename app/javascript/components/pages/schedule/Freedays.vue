<template>
  <div>
    <button class="button freedays__add-button" @click="toggleForm">
      {{ formToggleLabel }}
    </button>
    <button v-if="formOpened" class="button" @click="createFreeday()">
      {{ $t('freedays.form.submit') }}
    </button>
    <div v-if="formOpened">
      <form class="freedays__form">
        <div v-if="!userIsWorker" class="freedays__form__label">
          {{ $t('freedays.form.worker') }}
        </div>
        <v-select
          v-if="!userIsWorker"
          v-model="form.fields.user"
          class="freedays__form__select"
          :options="users"
          :clearable="false"
        />

        <div class="freedays__form__label">
          {{ $t('freedays.form.reason') }}
        </div>
        <v-select
          v-model="form.fields.reason"
          :options="reasons"
          class="freedays__form__select"
          :clearable="false"
        />

        <div class="freedays__form__label">
          {{ $t('freedays.form.dates') }}
        </div>
        <v-date-picker
          v-model="form.fields.dates"
          :model-config="datesConfig"
          is-range
        />
      </form>
    </div>
    <div v-else class="table">
      <div class="table__row table__row--headers">
        <div
            v-for="column in columns"
            :key="`header${column}`"
            class="table__column"
            :class="`freedays-table__column--${column}`"
        >
          {{ $t(`freedays.table_headers.${column}`) }}
        </div>
      </div>
      <div v-for="day in freedays" :key="day.id" class="table__row">
        <div
            v-for="column in columns"
            :key="column"
            class="table__column"
            :class="`freedays-table__column--${column}`"
        >
          <div v-if="column === 'user'">
            {{ day.user.fullName }}
          </div>
          <div v-else-if="column === 'dates'">
            {{ day.dates }}
          </div>
          <div v-else-if="column === 'reason'">
            {{ $t(`freedays.reasons.${day.reason}`) }}
          </div>
          <div v-else-if="column === 'status'">
            <button v-if="day.status === 'requested' && $auth.user.managing" class="button" @click="acceptFreeday(day)">
              {{ $t('freedays.accept') }}
            </button>
            <div v-else>
              {{ $t(`freedays.status.${day.statusLabel}`) }}
            </div>
          </div>
          <div v-else-if="column === 'actions'">
            <button v-if="day.status !== 'rejected'" class="button" @click="rejectFreeday(day)">
              {{ deleteLabel(day) }}
            </button>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import _ from 'lodash';
import {mapState} from "vuex";
import InputBuilder from "../../elements/common/InputBuilder";
import FreedayForm from "../../../forms/freeday";
import freedaysRepository from "../../../repositories/freedays_repository";

export default {
  components: { InputBuilder },
  data() {
    return {
      formOpened: false,
      form: new FreedayForm(),
      datesConfig: {
        type: 'string',
        mask: 'YYYY-MM-DD'
      }
    };
  },
  async created() {
    await this.$store.dispatch('company/getCompanyUsers');
    await this.$store.dispatch('freedays/getFreedays');
    this.form.fields.user = { id: this.$auth.user.id, label: this.$auth.user.fullName };
  },
  computed: {
    ...mapState({
      companyUsers: state => state.company.users,
      freedays: state => state.freedays.freedays,
    }),
    joinedUsers() {
      return _.filter(this.companyUsers, user => user.joined);
    },
    users() {
      return _.map(this.joinedUsers, (user) => {
        return { id: user.id, label: user.fullName };
      });
    },
    userIsWorker() {
      return this.$auth.user.role === 'worker';
    },
    columns() {
      return ['user', 'dates', 'reason', 'status', 'actions'];
    },
    reasons() {
      return _.map(['vacation', 'l4', 'on_demand', 'unpaid'], (type) => {
        return { label: this.$t(`freedays.reasons.${type}`), type: type };
      });
    },
    formToggleLabel() {
      if (this.formOpened) {
        return this.$t('freedays.close_form');
      } else {
        if (this.userIsWorker) {
          return this.$t('freedays.add_request');
        }
        return this.$t('freedays.add_freeday');
      }
    }
  },
  methods: {
    toggleForm() {
      this.formOpened = !this.formOpened;
    },
    deleteLabel(day) {
      if (day.user.id === this.$auth.user.id ) {
        return this.$t('freedays.cancel');
      }
      return this.$t('freedays.reject');
    },
    async acceptFreeday(day) {
      await freedaysRepository.update(day.id, { status: 'accepted' })
      await this.$store.dispatch('freedays/getFreedays');
    },
    async rejectFreeday(day) {
      await freedaysRepository.update(day.id, { status: 'rejected' })
      await this.$store.dispatch('freedays/getFreedays');
    },
    async createFreeday() {
      await this.form.submit();
      await this.$store.dispatch('freedays/getFreedays');
      this.formOpened = false;
    }
  }
}
</script>

<style lang="scss" scoped>
  .freedays__add-button {
    margin-bottom: 15px;
  }

  .freedays__form {
    &__label {
      font-size: 14px;
      font-weight: 500;
      margin-bottom: 5px;
    }

    &__select {
      margin-bottom: 20px;
      max-width: 400px;
    }
  }

  .freedays-table__column {
    &--user {
      width: 35%;
      overflow-x: auto;
    }

    &--dates {
      width: 20%;
      overflow-x: auto;
    }

    &--reason {
      width: 20%;
      overflow-x: hidden;
    }

    &--status {
      width: 15%;
      overflow-x: hidden;
    }

    &--actions {
      width: 10%;
      min-width: 100px;
      overflow-x: auto;
    }
  }

  /deep/ .vc-highlights + span {
    color: #fff !important;
  }

  /deep/ .vc-highlight {
    background-color: #730E15 !important;
    border-color: #730E15 !important;
  }

  /deep/ .vc-highlight-base-start,
  /deep/ .vc-highlight-base-middle,
  /deep/ .vc-highlight-base-end {
    color: #fff !important;
    background-color: #bf7275 !important;
  }
</style>
