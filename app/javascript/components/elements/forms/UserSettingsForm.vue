<template>
  <form @submit.prevent="update" class="register-form">
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

    <button type="submit" class="button register-form__button">
      {{ $t('settings.update_user') }}
    </button>
  </form>
</template>

<script>
import InputBuilder from "../common/InputBuilder";
import InputError from "../common/InputError";
import ProfileForm from "../../../forms/profile";
import usersRepository from "../../../repositories/users_repository";

export default {
  components: {
    InputBuilder,
    InputError
  },
  data() {
    return {
      form: new ProfileForm(),
    };
  },
  methods: {
    async update() {
      const updatedUser = await this.form.submit();
      this.form.assign(_.pick(updatedUser, ['fullName', 'email', 'companyName']));
    },
  },
  async created() {
    const userData = await usersRepository.show()
    this.form.assign(_.pick(userData, ['fullName', 'email', 'companyName']));
  }
}
</script>

<style lang="scss" scoped>

</style>
