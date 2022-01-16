<template>
  <form @submit.prevent="sendInvite">
    <InputBuilder
        class="form__input"
        v-model.lazy="form.fields.email"
        name="email"
        :label="$t('users.invite.label')"
        :placeholder="$t('users.invite.placeholder')"
        :errors="[]"
    />

    <button type="submit" class="button">
      {{ $t('users.invite.submit') }}
    </button>
  </form>
</template>

<script>
import InputBuilder from "../common/InputBuilder";
import InputError from "../common/InputError";
import InvitationForm from "../../../forms/invitation"

export default {
  components: {
    InputBuilder,
    InputError
  },
  data() {
    return {
      form: new InvitationForm(),
    };
  },
  methods: {
    async sendInvite() {
      await this.form.submit();
      await this.$store.dispatch('company/getCompanyUsers');
      this.form.fields.email = '';
    },
  },

}
</script>
<style lang="scss" scoped>
  .form__input {
    margin-top: 15px;
    margin-bottom: 15px;
  }
</style>
