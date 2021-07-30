<template>
  <div>
    <div>
      {{ $t('login.welcome_back') }}
    </div>
    <div class="overlay__form-wrapper">
      <LoginForm @success="$emit('success', $event)" />
    </div>
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
