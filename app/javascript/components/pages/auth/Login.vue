<template>
  <div class="login">
    <div class="login__welcome">
      {{ $t('login.welcome_back') }}
    </div>
    <LoginForm @success="$emit('success', $event)" />
  </div>
</template>
<script>
import LoginForm from '../../elements/auth/login/LoginForm.vue';

export default {
  components: {
    LoginForm,
  },
};
</script>
<style lang="scss" scoped>
  .login {
    text-align: center;
    padding-top: 100px;

    &__welcome {
      font-size: 36px;
      margin-bottom: 20px;
    }
  }
</style>
