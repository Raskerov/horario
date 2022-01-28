<template>
  <form @submit.prevent="submit">
    <InputBuilder
      v-model.lazy="form.fields.password"
      name="password"
      :label="$t('reset_password.password.label')"
      :placeholder="$t('reset_password.password.placeholder')"
      :errors="form.errors.password"
      type="password"
      class="input-settings"
      required
    />

    <InputBuilder
      v-model.lazy="form.fields.passwordConfirmation"
      name="passwordConfirmation"
      :label="$t('reset_password.passwordConfirmation.label')"
      :placeholder="$t('reset_password.passwordConfirmation.placeholder')"
      :errors="form.errors.passwordConfirmation"
      type="password"
      class="input-settings"
      required
    />

    <button
      class="button button__primary"
      type="submit"
    >
      {{ $t('reset_password.reset_password') }}
    </button>
  </form>
</template>

<script>
import InputBuilder from "../../elements/common/InputBuilder";

export default {
  components: {
    InputBuilder,
  },
  data() {
    return {
      form: new ResetPasswordForm(this.$route.params.token),
    };
  },
  methods: {
    async submit() {
      if (this.form.loading) {
        return;
      }

      await this.form.submit();

      if (this.form.success) {
        this.$router.push({ name: 'login' });
      }
    },
  },
};
</script>

<style lang="scss">
  .reset-password-form__container {
    width: 400px;
    padding: 20px;

    @media only screen and (max-width: 425px) {
      width: 300px;
    }
  }
</style>
