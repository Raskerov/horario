<template>
  <div>
    <div class="item section-title">
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
</style>
