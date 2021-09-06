<template>
  <form @submit.prevent="update">
    <InputBuilder
        v-model.lazy="form.fields.currentPassword"
        name="currentPassword"
        :label="$t('settings.fields.current_password.label')"
        :placeholder="$t('settings.fields.current_password.placeholder')"
        :errors="form.errors.currentPassword"
        type="password"
        autofocus
    />

    <InputBuilder
        v-model.lazy="form.fields.password"
        name="password"
        :label="$t('settings.fields.password.label')"
        :placeholder="$t('settings.fields.password.placeholder')"
        :errors="form.errors.password"
        type="password"
    />

    <InputBuilder
        v-model.lazy="form.fields.passwordConfirmation"
        name="passwordConfirmation"
        :label="$t('settings.fields.password_confirmation.label')"
        :placeholder="$t('settings.fields.password_confirmation.placeholder')"
        :errors="form.errors.passwordConfirmation"
        type="password"
    />

    <button type="submit" class="button">
      {{ $t('settings.update_user') }}
    </button>
  </form>
</template>

<script>
import InputBuilder from "../common/InputBuilder";
import InputError from "../common/InputError";
import PasswordForm from '../../../forms/password';

export default {
  components: {
    InputBuilder,
    InputError
  },
  data() {
    return {
      form: new PasswordForm(),
    };
  },
  methods: {
    async update() {
      await this.form.submit();

      if (this.form.success) {
        this.form = new PasswordForm();
      }
    },
  },

}
</script>
