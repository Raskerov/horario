<template>
  <div class="forgot-password">
    <div class="forgot-password__welcome">
      {{ $t('forgot_password.welcome') }}
    </div>
    <div class="forgot-password__info">
      {{ $t('forgot_password.info') }}
    </div>
<!--    <ResetPasswordForm @success="$emit('success', $event)" />-->
  </div>
</template>
<script>
// import ResetPasswordForm from '../../elements/auth/login/ResetPasswordForm.vue';

export default {
  components: {
    // ResetPasswordForm,
  },
};
</script>
<style lang="scss" scoped>
  .forgot-password {
    text-align: center;
    padding-top: 100px;

    &__welcome {
      font-size: 36px;
      margin-bottom: 20px;
    }

    &__info {
      font-size: 16px;
      margin-bottom: 20px;
    }
  }
</style>
