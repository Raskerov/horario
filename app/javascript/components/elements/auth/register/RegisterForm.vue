<template>
  <form @submit.prevent="register">
    <InputBuilder
      v-model.lazy="form.fields.fullName"
      name="fullName"
      :label="$t('register.full_name.label')"
      :placeholder="$t('register.full_name.placeholder')"
      :errors="form.errors.fullName"
      required
    />

    <InputBuilder
      name="email"
      v-model.lazy="form.fields.email"
      :label="$t('register.email.label')"
      :placeholder="$t('register.email.placeholder')"
      :errors="form.errors.email"
      required
    />

    <InputBuilder
      v-model.lazy="form.fields.password"
      name="password"
      :label="$t('register.password.label')"
      :placeholder="$t('register.password.placeholder')"
      :errors="form.errors.password"
      type="password"
      required
    />

    <InputBuilder
      v-model.lazy="form.fields.passwordConfirmation"
      name="passwordConfirmation"
      :label="$t('register.password_confirmation.label')"
      :placeholder="$t('register.password_confirmation.placeholder')"
      :errors="form.errors.passwordConfirmation"
      type="password"
      required
    />

    <InputBuilder
      v-model.lazy="form.fields.company"
      name="company"
      :label="$t('register.company.label')"
      :placeholder="$t('register.company.placeholder')"
      :errors="form.errors.company"
    />

    <button type="submit">
      {{ $t('register.create_account') }}
    </button>
  </form>
</template>
<script>
import InputBuilder from '../../common/InputBuilder.vue';
import InputError from '../../common/InputError.vue';
import RegisterForm from '../../../../forms/register';

export default {
  components: {
    InputBuilder,
    InputError,
  },
  data() {
    return {
      form: new RegisterForm(),
    };
  },
  methods: {
    async register() {
      await this.form.submit();

      if (this.form.success) {
        this.$router.push({ name: 'registration_successful' });
      }
    },
  },
};
</script>

<style lang="scss" scoped>
</style>
