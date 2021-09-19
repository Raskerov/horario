<template>
  <div>
    <div class="section-title">
      {{ $t('users.title') }}
    </div>
    <div class="users-table">
      <div class="users-table__row users-table__row--headers">
        <div
            v-for="column in columns"
            :key="`header${column}`"
            class="users-table__column"
            :class="`users-table__column--${column}`"
        >
          {{ $t(`users.table_headers.${column}`) }}
        </div>
      </div>
      <div v-for="user in users" :key="user.id" class="users-table__row">
        <div
            v-for="column in columns"
            :key="column"
            class="users-table__column"
            :class="`users-table__column--${column}`"
        >
          <div v-if="column === 'status'">
            USER STATUS
          </div>
          <div v-else-if="column === 'actions'">
            CTA BUTTONS
          </div>
          <div v-else>
            {{ user[column] }}
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { mapState } from 'vuex';

export default {
  computed: {
    ...mapState({
      companyUsers: state => state.company.users,
    }),
    columns() {
      return ['status', 'fullName', 'actions'];
    },
    users() {
      return this.companyUsers;
    },
  },
  created() {
    this.$store.dispatch('company/getCompanyUsers');
  }
}
</script>

<style lang="scss" scoped>
  .users-table {
    margin-top: 15px;
    box-sizing: border-box;
    width: 100%;
  }

  .users-table__row {
    box-sizing: border-box;
    height: 50px;
    line-height: 50px;
    width: 100%;
    display: flex;
    flex-direction: row;
    overflow: hidden;

    &:first-child {
      border-radius: 12px 12px 0 0;
    }

    &:last-child {
      border-radius: 0 0 12px 12px;
    }

    &--headers {
      background-color: #730E15;
      color: #FFFFFF;
    }

    &:nth-child(2n+3) {
      background: #ee7e85;
    }

    &:nth-child(even) {
      background: #f6bec3;
    }
  }

  .users-table__column {
    padding: 0 15px;

    &--status {
      width: 15%;
      overflow-x: scroll;
    }

    &--fullName {
      width: 60%;
      overflow-x: scroll;
    }

    &--actions {
      width: 25%;
      overflow-x: scroll;
    }
  }
</style>
