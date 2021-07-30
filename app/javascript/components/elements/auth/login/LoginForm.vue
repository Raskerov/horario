<template>
  <form @submit.prevent="login">
    <InputBuilder
      name="email"
      :value="form.fields.email"
      :label="$t('login.email')"
      :placeholder="$t('login.email')"
      required
    />

    <RouterLink :to="{name: 'forgot_password'}">
      {{ $t('login.forgot_password') }}
    </RouterLink>

    <InputBuilder
      name="password"
      :value="form.fields.password"
      :label="$t('login.password')"
      :placeholder="$t('login.password')"
      required
    />

    <button type="submit">
      {{ $t('login.sign_in') }}
    </button>

    <div class="login__create-account">
    {{ $t('login.dont_have_account') }}
    <RouterLink :to="{name: 'register'}" class="button__link login-form__create-account-button">
      {{ $t('login.create_account') }}
    </RouterLink>
  </div>
  </form>
</template>

<script>
import LoginForm from '../../../../forms/login';
import InputBuilder from '../../common/InputBuilder.vue';

export default {
  components: {
    InputBuilder,
  },
  data() {
    return {
      form: new LoginForm(),
    };
  },
  methods: {
    async login() {
      const response = await this.form.submit();

      if (this.form.success) {
        this.$emit('success', response);
      }
    },
  },
};
</script>
<style lang="scss" scoped>

</style>
