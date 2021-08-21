<template>
  <div>
    <div>
      <RegisterForm />
    </div>

    <div>
      {{ $t('register.already_have_account') }}
      <RouterLink :to="{name: 'login'}" class="login-header__link">
        {{ $t('register.sign_in') }}
      </RouterLink>
    </div>
  </div>
</template>

<script>
import RegisterForm from '../../elements/auth/register/RegisterForm.vue';

export default {
  components: {
    RegisterForm,
  },
};
</script>
