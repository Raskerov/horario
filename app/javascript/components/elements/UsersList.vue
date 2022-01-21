<template>
  <div>
    <div class="table">
      <div class="table__row table__row--headers">
        <div
            v-for="column in columns"
            :key="`header${column}`"
            class="table__column"
            :class="`users-table__column--${column}`"
        >
          {{ $t(`users.table_headers.${column}`) }}
        </div>
      </div>
      <div v-for="user in users" :key="user.id" class="table__row">
        <div
            v-for="column in columns"
            :key="column"
            class="table__column"
            :class="`users-table__column--${column}`"
        >
          <div v-if="column === 'role'">
            {{ $t(`users.roles.${user.role}`) }}
          </div>
          <div v-else-if="column === 'actions'" class="users-table__cta">
            <button class="button" @click="choseUserRole(user)">
              {{ $t('users.table.roles') }}
            </button>
            <button class="button" @click="deleteUser(user)">
              {{ $t('users.table.delete') }}
            </button>
          </div>
          <div v-else-if="(column === 'fullName') && !user.joined">
            {{ $t('users.invited_user') }}
          </div>
          <div v-else>
            {{ user[column] }}
          </div>
        </div>
      </div>
    </div>

    <InvitationsForm class="users__invite"/>
  </div>
</template>
<script>
import { mapState } from 'vuex';
import InvitationsForm from "./forms/InvitationsForm";

export default {
  components: {InvitationsForm},
  computed: {
    ...mapState({
      companyUsers: state => state.company.users,
    }),
    columns() {
      return ['fullName', 'email', 'role', 'actions'];
    },
    users() {
      return this.companyUsers;
    },
    userRoles() {
      return {
        'owner': this.$t('users.roles.owner'),
        'manager': this.$t('users.roles.manager'),
        'worker': this.$t('users.roles.worker'),
      };
    },
  },
  created() {
    this.$store.dispatch('company/getCompanyUsers');
  },
  methods: {
    async choseUserRole(user) {
      this.$fire({
        text: `${this.$t('users.fields.change_role')}`,
        input: 'select',
        inputValue: user.role,
        inputOptions: (this.userRoles || 'worker'),
        showCancelButton: true,
        buttonsStyling: false,
        confirmButtonText: `${this.$t('users.fields.confirm')}`,
        confirmButtonClass: 'button button--alert',
        cancelButtonClass: 'button button--alert button--reverse-color',
        cancelButtonText: `${this.$t('settings.abort')}`
      }).then((input) => {
        this.$store.dispatch('employees/changeRole', { user, role: input.value });
      });
    },
    deleteUser(user) {
      this.$store.dispatch('employees/removeUser', user)
    },
  },
}
</script>

<style lang="scss" scoped>
  .users-table__column {
    &--fullName {
      width: 50%;
      overflow-x: auto;
    }

    &--email {
      width: 20%;
      overflow-x: hidden;
    }

    &--role {
      width: 15%;
      overflow-x: hidden;
    }

    &--actions {
      width: 15%;
      min-width: 210px;
      overflow-x: auto;
    }
  }

  .users-table__cta {
    height: 100%;
    display: flex;
    flex-direction: row;
    align-items: center;
    justify-content: flex-start;

    button {
      margin: 0 5px;

      &:first-child {
        margin-left: 0;
      }
    }
  }

  .users__invite {
    max-width: 400px;
  }
</style>
