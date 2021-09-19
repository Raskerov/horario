<template>
  <div class="dashboard">
    <div class="item dashboard__welcome">
      {{ $t('dashboard.welcome', { user_name: $auth.user.fullName }) }}
    </div>
    <div class="item-row">
      <div class="item item--big">

      </div>
    </div>
  </div>
</template>

<script>
export default {

}
</script>

<style lang="scss" scoped>
  .dashboard {
    padding-bottom: 30px;

    &__welcome {
      font-size: 24px;
      font-weight: bold;
      color: #000000;
      padding: 10px;
      height: 40px;
      line-height: 40px;
      margin-bottom: 10px;
    }
  }
</style>
