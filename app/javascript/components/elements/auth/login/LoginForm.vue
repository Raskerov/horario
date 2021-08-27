<template>
  <form @submit.prevent="login" class="login-form">
    <InputBuilder
      name="email"
      v-model.lazy="form.fields.email"
      :label="$t('login.email')"
      :placeholder="$t('login.email')"
      required
    />

    <InputBuilder
      name="password"
      v-model.lazy="form.fields.password"
      :label="$t('login.password')"
      :placeholder="$t('login.password')"
      type="password"
      required
    />

    <div class="login-form__forgot-password">
      <RouterLink :to="{name: 'forgot_password'}">
        {{ $t('login.forgot_password') }}
      </RouterLink>
    </div>

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
  .login-form {
    width: 400px;
    margin: 0 auto;
  }

  .login-form__forgot-password {
    width: 100%;
    text-align: right;
    margin-top: -27px;
  }
</style>
