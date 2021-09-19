<template>
  <div>
    <div class="item dashboard__welcome section-title">
      {{ $t('dashboard.welcome', { user_name: $auth.user.fullName }) }}
    </div>
    <div class="item-row">
      <UsersList class="item item--big" />
    </div>
  </div>
</template>

<script>
import UsersList from "../elements/UsersList";

export default {
  components: { UsersList }
}
</script>

<style lang="scss" scoped>
  .dashboard {
    &__welcome {
      height: 40px;
      line-height: 40px;
      margin-top: 0;
    }
  }
</style>
