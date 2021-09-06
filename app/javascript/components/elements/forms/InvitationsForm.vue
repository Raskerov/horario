<template>
  <form @submit.prevent="update">
<!--    <InputBuilder-->
<!--        v-model.lazy=""-->
<!--        name="fullName"-->
<!--        :label="$t('register.company.label')"-->
<!--        :placeholder="$t('register.company.placeholder')"-->
<!--        :errors="[]"-->
<!--        required-->
<!--    />-->

    <button type="submit" class="button">
      {{ $t('settings.update_user') }}
    </button>
  </form>
</template>

<script>
import InputBuilder from "../common/InputBuilder";
import InputError from "../common/InputError";

export default {
  components: {
    InputBuilder,
    InputError
  },
  data() {
    return {
      // form: new InvitationsForm(),
    };
  },
  methods: {
    async update() {
      //  Handle sending invite
    },
  },

}
</script>
