<template>
  <div v-if="form.currentData" class="accept-invitation-form">
    <div class="accept-invitation__description">
      {{ $t('register.invitation', { company: form.currentData.company }) }}
    </div>

    <InputBuilder
        v-model.lazy="form.fields.fullName"
        name="fullName"
        :label="$t('register.full_name.label')"
        :placeholder="$t('register.full_name.placeholder')"
        :errors="form.errors.fullName"
        required
    />

    <div class="accept-invitation__info--label">
      {{ $t('register.email.label') }}
    </div>
    <div class="accept-invitation__info--detail">
      {{ form.currentData.email }}
    </div>

    <div class="accept-invitation__info--description">
      {{ $t('register.edit_email') }}
    </div>

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

    <button class="button" @click="submit">
      {{ $t('register.create_account') }}
    </button>
  </div>
</template>

<script>
import InputBuilder from "../common/InputBuilder";
import AcceptInvitationForm from '../../../forms/accept_invitation';

export default {
  components: {
    InputBuilder,
  },
  data() {
    return {
      form: new AcceptInvitationForm(this.$route.params.token),
    };
  },
  methods: {
    async submit() {
      await this.form.submit();

      if (this.form.success) {
        this.$router.push({ name: 'login' });
      }
    },
  },
};
</script>

<style lang="scss" scoped>
  @import '../../../assets/styles/button';

  .accept-invitation-form {
    width: 400px;
    margin: 0 auto;
  }

  .accept-invitation__description {
    font-size: 14px;
    font-weight: normal;
    margin-bottom: 15px;
  }

  .accept-invitation__info {
    &--label {
      width: fit-content;
      display: inline-block;
      font-size: 14px;
      font-weight: 500;
      margin-bottom: 5px;
      position: relative;
    }

    &--detail {
      background: #ffffff;
      border-radius: 22px;
      font-size: 14px;
      font-weight: 500;
      padding: 0 20px;
      width: calc(100% - 44px);
      height: 21px;
    }

    &--description {
      width: fit-content;
      display: inline-block;
      font-size: 12px;
      font-weight: normal;
      margin-bottom: 10px;
      position: relative;
    }
  }

  .button {
    margin-bottom: 25px;
  }
</style>
