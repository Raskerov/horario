<template>
  <div class="invite">
    <div class="invite__welcome">
      {{ $t('register.welcome') }}
    </div>

    <div>
      <AcceptInvitationForm />
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
import AcceptInvitationForm from '../../elements/forms/AcceptInvitationForm.vue';

export default {
  components: {
    AcceptInvitationForm,
  },
};
</script>
<style lang="scss" scoped>
  .invite {
    text-align: center;
    padding-top: 100px;

    &__welcome {
      font-size: 36px;
      margin-bottom: 20px;
    }
  }
</style>
